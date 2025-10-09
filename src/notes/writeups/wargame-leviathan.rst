wargame-leviathan
=================

-  ssh addr: leviathan.labs.overthewire.org
-  url: http://overthewire.org/wargames/leviathan/

leviathan0
''''''''''

flag: leviathan0

leviathan1
''''''''''

flag: rioGegei8m

在 `~/.backup/bookmarks.html` 搜索 `password` 可得。

leviathan2
''''''''''

flag: ougahZi8Ta

home 目录下有一程序名为 check，执行之，要求输入密码， 首先
`strings check` 查看一下程序中的字符串，似乎没有发现什么像 flag
的字串，不过倒是发现了一个 `/bin/sh`\ ，推测程序会启动一个 shell。

用 gdb 调试，对 main 下断点后反汇编，关键部分如下：

.. code:: objdump

    0x0804857a <+77>:    call   0x80483c0 <printf@plt>
    0x0804857f <+82>:    call   0x80483d0 <getchar@plt>
    0x08048584 <+87>:    mov    %al,0x14(%esp)
    0x08048588 <+91>:    call   0x80483d0 <getchar@plt>
    0x0804858d <+96>:    mov    %al,0x15(%esp)
    0x08048591 <+100>:   call   0x80483d0 <getchar@plt>
    0x08048596 <+105>:   mov    %al,0x16(%esp)
    0x0804859a <+109>:   movb   $0x0,0x17(%esp)
    0x0804859f <+114>:   lea    0x18(%esp),%eax
    0x080485a3 <+118>:   mov    %eax,0x4(%esp)
    0x080485a7 <+122>:   lea    0x14(%esp),%eax
    0x080485ab <+126>:   mov    %eax,(%esp)
    0x080485ae <+129>:   call   0x80483b0 <strcmp@plt>
    0x080485b3 <+134>:   test   %eax,%eax
    0x080485b5 <+136>:   jne    0x80485c5 <main+152>
    0x080485b7 <+138>:   movl   $0x804868b,(%esp)
    0x080485be <+145>:   call   0x8048400 <system@plt>
    0x080485c3 <+150>:   jmp    0x80485d1 <main+164>

`printf` 用来输出 “password” 字样，之后连续三个
`getchar`\ ，之后把该字符串和 `esp + 14` 处的字符串作为参数给
`strcmp@plt`\ ，根据比较的结果决定流程， 因此对 `strcmp` 下断：
`break strcmp@plt`\ ，输入密码后查看堆栈：\ `x/10x $esp`

过程如下：

::

    0xffffd63c:     0x080485b3      0xffffd654      0xffffd658      0x0804a000
    0xffffd64c:     0x08048642      0x00000001      0x00333231      0x00786573
    0xffffd65c:     0x00646f67      0x65766f6c

`0xffffd658` 处即是该程序的 password，用 `x/s 0xffffd658` 可看。

leviathan3
''''''''''

flag: Ahdiemoo1j

这道题想了很久还是不会，最终上网看答案了……

登入机器后发现家目录有个带 `suid` 权限的可执行文件 `printfile`\ ，
属主是 `leviathan3`\ ，用户组是 `leviathan2`\ ，带 `suid`
的程序执行时可以获得和 owner/grouper 相同的权限（euid/egid）。

.. note:: 关于 linux 下的权限，更多请参见 `linux/privileges.md//TODO <TODO>`__\ 。

::

    leviathan2@melinda:~$ ll printfile  
    -r-sr-x--- 1 leviathan3 leviathan2 7498 Nov 14  2014 printfile*
    leviathan2@melinda:~$ ./printfile
    *** File Printer ***
    Usage: ./printfile filename
    leviathan2@melinda:~$ ./printfile /etc/leviathan_pass/leviathan3
    You cant have that file...

从字面意思上看，这个程序接受一个文件路径然后把文件的内容显示出来，但是要求它打印
`/etc/leviathan_pass/leviathan3` 却提示
`You cant have that file...`\ ， 上 gdb 分析看看。

以下是 `diaasm main` 的结果，假设执行了 `r filename`\ ：

