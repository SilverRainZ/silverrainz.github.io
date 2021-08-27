========================================
 用户态进程的简单实现及调度(一)
========================================

.. post:: 2015-09-14
   :tags: OS
   :author: LA
   :language: zh_CN


.. hint:: 这是一篇迁移自 Jekyll 的文章，如有格式问题，可到 :ghrepo:`SilverRainZ/bullet` 反馈

.. note:: 在写这篇的时候, 我发觉我很难在这短短一篇博文里把进程的实现将清楚,
   并且可能存在一些理解的偏差, 因此本篇仅供参考, 更加准确的表述,
   还请参考 `第五章 调度 | xv6 中文文档 <https://th0ar.gitbooks.io/xv6-chinese/content/content/chapter5.html>`_

.. contents::

自从上次完成了 :doc:`/blog/minix-v1-file-system` 之后,
就开始看 xv6 中进程相关的代码, 并把它抄进 OS67 中, 到今天为止, 总算是完成地差不多了.

进程的实现可能是 xv6 中耦合度最高的一部分, 在完成大部分的代码
(GDT,TSS 的设置, 上下文保存和切换, 虚拟内存映射, 系统调用)之前,
你很难让你的内核跑起来.

xv6 已经尽量使用容易理解的方式来书写这些代码了, 不过有些地方仍然比较晦涩(对我来说).
希望再这篇文章里能稍微梳理一下.

..

   注意: OS67 并不打算支持多核 CPU, 这极大地降低了实现进程的难度,
   不需要考虑由于多核导致的进程间的竞争和同步, 因此 xv6 中关于锁的代码都可以忽略.


特权级转换
----------

几个关于特权级的概念:


* intel 8086 的特权级分为 0 1 2 3 四级, 这里只使用 0 和 3
* DPL: Descriptor Privilege 描述符特权级, 储存在 GDT 或 IDT 描述符中
* CPL: Current Privilege 当前特权级, 储存在 cs 寄存器的低二位
* RPL: Request Privilege 请求特权级, 请求访问的段的描述符的特权级

GDT
---

这里使用的用户态的特权级为 3, 因此用户态的程序, 其所在的数据段代码段的 DPL,
段寄存器低 2 位的 RPL 都得是 3, 因此设置的 全局段描述符表(GDT) 如下:

.. code:: c

   // OS67/kern/gdt.c
   gdt_install(0, 0, 0, 0, 0);
   /* kernel code segment type: code addr: 0 limit: 4G gran: 4KB sz: 32bit */
   gdt_install(SEL_KCODE, 0, 0xfffff, AC_RW|AC_EX|AC_DPL_KERN|AC_PR, GDT_GR|GDT_SZ);
   /* kernel data segment type: data addr: 0 limit: 4G gran: 4KB sz: bit 32bit */
   gdt_install(SEL_KDATA, 0, 0xfffff, AC_RW|AC_DPL_KERN|AC_PR, GDT_GR|GDT_SZ);
   /* user code segment type: code addr: 0 limit: 4G gran: 4KB sz: 32bit */
   gdt_install(SEL_UCODE, 0, 0xfffff, AC_RW|AC_EX|AC_DPL_USER|AC_PR, GDT_GR|GDT_SZ);
   /* user data segment type: data addr: 0 limit: 4G gran: 4KB sz: 32bit */
   gdt_install(SEL_UDATA, 0, 0xfffff, AC_RW|AC_DPL_USER|AC_PR, GDT_GR|GDT_SZ);

第一二个描述符定义了内核的代码段和数据段, 第三四个描述符定义了用户的代码段和数据段.

..

   注意: 代码段必须是非一致性代码段, 因为一致性代码段对特权级的处理方式不同.


当 GDT 初始化后, 第一二个描述符被使用, 内核跑在特权级为 0 的段上.
那如何让代码从特权级为 0 的段(内核态)转移到特权级为 3 的段(用户态)呢? 用中断.

IDT
---

为了让用户空间的程序顺利进入内核态, 需要对 中断描述符表(IDT) 做一些设置.

(以下内容摘自 xv6 中文文档, 有小改动)

我们假设一个用户态程序执行\ `int n`\ 指令触发中断, 则 CPU 会取得中断号 n, 进行如下步骤:
(由 PIC 或者异常触发的中断不一定如此)


#. 从 中断描述符表(IDT) 获得第 n 个描述符
#. 检查描述符的特权级 DPL 是否 *数值上大于等于* 当前的特权级 CPL
   (即当前段的级别至少要高于要执行的中断的特权级), 是则继续,
   否则触发一个通用保护中断(General Protection Fault, int 13)

