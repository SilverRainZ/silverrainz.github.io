========================================
 几种简单的反调试方法
========================================

.. post:: 2015-05-19
   :tags: Reverse
   :author: LA
   :language: zh_CN

.. hint:: 这是一篇迁移自 Jekyll 的文章，如有格式问题，可到 :ghrepo:`SilverRainZ/bullet` 反馈

这里面没有什么自己的东西,
都是从看雪的\ `OD从零系列教程 <http://bbs.pediy.com/showthread.php?t=184679>`_\ 里看来的.
最近看到的几章都是讲反调试的, 虽然对其本质还没有去深入了解,
还是觉得应该先把这些记下来.

*下面的一些信息是基于自己现有的知识推测出来的, 不一定对.*
关于函数的说明, 都是基于MSDN的粗浅翻译, 要想了解更准确的信息, 请查阅MSDN.

.. contents::

0x0  利用IsDebuggerParent()
---------------------------

0x0.0 介绍
^^^^^^^^^^

该函数检测程序是否正在被调试, 是的话返回1,否则返回0,
该函数位于\ `Kernel32.dll`\ 中, 其代码如下:

.. code:: nasm

   mov eax, dword ptr fs:[0x18]
   mov eax, dword ptr fs:[eax + 0x30]
   movzx eax, byte ptr ds:[eax + 0x2]

fs寄存器指示了(并不是储存了)\ `PEB`\ (Process Environment Block)的地址,
因为GDT的关系,fs寄存器中储存的只是选择子而不是地址,
因此要从fs的0x18偏移处取一个指向自己的self指针(这一步实际上是可以省略的).

接下来从\ `PEB`\ 的0x30偏移处取得\ `NT_TIB`\ 结构的首地址,
该结构的0x2偏移处是\ `BeingDebugged`\ 字段, 表示当前进程是否被调试,
因此通过这个函数可以检测调试器.

你可以在代码中直接使用\ `IsDebuggerParent`\ 或者嵌入等价的汇编代码.
动态载入函数比直接引入好些.

0x0.1 栗子
^^^^^^^^^^

.. code:: c

   #include <stdio.h>
   #include <windows.h>

   /* 内联汇编 */
   int foo(){
       /* 这里的 movl %fs:30, %ebx 就相当于
        * mov eax, dword ptr fs:[0x18]
        * mov eax, dword ptr fs:[eax + 0x30]
        */
       asm("movl %fs:0x30, %ebx; movzx 2(%ebx), %eax");
   }
   /* 动态载入 */
   int bar(){
    int result = 0;
    HINSTANCE kern_lib = LoadLibraryEx("kernel32.dll", NULL, 0);
       if(kern_lib){
           FARPROC lIsDebuggerPresent = GetProcAddress(kern_lib, "IsDebuggerPresent");
           if(lIsDebuggerPresent && lIsDebuggerPresent()){
               result = 1;
           }
           FreeLibrary(kern_lib);
       }
       return result;
   }

   /* 测试的时候记得关掉OD的插件, 或者直接用原版 */
   int main(){
       printf("foo = %d\n",foo());
       printf("bar = %d\n",bar());
       return 0;
   }

0x0.2 绕过
^^^^^^^^^^


* 如果能定位到函数的话, 修改他的流程.
* 可以在载入程序后, 把那个\ `BeingDebugged`\ 位置0,
  当然, HideDebugger插件已经替我们做了这件事.

0x1 检测进程名I
---------------

0x1.0 介绍
^^^^^^^^^^

通过检测特定调试器(常常是OD)的进程是否存在来防止被调试.

用到了下面几个API:


* EnumProcesses

.. code:: c

   BOOL WINAPI EnumProcesses(
     _Out_ DWORD *pProcessIds,
     _In_  DWORD cb,
     _Out_ DWORD *pBytesReturned
   );

EnumProcesses 枚举所有的进程PID, 第一个参数是缓冲区, 储存所有进程PID的列表,
参数二是以byte计数的数组长度, 参数三是阶收到的数组长度, 同样以byte计数.
函数执行成功返回非零值.


* GetModuleBaseNameA

.. code:: c

   DWORD WINAPI GetModuleBaseName(
     _In_     HANDLE  hProcess,
     _In_opt_ HMODULE hModule,
     _Out_    LPTSTR  lpBaseName,
     _In_     DWORD   nSize
   );

该函数取得某个模块的名称, 参数一是线程句柄,  参数二是模块句柄,
参数三是储存返回模块名的缓冲区, 最后是缓冲区的长度, 以char计数.
函数执行成功则返回接收到的模块名的长度


