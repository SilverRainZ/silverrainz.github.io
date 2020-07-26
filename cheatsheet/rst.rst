=====================
reStructuredText 语法
=====================

超链接
======

- reST 会自动识别文中出现的超链接，比如 http://silverrainz.me/
- 指定链接标题的情况，使用::

    这是一个 `标题 <http://silverrainz.me>`_

  效果： 这是一个 `标题 <http://silverrainz.me>`_
- 标题和链接分离::

    这是一个 `标题`_

    .. _标题: http://silverrainz.me

  效果：这是一个 `标题`_

.. _标题: http://silverrainz.me

章节符号
========

可用的章节符号有： ``# * = - ^ " ~`` 。

个人约定：``#`` > ``=`` > ``-`` > ``~`` > ``*`` > ``^`` > ``"``

显式标记
========

显式标记以 ``..`` 开始，后跟空白符。

指令
----

指令是显式标记中最常用的模块。

指令由名字，参数，选项及内容组成::

    .. function:: foo(x)
                  foo(y, z)
       :module: some.module.name

    返回用户输入的一行文本.

``function`` 是指令名字，在第一行和第二行给出了两个参数, 及一个选项 ``module`` 。
选项在参数后给出，由冒号包围。选项必须与指令有一样的缩进。
指令的内容在隔开一个空行后，与指令有一样的缩进。

图像
----

图像指令::

    .. image:: https://www.gnu.org/graphics/empowered-by-gnu.svg
       :width: 50 %

效果：

.. image:: https://www.gnu.org/graphics/empowered-by-gnu.svg
   :width: 50 %

脚注
----

使用 ``[#name]_`` 标记命名脚注的位置，使用 ``.. [#name] xxx`` 定义脚注::

    这是脚注 [#f1]_ ，这也是脚注 [#f2]_ 。

    .. [#f1] 第一条脚注的文本.
    .. [#f2] 第二条脚注的文本.

效果：

这是脚注 [#f1]_ ，这也是脚注 [#f2]_ 。

.. [#f1] 第一条脚注的文本.
.. [#f2] 第二条脚注的文本.

``[#]_`` 是自动排序的脚注， ``[9]_`` 是强制编号的脚注::

    这是脚注 [#]_ ，这也是脚注 [#]_ ，强制编号的脚注 [9]_ 。

    .. [#] 第一条脚注的文本.
    .. [#] 第二条脚注的文本.
    .. [9] 强制编号脚注的文本.

效果：
  
这是脚注 [#]_ ，这也是脚注 [#]_ ，强制编号的脚注 [9]_ 。

.. [#] 第一条脚注的文本.
.. [#] 第二条脚注的文本.
.. [9] 强制编号脚注的文本.

引用
----

.. warning:: 并没有在标准里找到 ``[]_`` 的用法。

使用 ``[ref]_`` 来标记引用的位置，使用 ``.. [ref]_ xxx`` 来声明一个引用::

    这篇笔记参考了 [reStructuredText 简介]_

    .. [reStructuredText 简介] http://zh-sphinx-doc.readthedocs.io/en/latest/rest.html 

效果：

这篇笔记参考了 [reStructuredText简介]_  。

.. [reStructuredText简介] http://zh-sphinx-doc.readthedocs.io/en/latest/rest.html 

替换
----

使用 ``|something|`` 来标记一个替换的位置。使用 ``.. |something| directive xxx`` 来定义一个替换。

.. note:: 替换的内容必须是一个指令。

::

    不如意事常 |89| ，可与人言无 |23| 。

    .. |89| replace:: **八九**
    .. |23| replace:: **二三**

效果：

不如意事常 |89| ，可与人言无 |23| 。

.. |89| replace:: **八九**
.. |23| replace:: **二三**

注释
----

有效但是未定义的显示标记就是注释。