..

   通过设置 DPL, 可以限制用户态能用 int 指令触发的中断号, 系统调用的实现即是如此



#. 如果目标段描述符的 `RPL < CPL`\ , 则在 CPU 内部保存\ `esp`\ 和\ `ss`\ 的值.
   这个时候意味这特权级转换要发生了.
#. 从一个任务状态段(TSS)加载\ `ssX`\ 和\ `espX`\ , X 是 RPL 的值, 所以对于系统调用,
   取出的会是 `ss0`\ 和\ `esp0`
#. 将\ `ss` `esp` `eflags` `cs` `eip`\ 压栈
#. 清除\ `eflags`\ 中的某些位
#. 设置\ `cs`\ 和\ `ip`\ 为 IDT[n] 中指定的值. (执行中断服务例程)

对于普通的中断, 其中断返回地址是发生中断时的执行的那条指令的地址
(需要将 IDT 的类型设置为 中断门(Interrupt gate))
因为这种中断通常和当前进程没有什么关系.

.. code:: c

   idt_install(0, (uint32_t)fault0, SEL_KCODE << 3, GATE_INT, IDT_PR|IDT_DPL_KERN);

对于系统调用, 我们需要主动执行 int 指令, 并让其返回到下一条指令处.
因此要将处理系统调用的 IDT 设置为 陷阱门(Trap gate), 并且 DPL 为\ `IDT_DPL_USER`\ (3).
如下:

.. code:: c

   idt_install(ISR_SYSCALL, (uint32_t)_syscall, SEL_KCODE << 3, GATE_TRAP, IDT_PR | IDT_DPL_USER);

TSS
---

在特权级转换的时候, 需要从任务状态段取出\ `ss0`\ 和\ `esp0`\ , 因此在转换之前需要设置 TSS.

CPU 会从寄存器\ `tr`\ 获得 TSS 的选择子, 然后从 GDT 表里面找出对应的描述符,
由描述符就可以获得 TSS 的基址了.

TSS 的选择子放在 GDT 里, 但是其\ `AC_RE`\ (ACCESS_REVERSE)位为 0 来表示
它是一个 TSS 描述符而不是 GDT 描述符.

因此 TSS 的初始化是这样的:

.. code:: c

   void tss_init(){
       gdt_install(SEL_TSS, (uint32_t)&tss, sizeof(tss),AC_PR | AC_AC | AC_EX, GDT_GR);
       /* for tss, access_reverse bit is 1 */
       gdt[5].access &= ~AC_RE;
   }

在从进程的内核态回到用户态的时候, 要设置一次 TSS, 以下函数在\ `uvm_switch`\ 里面被调用:

.. code:: c

   void tss_set(uint16_t ss0, uint32_t esp0){
       memset((void *)&tss, 0, sizeof(tss));
       tss.ss0 = ss0;
       tss.esp0 = esp0;
       tss.iopb_off = sizeof(tss);
   }

两个上下文
----------

中断上下文
^^^^^^^^^^

从上面关于中断过程的解释可以看到, 从用户态执行中断转入内核态是可能的,
重点在与设置一个 DPL = 3 的 IDT 和一个 TSS 段.

那如何从内核态返回用户态呢? iret 指令会按 int 压栈的顺序逆序将寄存器们出栈,
程序就会从内核态又返回到用户态了.

有意思的地方就是, 要从内核态到用户态, 我们可以构造一个栈, 然后执行 iret 指令,
iret 就会将我们特地安排的值覆盖到寄存器上, 这个工作由\ `proc_alloc`\ 完成,
每个新建的进程都通过这种方式"假装回到"用户空间.

为了方便地构造栈, 我们需要定义出中断时保存的上下文, int 指令保存的信息还不够,
我们需要自己保存更多的寄存器:

.. code:: c

   struct int_frame{
       /* segment registers */
       uint32_t gs;    // 16 bits
       uint32_t fs;    // 16 bits
       uint32_t es;    // 16 bits
       uint32_t ds;    // 16 bits

       /* registers save by pusha */
       uint32_t edi;
       uint32_t esi;
       uint32_t ebp;
       uint32_t esp;
       uint32_t ebx;
       uint32_t edx;
       uint32_t ecx;
       uint32_t eax;

       uint32_t int_no;

       /* save by `int` instruction */
       uint32_t err_code;
       uint32_t eip;
       uint32_t cs;    // 16 bits
       uint32_t eflags;
       uint32_t user_esp;
       uint32_t ss;    // 16 bits
   };