* OpenProcess

.. code:: c

   HANDLE WINAPI OpenProcess(
     _In_ DWORD dwDesiredAccess,
     _In_ BOOL  bInheritHandle,
     _In_ DWORD dwProcessId
   );

该函数通过PID(参数4)获得进程句柄失败则返回NULL.
(获得句柄后可以在OD的H窗口看到该句柄).


* EnumProcessModules

.. code:: c

   BOOL WINAPI EnumProcessModules(
     _In_  HANDLE  hProcess,
     _Out_ HMODULE *lphModule,
     _In_  DWORD   cb,
     _Out_ LPDWORD lpcbNeeded
   );

函数枚举指定进程里的所有Modules, 取回句柄. 参数一指定了进程句柄,
参数二是返回的模块句柄缓冲区, 参数三是以byte计数的缓冲区大小,
四是最终取回句柄的大小, byte计数. 函数执行成功返回非零值.

利用这些函数检测调试器的经典过程是这样的:


#. 首先用\ `GetProcAddress`\ 动态载入上面的其他函数
#. 调用\ `EnumProcesses`\ 对所有进程进行枚举, 实际上是获得一个储存了所有进程PID的列表
#. 以获取到的PID为参数调用\ `OpenProcess`\ , 取得进程句柄
#. 用获取到的句柄执行\ `EnumProcessModules`\ 枚举进程的模块, 只取第一个模块
#. 使用进程句柄和模块句柄为参数调用\ `GetModuleBaseNameA`\ 得到进程名
#. 和要检测的进程名作比较, 这决定了程序的流程
#. 如果是待检测进程的话, 选择自行退出或者是结束调试器, 可能用到\ `TerminatePorcess`
#. 调用\ `CloseHandle`\ 关闭句柄

0x1.1 栗子
^^^^^^^^^^

`//TODO`

0x1.2 绕过
^^^^^^^^^^


* 令OpenProcess始终返回\ `NULL`\ , 打不开任何进程.
* 改动OpenProcess后的程序流程
* 更改OD的名字, 进程名也会同时被更改;(最简单的做法了)

0x2 检测进程名II
----------------

0x2.0 介绍
^^^^^^^^^^

使用的API:


* CreateToolhelp32Snapshot

.. code:: c

   HANDLE WINAPI CreateToolhelp32Snapshot(
     _In_ DWORD dwFlags,
     _In_ DWORD th32ProcessID
   );

该函数对指定的进程做快照, dwFlags参数决定进程的那一部分会被包含在快照中.
参数二为PID, 返回快照句柄. 指定参数 `CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0)`
则对系统中所有的进程进行快照, 可以被\ `Process32First`\ 进行枚举.


* Process32First

.. code:: c

   BOOL WINAPI Process32First(
     _In_    HANDLE           hSnapshot,
     _Inout_ LPPROCESSENTRY32 lppe
   );

在快照中取得第一个进程的相关信息.
参数一: 由CreateToolhelp32Snapshot返回的快照句柄.
参数二: 指向PORCESSENTRY32结构体的指针, 包含可执行文件名, PID,和父进程PID等.
执行成功返回true.


* Process32Next

.. code:: c

   BOOL WINAPI Process32Next(
     _In_  HANDLE           hSnapshot,
     _Out_ LPPROCESSENTRY32 lppe
   );

取回快照中下一个进程的信息(然而你必须先用Process32First取第一个), 参数和Process32First基本相同.

`Process32First`\ 和\ `Process32Next`\ 中涉及到的\ `PPROCESSENTRY32`\ 结构体如下:

.. code:: c

   PROCESSENTRY32 structure
   typedef struct tagPROCESSENTRY32 {
     DWORD     dwSize;
     DWORD     cntUsage;
     DWORD     th32ProcessID;
     ULONG_PTR th32DefaultHeapID;
     DWORD     th32ModuleID;
     DWORD     cntThreads;
     DWORD     th32ParentProcessID;
     LONG      pcPriClassBase;
     DWORD     dwFlags;
     TCHAR     szExeFile[MAX_PATH];
   } PROCESSENTRY32, *PPRO

最后一个参数就是进程名了好像.

利用该方法检测进程的基本流程是:


* 调用\ `CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0)`\ 获得所有进程快照
* 用\ `Process32First`\ 取得第一个进程的信息, 判断是否是要检测的进程
* 用\ `Process32Next`\ 循环检测其他进程