.. code:: objdump

      0x0804852d <+0>:     push   %ebp
      0x0804852e <+1>:     mov    %esp,%ebp
      0x08048530 <+3>:     and    $0xfffffff0,%esp
      0x08048533 <+6>:     sub    $0x230,%esp
      0x08048539 <+12>:    mov    0xc(%ebp),%eax           ; argv 参数地址
      0x0804853c <+15>:    mov    %eax,0x1c(%esp)          ; argv 保存到 [esp + 0x1c]
      0x08048540 <+19>:    mov    %gs:0x14,%eax            ; Thread-Local Storage, 不知道是什么
      0x08048546 <+25>:    mov    %eax,0x22c(%esp)
      0x0804854d <+32>:    xor    %eax,%eax
      0x0804854f <+34>:    cmpl   $0x1,0x8(%ebp)           ; \ argc 和 1 比较，此处 argc 应该为 2
      0x08048553 <+38>:    jg     0x804857e <main+81>      ; / argc > 1 则跳
      0x08048555 <+40>:    movl   $0x8048690,(%esp)
      0x0804855c <+47>:    call   0x80483d0 <puts@plt>
      0x08048561 <+52>:    mov    0x1c(%esp),%eax
      0x08048565 <+56>:    mov    (%eax),%eax
      0x08048567 <+58>:    mov    %eax,0x4(%esp)
      0x0804856b <+62>:    movl   $0x80486a5,(%esp)
      0x08048572 <+69>:    call   0x80483b0 <printf@plt>
      0x08048577 <+74>:    mov    $0xffffffff,%eax
      0x0804857c <+79>:    jmp    0x80485e8 <main+187>

    ; -> 来自 0x08048553 <+38> 的跳转，以上代码不必分析了
      0x0804857e <+81>:    mov    0x1c(%esp),%eax          ; 取出储存的 argv
      0x08048582 <+85>:    add    $0x4,%eax                ; 移动到 argv 的第一个参数（从 0 计数）
      0x08048585 <+88>:    mov    (%eax),%eax              ; 取出 argv[1] 的值，指向字符串 ‘filename’
      0x08048587 <+90>:    movl   $0x4,0x4(%esp)           ; \ 参数二：int amode
      0x0804858f <+98>:    mov    %eax,(%esp)              ; | argv[1] 作参数一： char *path
      0x08048592 <+101>:   call   0x8048420 <access@plt>   ; / access(argv[1], 4)，成功返回 0
      0x08048597 <+106>:   test   %eax,%eax
      0x08048599 <+108>:   je     0x80485ae <main+129>     ; 跳
      0x0804859b <+110>:   movl   $0x80486b9,(%esp)
      0x080485a2 <+117>:   call   0x80483d0 <puts@plt>
      0x080485a7 <+122>:   mov    $0x1,%eax
      0x080485ac <+127>:   jmp    0x80485e8 <main+187>

    ; -> 来自 0x08048599 <+108> 的跳转
      0x080485ae <+129>:   mov    0x1c(%esp),%eax          ; \
      0x080485b2 <+133>:   add    $0x4,%eax                ; | 取得 argv[1]
      0x080485b5 <+136>:   mov    (%eax),%eax              ; /
      0x080485b7 <+138>:   mov    %eax,0xc(%esp)           ; \ ...: argv[1]
      0x080485bb <+142>:   movl   $0x80486d4,0x8(%esp)     ; | char *format: string "/bin/cat %s"
      0x080485c3 <+150>:   movl   $0x1ff,0x4(%esp)         ; | size_t size: 511
      0x080485cb <+158>:   lea    0x2c(%esp),%eax          ; |
      0x080485cf <+162>:   mov    %eax,(%esp)              ; | char *str
      0x080485d2 <+165>:   call   0x8048410 <snprintf@plt> ; / snprintf(str, 511, "/bin/cat %s", argv[1]);
      0x080485d7 <+170>:   lea    0x2c(%esp),%eax
      0x080485db <+174>:   mov    %eax,(%esp)              ; \
      0x080485de <+177>:   call   0x80483e0 <system@plt>   ; / system("/bin/cat filename");
      0x080485e3 <+182>:   mov    $0x0,%eax
      0x080485e8 <+187>:   mov    0x22c(%esp),%edx
      0x080485ef <+194>:   xor    %gs:0x14,%edx
      0x080485f6 <+201>:   je     0x80485fd <main+208>
      0x080485f8 <+203>:   call   0x80483c0 <__stack_chk_fail@plt>
      0x080485fd <+208>:   leave
      0x080485fe <+209>:   ret
    end of assembler dump.

可以看到程序接受一个文件路径，先检查对该文件的访问权限，然后执行 shell
命令 "/bin/cat filename"。

问题出在 `access` 函数， man 是这样说的：

    The access() function shall check the file named by the pathname
    pointed to by the path argument for accessibility according to the
    bit pattern contained in amode, *using the real user ID in place of
    the effective user* *ID and the real group ID in place of the
    effective group ID.*

