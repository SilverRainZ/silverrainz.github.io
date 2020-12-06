GDB
===

References
----------

-  `gdb Debugging Full Example (Tutorial):
   ncurses <http://www.brendangregg.com/blog/2016-08-09/gdb-example-ncurses.html>`__

Commands
--------

-  ``shell`` 暂时进入 shell
-  ``n``/``s`` 单条语句，步过/步入
-  ``ni``/``ns`` 单条指令，步过/步入

Breakpoint
----------

::

    b main          # 对函数下断点
    b *0xbeef       # 对地址下断点
    b *main + 0x10  # 对函数偏移下断点

    watch *0xbeef   # 硬件断点

    info breakpoints    # 查看断点

    delete <num>    # 据编号删除断点

Print
-----

``x /FMT ADDRESS`` 打印内存内容，FMT: A repeat count followed by a
format letter and a size letter.

-  Fromat: ``/x`` 十六进制，\ ``d`` 十进制，\ ``u``
   十六进制无符号，\ ``i`` 指令， ``o`` 八进制， ``t`` 二进制，\ ``a``
   地址 (?)，``c`` 字符，\ ``f`` 浮点数， ``s`` C Style 字符串
-  Size: ``b`` byte, ``h`` halfword, ``w`` word, ``g`` giant, 8 bytes

对于某些 format letter，size letter 不一定有用。

``p`` 打印变量和表达式，支持部分 format letter

::

    print $rdi              # 查看 rdi 寄存器值
    print $1                # 查看第一次 print 的输出
    print var               # 打印 var 的值
    print *var              # 打印 var 内存单元中的值
    # ^ 还搞不明白 * 的具体含义……
    # 比如 print main 和 print *main 的输出相同
    print *array@len        # 打印长度为 len 的数组
    print {void *}argv@argc # 查看所有启动参数地址

-  ``$NUM`` 代表历史 print 输出，\ ``$xxx`` 代表当前寄存器的值， 若
   ``xxx`` 非寄存器名，fallback 到用户自定义变量
-  ``{TYPE}ADREXP`` 对 ``ADREXP`` 用类型 ``TYPE`` 解析，
-  ``@NUM`` 将地址视为长度为 ``NUM`` 的数组起点