0x2.1 栗子
^^^^^^^^^^

`//TODO`

0x2.2 绕过
^^^^^^^^^^

绕过的做法基本同I.

检测窗口类名
------------

0x3.0 介绍
^^^^^^^^^^

又是API...


* FindWindowA

.. code:: c

   HWND WINAPI FindWindow(
     _In_opt_ LPCTSTR lpClassName,
     _In_opt_ LPCTSTR lpWindowName
   );

该函数取回和参数匹配的顶级窗口的句柄, 大小写不敏感.

参数一: 窗口类名
参数二: 窗口名
参数可选, 至少一个, 另一个可置NULL.
执行成功返回句柄.

因为OD的窗口名常常不确定, 利用窗口类名往往比较靠谱;
将窗口名置NULL, 检测OD的顶级窗体类名即可, 该类名可以通过Spy++得到.

0x3.1 栗子
^^^^^^^^^^

`//TODO`

0x3.2 绕过
^^^^^^^^^^


* HideDebugger插件有绕过 FindWindowA/EnumWindows 的选项;
* 使用RE-Pair为OD主程序打补丁, 可更改其类名

0x3 UnhandledExcepiton和ZwQueryInformationProcess
-------------------------------------------------

这种反调试方法比前面的方法更具技巧性一些, 利用了Windows的异常处理机制,
但是我还不了解这些异常处理, 不敢胡说,暂时略过.


.. raw:: html

   <p style="display:none;">

   * SetUnhandledExceptionFilter

   ``c
   LPTOP_LEVEL_EXCEPTION_FILTER WINAPI SetUnhandledExceptionFilter(
     _In_ LPTOP_LEVEL_EXCEPTION_FILTER lpTopLevelExceptionFilter
   );
   ``
   该函数让应用程序可以取代该进程中所有线程的系统异常处理函数.(大概是吧...)

   > Enables an application to supersede the top-level exception handler of each
   > thread of a process.

   调用该函数后, 如果有异常发生, 且该进程当前没有被调试,
   则该异常会被 `Unhandled Exception Filter`处理 , Filter会调用异常筛选(?)函数,
   该函数由参数一指定.

   > After calling this function, if an exception occurs in a process that is not being debugged,
   > and the exception makes it to the unhandled exception filter,
   > that filter will call the exception filter function specified by the
   > lpTopLevelExceptionFilter parameter.

   * UnhandledExceptionFilter

   ``c
   LONG WINAPI UnhandledExceptionFilter(
     _In_ struct _EXCEPTION_POINTERS *ExceptionInfo
   );
   ``

   如果当前进程被调试的话, 程序定义的函数(?)会将未处理的异常传递给调试器.
   否则, 它将可选地显示一个应用程序错误的消息框, 并使得异常处理函数执行.
   该函数只能在异常处理例程中的Filter Expression中被调用.

   > An application-defined function that passes unhandled exceptions to the debugger,
   > if the process is being debugged. Otherwise,
   > it optionally displays an Application Error message box and causes the exception handler to be executed.
   > This function can be called only from within the filter expression of an exception handler.

   该函数唯一的参数是一个`EXCEPTION_POINTERS`指针,
   指定了对此异常的描述和发生异常时的上下文.

   > A pointer to an `EXCEPTION_POINTERS` structure that specifies a description
   > of the exception and the processor context at the time of the exception.

   > 发生异常时系统的处理顺序(by Jeremy Gordon, Hume):
   > 1. 系统首先判断异常是否应发送给目标程序的异常处理例程,如果决定应该发送,
   >    并且目标程序正在被调试,则系统挂起程序并向调试器发送`EXCEPTION_DEBUG_EVENT`消息.
   > 1. 如果你的程序没有被调试或者调试器未能处理异常,
   >    系统就会继续查找你是否安装了线程相关的异常处理例程,
   >    如果你安装了线程相关的异常处理例程,系统就把异常发送给你的程序seh处理例程,
   >    交由其处理.
   > 1. 每个线程相关的异常处理例程可以处理或者不处理这个异常,
   >    如果他不处理并且安装了多个线程相关的异常处理例程, 可交由链起来的其他例程处理.
   > 1. 如果这些例程均选择不处理异常,如果程序处于被调试状态,操作系统仍会再次挂起程序通知debugger.
   > 1. *如果程序未处于被调试状态或者debugger没有能够处理,
   >    并且你调用SetUnhandledExceptionFilter安装了最后异常处理例程的话,系统转向对它的调用.*
   > 1. *如果你没有安装最后异常处理例程或者他没有处理这个异常,
   >    系统会调用默认的系统处理程序(UnhandledExceptionFilter),通常显示一个对话框,
   >    你可以选择关闭或者最后将其附加到调试器上的调试按钮.
   >    如果没有调试器能被附加于其上或者调试器也处理不了,系统就调用ExitProcess终结程序.*
   > 1. 不过在终结之前,系统仍然对发生异常的线程异常处理句柄来一次展开,
   >    这是线程异常处理例程最后清理的机会.

   利用这两个函数的流程可能是:

   1. 当点击CM中的check按钮时, 程序抛出不可忽略的异常, 因为程序正在被调试,
      所以系统将异常传递给调试器(EXCEPITON_DEBUG_EVENT),
      `SetUnhandledExceptionFilter`指定的异常处理函数并没有被执行
      (实际上这个函数里放置的应该是程序的真正流程).
   2. 然而OD并不能处理这个异常, 因此最终将调用`UnhandledExceptionFilter`处理异常.

   在`UnhandledExceptionFilter`中有函数`ZwQueryInfomationProcess`,
   可以用来判断程序是否被调试, 它是随着`UnhandledExceptionFilter`被调用(在系统领空中),
   但是这个函数也可以单独抽取出来被调用.

   ``c
   NTSTATUS WINAPI ZwQueryInformationProcess(
     _In_      HANDLE           ProcessHandle,
     _In_      PROCESSINFOCLASS ProcessInformationClass,
     _Out_     PVOID            ProcessInformation,
     _In_      ULONG            ProcessInformationLength,
     _Out_opt_ PULONG           ReturnLength
   );
   ``

   取得特定进程的信息.
   在这里只需要知道使ProcessInformationClass = ProcessDebugPort (7),
   就可以从ProcessInformation缓冲区中取得ProcessInformationLength长度的信息,
   返回FFFFFFFF的话表示正在被调试, 返回0反之. 对应上面步骤f的:

   如果没有调试器能被附加于其上或者调试器也处理不了,系统就调用ExitProcess终结程序.
   如果正在调试(返回FFFFFFF)的话->异常传递给调试器->调试器处理不了->程序退出.
   按教程的说法和实际测试的得到: 如果返回0的话跳转到SetUnhandledExceptionFilter指定的函数,
   利用异常实现了反调试.

   可是执行SetUnhandledExceptionFilter指定的函数不是在步骤c吗,
   UnhandledExceptionFilter可是步骤6才执行的?

   ### 绕过

   * 手动修改ZwQueryInformationProcess返回值
   * HideDebugger插件的UnhandledExceptionTricks选项可以绕过此反调试.
   * HideOD插件可以单独绕过ZwQueryInformationProcess(记住勾选AutoRun)
   </p>