而 `suid` 权限改变的只是进程的 `euid`\ ，因此当你执行
`./printfile /etc/leviathan_pass/leviathan3` 的时候，access
函数总是失败的。

但是用 gdb 改变程序的流程也是
`不可行 <http://unix.stackexchange.com/questions/15911/can-gdb-debug-suid-root-programs>`__
的，非 root 的 gdb 调试带 suid
权限的程序时，程序不会获得本来应该有的权限 （否则 gdb
就可以任意地改变程序的行为了），即使绕过了 access 函数，
你依然会得到一个 `Permission denied`\ 。

到这里我就没辙了，只能看别人的 writeup 了： `OverTheWire Leviathan
Wargame Solution
2 <https://rundata.wordpress.com/2013/03/27/overthewire-leviathan-wargame-solution-2/>`__
，看完发现脑洞确实不够大。

*Solution:*:

access() 接受的是个字符串参数，而 cat 的参数却是由 shell 处理的， 执行
`./printfile "flag here"`\ ， 对于 access 函数来说是执行了
`access("flag here", 4)`, 检查对 `flag here` 这个文件的访问权限，
而对 cat 来说是这样的 `system("cat flag here")` =
`system*("cat flag; cat here")`\ ， 因此可以利用这个区别来绕过 access
函数。

::

    leviathan2@melinda:/tmp$ mkdir slove
    leviathan2@melinda:/tmp$ cd slove
    leviathan2@melinda:/tmp/slove$ touch 'flag here'    # 带空格的文件名
    leviathan2@melinda:/tmp/slove$ ln -s /etc/leviathan_pass/leviathan3 flag
    leviathan2@melinda:/tmp/slove$ ls
    flag  flag here
    leviathan2@melinda:/tmp/slove$ ~/printfile 'flag here'  # access 检测的是刚刚建立的新文件， cat 显示的则是 flag 和 here
    Ahdiemoo1j
    /bin/cat: here: No such file or directory

另外发现了一个新工具 ltrace，能够跟踪库函数的调用，
就不用像刚才那样分析整个程序了：