只要完整地保存了以上信息并正确还原, 就能确保从中断返回时, 程序依然正常运行.
注意的是我们不必显式地建立以上的一个结构体(构建第一个进程的时候除外), 在中断发生时,
这个结构体会在进程的内核栈上被建立.中断返回时, 这些信息又会从栈里被弹出.

中断上下文的\ `err_code`\ 到\ `ss`\ 部分由 int 指令压入, 之后跳转到\ `OS67/kern/loader.asm`
中的由汇编编写的中断服务例程(ISR)入口. 有的中断不产生\ `err_code`\ ,
就由该中断入口压入一个假的\ `err_code`. 这些入口代码有两个宏生成,
分别是\ `m_fault`\ 和\ `m_irq`\ , 负责处理异常中断和硬件中断.
另外还有\ `_syscall`\ 和\ `_isr_unknown`\ 处理系统调用和未定义的中断.

每个入口都会压入自己的中断号, 然后统一跳转到\ `_isr_stub`\ , 压入上下文的剩余部分,
再调到由 C 编写的\ `isr_stub`\ , 由此再根据入口压入中断号调用真正的 ISR.
关于这些 ISR 的详情...太长了表示扯不下去了... :(

进程上下文
^^^^^^^^^^

中断上下文已经让程序能够程序成功进入内核并从内核中返回,
接下来通过切换进程上下文来实现进程的切换.

进程上下文看起来比中断上下文简单许多, 不过更富技巧性.

.. code:: c

   struct context{
       uint32_t edi;
       uint32_t esi;
       uint32_t ebx;
       uint32_t ebp;
       uint32_t eip;
   };

这个上下文同样是建立在进程的内核栈上的,但是内核原来的栈也保存了一个.

我们用下面这个函数来切换进程上下文:

.. code:: objdump-nasm

   ; context_switch(struct context **old, context *new)
   ; 当你调用这个函数时, 会依次 压入 new, old 和 eip
   [global context_switch]
   context_switch:
       mov eax, [esp + 4]  ; 把 old 放到 eax
       mov edx, [esp + 8]  ; 把 new 放到 edx

       ; 这里已经隐式地保存了 eip
       push ebp
       push ebx
       push esi
       push edi
   ; 此时的栈结构就是一个 `strcut context`

       mov [eax], esp      ; 把 esp 保存到 old 指向的地址
       mov esp, edx        ; 切换到 new 指向的地址作为栈

       pop edi
       pop esi
       pop ebx
       pop ebp
       ; 还剩下一个 eip 未弹出, 刚好由 ret 弹出, 这样就切换到了 new 里面的 eip
       ret

这里的 `eip` 和 `esp` 的保存都非常巧妙, eip 在执行 `context_switch` 时被压入,
又在 `ret` 的时候被弹出. 而 `esp` 则直接作为 `context` 的地址被保存.

可以看到这个函数可以切换当前的执行流到另一个执行流, 进程的切换就是这样实现的,
当然要切换的不止这个, 页表也要切换, 代表当前执行进程的 `proc` 变量也要更新.
页表的切换由 `uvm_switch` 执行, `proc` 的更新则在 `scheduler` 执行.

虚拟内存映射
------------

由于之前的思路问题, 因此 OS67 的内存管理方式不得不和 xv6 不太一样.

OS67 的内存分配实现在 `OS67/mm/pmm.c`\ , 使用一个简单的栈来存放未分配的内存页,
`malloc` 就是 `pop` 而 `mfree` 就是 `push`. 这么做简单明了,
虽然申请多个页的时候效率不高, 不过我们不考虑这种需要大量内存的情况.

对于虚拟内存映射, 策略是这样的: 内核以及未分配的内存的虚拟地址和物理地址一一对应,
用户地址映射到 0xc0000000 上. 内核在初始化页表的时候, 建立一个映射所有物理内存的页表,
之后建立的进程页表中的内核部分就复用内核页表的页表项, 避免内存浪费,
同时在特权级转换时也不必切换页表, 亦能很方便地从内核空间访问到用户空间的内存.

将用户地址映射到 0xc0000000 的好处是不需要在建立正式页表前建立临时页表来把内核映射到高处,
另外 `malloc` 出来的是物理地址, 可以直接对其读写而不必做转换.
缺点则是程序必须经过重定位(链接时使用参数 `-Ttext 0xc0000000`\ )才能运行在高地址,
也许有更多的缺点还没发现.

第一个进程
----------

构造
^^^^

结构体 proc 用来储存一个进程的信息, 内核中有一个数组\ `struct ptable[NPROC]`\ 来管理所有的进程.
结构体\ `proc`\ 定义如下:

.. code:: c

   struct proc{
       volatile uint8_t pid;
       uint32_t size;
       uint8_t state;
       uint8_t killed;
       char name[NAME_LEN];

       // context
       struct int_frame *fm;       // 中断上下文
       struct context *context;    // 进程上下文

       pde_t *pgdir;               // 进程页表
       char *kern_stack;           // 内核栈

       void *chan;

       struct file *ofile[NOFILE];
       struct inode *cwd;
       struct proc *parent;
   };

这里主要关注的是两个上下文, 进程页表以及内核栈.

这里涉及的代码都在\ `OS37/proc/proc.c`\ 中.

第一个进程需要手动创建, 由\ `proc_init`\ 完成.

`proc_inint`\ 首先调用\ `proc_alloc`\ 从\ `ptable`\ 获得一个空的进程结构体槽位,
`proc_alloc`\ 做了一些必要的初始化操作.

`proc_alloc`\ 为新进程申请了内核栈, 并对他进行了一定的构造:


- 为中断上下文\ `fm`\ 留出空间, 并把\ `proc->fm`\ 指向该空间.
- 在\ `fm`\ 之后放置了指向中断返回函数\ `_isr_stub_ret`\ 的指针
- 为进程上下文\ `context`\ 留出空间, 并把\ `proc->content`\ 改空间,
- 把\ `proc->context-eip`\ 指向了函数\ `fork_ret`.

在 xv6 中\ `fork_ret`\ 被用来处理锁, 这 OS67 中, 这个函数碰巧被用来解决一个
奇怪的 bug <https://github.com/SilverRainZ/OS67/commit/fc0e84caa1c3ae95998342f2b03125e2226d0dd6>`_ .
因此, 正常 alloc 出来的新进程都会返回到\ `fork_ret`. 从\ `fork_ret`\ 返回后,
又会跳转到\ `_isr_stub_ret`\ 准备从中断返回. 接下来就会逐步把\ `fm`\ 弹出,
尽管此时的\ `fm`\ 还没有初始化.

之后\ `proc_init`\ 为第一个进程申请了一个页目录\ `proc->pgdir`\ ,
调用\ `kvm_init`\ 建立到内核的一对一的地址映射. 为之前的内核栈也建立地址映射.

再接着, 通过声明在用户程序\ `OS67/proc/init.asm`\ 中的全局变量\ `__init_start` `__init_end`
的地址获得编译进内核里的用户程序的位置, 调用\ `uvm_init_fst`\ 把程序复制到一个新的页中,
并把该页映射到\ `USER_BASE`\ (0xc0000000).

然后开始手动构建一个\ `fm`\ , 为各个段寄存器设置正确的段选择子,
为 eflags 寄存器加上 IF 标志(允许中断), 设置用户栈, 最后把\ `eip`\ 设定为\ `USER_BASE`.

最后把进程的状态\ `proc->state`\ 设置为可运行 `P_RUNABLE`.

以上是比较关键的步骤, 现在可以准备运行第一个进程了.

运行
^^^^

执行了\ `proc_init`\ 之后, `scheduler`\ 紧接其后,
它在\ `ptable`\ 中寻找第一个\ `state`\ 为\ `P_RUNABLE`\ 的进程,
调用\ `uvm_switch`\ 切换到该进程的页表并设置好 TSS.

接着更新\ `proc`\ 变量, 把\ `proc->state`\ 设置为\ `P_RUNNING`.
最后调用\ `context_switch`\ 切换到进程.  不出意外的话,
`context_switch`\ 会弹出\ `proc->context`\ 中设定好的寄存器,
新进程返回到\ `fork_ret`\ 之后返回到\ `_isr_stub_ret`\ 中, 又把\ `proc->fm`\ 弹出.
于是第一个进程就成功运行在 0xc0000000 的用户空间上了.

调度
----

这里使用非常简单的轮转法, 每次触发时钟中断都会执行\ `sched`\ ,
`sched`\ 把当前进程状态由\ `P_RUNNING`\ 变更为\ `P_RUNABLE`. 接着执行\ `context_switch`.
这样 CPU 执行流就回到了刚才\ `scheduler`\ 中的循环,
`scheduler`\ 继续寻找一个\ `P_RUNABLE`\ 的进程并切换到它.

E.N.D.
------

至此, 用户级进程已经成功实现并且被调度. 但是没有有效的接口来启动更多的进程.
我们需要实现一些系统调用比如\ `fork`\ 和\ `exec`\ 来做这些事情.
:( 但是我已经写不下去了... 如果可以话下次再写吧.

:del:`不一定有下次`

--------------------------------------------------------------------------------

.. isso::
