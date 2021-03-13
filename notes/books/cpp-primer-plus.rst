C++ Primer Plus
===============

.. book:: _
   :isbn: 9787115279460

.. note:: 因为懒所以跳着看，记下一些感觉需要记的东西，但是看起来似乎还是会一遗漏很多东西啊……

ch3 处理数据
------------

-  使用 ``cout << hex;`` 控制程序以 16 进制输出数字，类似的控制符有
   ``oct`` 和 ``dec`` 如果想要声明变量 ``hex`` 则要用 ``std::hex``
   来表示该控制符
-  ``int func(void)`` 和 ``int func()`` 都表示该程序不接受任何参数

    NOTE: 在 C语言中， ``int func()`` 则表示接受任意多的参数

-  强制类型转换：

.. code:: cpp

    (int) 'A';
    int ('A');
    static_cast<int> ('A');

-  列表初始化（list-initialztion）： 不允许使用变量，不允许 narrowing
   （即往更小的数据类型转换）

.. code:: cpp

    int v = 1;
    char a = { 1 };     // allowed
    char a { 1 };       // allowed: C++ 的列表初始化可省略等号，下同
    char a { v };       // NOT allowed
    char a { 111111 }   // NOT allowed

ch4 复合类型
------------

-  若初始化数组时只指定了部分元素，余下的元素都会被置 0
-  字符串拼接： 任意两个以空白符号分隔的字符串可会被自动合并

.. code:: cpp

    "aaa" "bbb"  <=> "aaabbb\0"

-  ``cin << str`` 的读取以空白符号为终点，使用
   ``cin.getline(str, size)`` 可破： 读取指定数目，遇到换行停止，而
   ``cin.get(str, size)`` 则不丢弃换行
-  C++ 风格的字符串：\ ``#include <string>`` 可以用 ``+`` 拼接，更加安全
-  声明结构体变量允许省略 ``struct`` 关键字
-  不允许直接将整数赋给指针

.. code:: cpp

    int *ptr = 0xb800;  // no allowed
    int *ptr = (int *)0xb800;  // allowed

-  使用 new 分配内存，delete 回收内存：

.. code:: cpp

    int *ptr = new int;
    delete ptr;
    int *parr = new int[5];
    delete [] parr;

new 和 delete 要一一对应

ch5 循环和关系表达式
--------------------

新的 for 语法：

.. code:: cpp

    for (int x in {1, 3, 4}) {...}