::

    leviathan2@melinda:~$ ltrace ~/printfile /etc/leviathan_pass/leviathan2
    __libc_start_main(0x804852d, 2, 0xffffd6f4, 0x8048600 <unfinished ...>
    access("/etc/leviathan_pass/leviathan2", 4)                                       = 0
    snprintf("/bin/cat /etc/leviathan_pass/lev"..., 511, "/bin/cat %s", "/etc/leviathan_pass/leviathan2") = 39
    system("/bin/cat /etc/leviathan_pass/lev"...ougahZi8Ta
    <no return ...>
    --- SIGCHLD (Child exited) ---
    <... system resumed> )                                                            = 0
    +++ exited (status 0) +++

leviathan4
''''''''''

flag: vuH0coox6m

这次学乖了，扫了几眼汇编，程序把一大堆东西放到栈里然后 `strcmp`\ ，
果断用 ltrace 看看：

::

    leviathan3@melinda:~$ ll level3
    -r-sr-x--- 1 leviathan4 leviathan3 9962 Mar 21  2015 level3*

    leviathan3@melinda:~$ ltrace ./level3                                                                                                          
    __libc_start_main(0x80485fe, 1, 0xffffd744, 0x80486d0 <unfinished ...>                                                                         
    strcmp("h0no33", "kakaka")                                                              = -1                                                   
    printf("Enter the password> ")                                                          = 20                                                   
    fgets(Enter the password> 1234                                                                                                                 
    "1234\n", 256, 0xf7fcbc20)                                                        = 0xffffd53c                                                 
    strcmp("1234\n", "snlprintf\n")                                                         = -1                                                   
    puts("bzzzzzzzzap. WRONG"bzzzzzzzzap. WRONG                                                                                                    
    )                                                              = 19
    +++ exited (status 0) +++

    leviathan3@melinda:~$ ltrace ./level3
    __libc_start_main(0x80485fe, 1, 0xffffd744, 0x80486d0 <unfinished ...>
    strcmp("h0no33", "kakaka")                                                              = -1
    printf("Enter the password> ")                                                          = 20
    fgets(Enter the password> snlprintf
    "snlprintf\n", 256, 0xf7fcbc20)                                                   = 0xffffd53c
    strcmp("snlprintf\n", "snlprintf\n")                                                    = 0
    puts("[You've got shell]!"[You've got shell]!
    )                                                             = 20
    system("/bin/sh"$
    $
     <no return ...>
    --- SIGCHLD (Child exited) ---
    <... system resumed> )                                                                  = 0
    +++ exited (status 0) +++

唔，结果直接出来了，前面的 `strcmp` 还是个障眼法，在 ltrace
里面是拿不到 euid 权限的，在外面再试一次：

::

    leviathan3@melinda:~$ ./level3
    Enter the password> snlprintf
    [You've got shell]!
    $ id
    uid=12003(leviathan3) gid=12003(leviathan3) euid=12004(leviathan4) groups=12004(leviathan4),12003(leviathan3)
    $ cat /etc/leviathan_pass/leviathan4
    vuH0coox6m
    $  

leviathan5
''''''''''

flag: Tith4cokei

诶，为什么题目越往后越简单呢……

登录，\ `.trash` 目录下有一程序
`bin`\ ，执行后输出一组八位二进制数字：

::

    leviathan4@melinda:~/.trash$ ./bin
    01010100 01101001 01110100 01101000 00110100 01100011 01101111 01101011 01100101 01101001 00001010

继续用 ltrace 看看：

::

    leviathan4@melinda:~/.trash$ ltrace ./bin
    __libc_start_main(0x80484cd, 1, 0xffffd724, 0x80485c0 <unfinished ...>
    fopen("/etc/leviathan_pass/leviathan5", "r")                                            = 0
    +++ exited (status 255) +++

这里程序以二进制方式打开 `/etc/leviathan_pass/leviathan5`
之后异常退出了， 因为在 ltrace
包裹下它并没有读取这个文件的权限。这里就可以大胆猜测输出的数字
就是文件的二进制表示了，不放心的话继续用 gdb 粗略看看它做了什么，
`fopen` 之后调用 `fget`\ ，得到内容之后 `putchar`\ ，八九不离十。

复制那段数字，用 vim 把转成字串数组，再用一行 python 搞定：

.. code:: python

    >>> ''.join(chr(int(b, 2)) for b in ['01010100', '01101001', '01110100', '01101000', '00110100', '01100011', '01101111', '01101011', '01100101', '01101001', '00001010'])
    'Tith4cokei\n'

leviathan6
''''''''''

flag: UgaoFee4li

登录，执行直接执行 `~/leviathan5`\ ，提示找不到
`/tmp/file.log`\ ，新建文件 `echo 2333 > /tmp/file.log`\ ，看看
ltrace：

::

    leviathan5@melinda:~$ ./leviathan5
    Cannot find /tmp/file.log

    leviathan5@melinda:~$ echo 2333 > /tmp/file.log
    leviathan5@melinda:~$ ltrace ./leviathan5
    __libc_start_main(0x80485ed, 1, 0xffffd734, 0x8048690 <unfinished ...>
    fopen("/tmp/file.log", "r")                                                             = 0x804b008
    fgetc(0x804b008)                                                                        = '2'
    feof(0x804b008)                                                                         = 0
    putchar(50, 0x8048720, 0xffffd73c, 0xf7e5710d)                                          = 50
    fgetc(0x804b008)                                                                        = '3'
    feof(0x804b008)                                                                         = 0
    putchar(51, 0x8048720, 0xffffd73c, 0xf7e5710d)                                          = 51
    fgetc(0x804b008)                                                                        = '3'
    feof(0x804b008)                                                                         = 0
    putchar(51, 0x8048720, 0xffffd73c, 0xf7e5710d)                                          = 51
    fgetc(0x804b008)                                                                        = '3'
    feof(0x804b008)                                                                         = 0
    putchar(51, 0x8048720, 0xffffd73c, 0xf7e5710d)                                          = 51
    fgetc(0x804b008)                                                                        = '\n'
    feof(0x804b008)                                                                         = 0
    putchar(10, 0x8048720, 0xffffd73c, 0xf7e5710d2333
    )                                          = 10
    fgetc(0x804b008)                                                                        = '\377'
    feof(0x804b008)                                                                         = 1
    fclose(0x804b008)                                                                       = 0
    getuid()                                                                                = 12005
    setuid(12005)                                                                           = 0
    unlink("/tmp/file.log")                                                                 = 0
    +++ exited (status 0) +++
    leviathan5@melinda:~$

看起来是打印一个文件之后把文件删除：
`fopen -> fgetc -> feof -> putchar -> getuid -> setuid -> unlink`\ ，
不知道 getuid 和 setuid 在这里有什么用。

所以把 flag 文件链接到 `/tmp/file.log`\ ：

::

    leviathan5@melinda:~$ ln -s /etc/leviathan_pass/leviathan6 /tmp/file.log
    leviathan5@melinda:~$ ./leviathan5
    UgaoFee4li

leviathan7
''''''''''

flag: ahy7MaeBo9

直接执行可以看到需要一个 4 位的数字做参数，用 ltrace 可以看到程序调用了
`itoa` 来把字符串转成数字：

::

    leviathan6@melinda:~$ ./leviathan6
    usage: ./leviathan6 <4 digit code>
    leviathan6@melinda:~$ ./leviathan6 1234
    Wrong
    leviathan6@melinda:~$ ltrace ./leviathan6 1234
    __libc_start_main(0x804850d, 2, 0xffffd734, 0x8048590 <unfinished ...>
    atoi(0xffffd870, 0xffffd734, 0xffffd740, 0xf7e5710d)                                    = 1234
    puts("Wrong"Wrong
    )                                                                           = 6
    +++ exited (status 6) +++

上 gdb：

假设执行了 ./leviathan6 1234

.. code:: objdump

    (gdb) disassemble main
    Dump of assembler code for function main:
       0x0804850d <+0>:     push   %ebp
       0x0804850e <+1>:     mov    %esp,%ebp
       0x08048510 <+3>:     and    $0xfffffff0,%esp
       0x08048513 <+6>:     sub    $0x20,%esp
    -> 0x08048516 <+9>:     movl   $0x1bd3,0x1c(%esp)   ; 后面会用到 0x1c(%esp)
       0x0804851e <+17>:    cmpl   $0x2,0x8(%ebp)       ; if (argc == 2)
       0x08048522 <+21>:    je     0x8048545 <main+56>  ; 参数数量不对就跳走
       0x08048524 <+23>:    mov    0xc(%ebp),%eax
       0x08048527 <+26>:    mov    (%eax),%eax
       0x08048529 <+28>:    mov    %eax,0x4(%esp)
       0x0804852d <+32>:    movl   $0x8048620,(%esp)
       0x08048534 <+39>:    call   0x8048390 <printf@plt>
       0x08048539 <+44>:    movl   $0xffffffff,(%esp)
       0x08048540 <+51>:    call   0x80483e0 <exit@plt>
    ; 跳转至此：
       0x08048545 <+56>:    mov    0xc(%ebp),%eax       ; char** argv
       0x08048548 <+59>:    add    $0x4,%eax            ; char** argv + 4
       0x0804854b <+62>:    mov    (%eax),%eax          ; char** argv[1] 指向 '1234'
       0x0804854d <+64>:    mov    %eax,(%esp)
       0x08048550 <+67>:    call   0x8048400 <atoi@plt> ; atoi('1234')
    -> 0x08048555 <+72>:    cmp    0x1c(%esp),%eax      ; eax = 1234;  [esp + 0x1c] = 0x1bd3
       0x08048559 <+76>:    jne    0x8048575 <main+104>

       0x0804855b <+78>:    movl   $0x3ef,(%esp)
       0x08048562 <+85>:    call   0x80483a0 <seteuid@plt>
       0x08048567 <+90>:    movl   $0x804863a,(%esp)
       0x0804856e <+97>:    call   0x80483c0 <system@plt>
       0x08048573 <+102>:   jmp    0x8048581 <main+116>
       0x08048575 <+104>:   movl   $0x8048642,(%esp)
       0x0804857c <+111>:   call   0x80483b0 <puts@plt>
       0x08048581 <+116>:   leave
       0x08048582 <+117>:   ret
    End of assembler dump.
    (gdb) break  *0x08048555
    Breakpoint 1 at 0x8048555
    (gdb) run 1234
    Starting program: /home/leviathan6/leviathan6 1234

    Breakpoint 1, 0x08048555 in main ()
    (gdb) x/u $esp +0x1c
    0xffffd65c:     7123
    (gdb) x/x $esp +0x1c
    0xffffd65c:     0x00001bd3
    (gdb) set $eax=7123
    (gdb) c
    Continuing.
    $

程序把输入的参数用 `atoi` 转成数字然后和常数 `0x1bd3` 比较，相同则
PASS， 于是 get 到 7123 就是 key：

::

    leviathan6@melinda:~$ ./leviathan6 7123
    $ cat /etc/leviathan_pass/leviathan7
    ahy7MaeBo9
    $

至此 leviathan 就做完了，除了第三题很有意思之外，其他都没什么难度
（也多亏了 ltrace），登入 leviathan7 的账户能看到这个：

::

    leviathan7@melinda:~$ cat CONGRATULATIONS
    Well Done, you seem to have used a \*nix system before, now try something more serious.
    (Please don't post writeups, solutions or spoilers about the games on the web. Thank you!)

虽然说是 don't post，可是我还是发出来了……抱歉。