0x4 NtGlobalFlag,ProcessHeap,OutputDebugStringA
-----------------------------------------------

这几个都比较简单, 从略.

NtGlobalFlag
^^^^^^^^^^^^

该标志在\ `PEB`\ 中,对于x86, 在0x68处
对于x64, 在 0xbc 处.

定位到PEB:


* 在EIP入口点定位到EBP的值;
* 或者定位到FS:[0x18];

NtGlobalFlag 默认总是0, 除非它被一个调试器所附加.
当调试器创建一个进程时, NtGlobalFlag会有如下的值:

.. code::

   > FLG_HEAP_ENABLE_TAIL_CHECK (0x10)
   > FLG_HEAP_ENABLE_FREE_CHECK (0x20)
   > FLG_HEAP_VALIDATE_PARAMETERS (0x40)


因此, 如果\ `NtGlobalFlag == 0x10 + 0x20 + 0x40 =  0x70`\ 时, 程序正在被调试.

ProcessHeap
^^^^^^^^^^^

在PEB的 0x10 偏移处的一个 DWORD, 不为0则表示正在被调试.

OutputDebugStringA
^^^^^^^^^^^^^^^^^^

`OutputDebugStringA`\ 是个函数, 该函数向调试器输出一个字符串,
它能用于反调试是因为OD的一个bug, 当用这个函数输出一长串的%s字串时, OD会崩溃.

0x4.1 栗子
^^^^^^^^^^

无

0x4.2 绕过
^^^^^^^^^^

* 修改对应的值
* HideOD 插件的 HideNtDebugBit选项, 以及 OutDebugStringA 选项或
  Hide Debugger插件的OutputDebugString exploit选项
