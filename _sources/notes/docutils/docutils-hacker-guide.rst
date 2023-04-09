=======================
Docutils Hacker's Guide
=======================

:date: 2020-11-12
:reference: https://docutils.sourceforge.io/docs/dev/hacking.html

Doctuils 是 Python 编写的通用文档处理软件，使用 reStructedText 作为 markup language。
提供了 `rst2{html,man,xml,xetext}` 等命令行工具（ `pacman -Ql python-docutils | grep /usr/bin/` ）。

Docutils Hacker's Guide 简要解释了 Docutils 的工作原理：
将一个 rst 文件转换为目标格式的文档（比如 HTML）需要经过：
Read ( :file:`docutils/readers` ) -> Parse ( :file:`docutils/parsers` )
-> Transform ( :file:`docutils/transforms` )-> Write ( :file:`docutils/writers` )
四个阶段。

Parse 阶段将 Read 读取的文件解析为一棵节点树，目前仅实现了 reStructuredText
parser ( :file:`docutils/parsers/rst` )。对于如下 rst 文档::

   My *favorite* language is Python_.

   .. _Python: http://www.python.org/

使用 :file:`docutils/tools/quicktest.py` 可以查看 rst 文档的节点树
（层级用缩进表示）::

    <document source="test.txt">
    <paragraph>
        My
        <emphasis>
            favorite
         language is
        <reference name="Python" refname="python">
            Python
        .
    <target ids="python" names="python" refuri="http://www.python.org/">


标签内的节点（ `document` 、 `paragraph` ...）在 :file:`docutils/nodes.py`
中都能找到对应的实现。
可以用 `epydoc <https://epydoc.sourceforge.net/>`_ 查看节点的继承关系。

.. note:: 树上的文本譬如 "My"、"language is"、"." 同样是节点，
   对应的实现为 `docutils.nodes.Text`

Transform 阶段利用 :zhwiki:`访问者模式` 对语法树进行各种变换，
本例中 `ExternalTargets` transform ( :file:`docutils/transforms/references.py` )
会解析 `reference` 节点，寻找 ID 为 "python" 的 target 节点，
并设置 `reference` 节点的 `refuri` 属性。 使用 `rst2pseudoxml` 可以看到
Transform 阶段后的节点树::

    <document source="test.txt">
    <paragraph>
        My
        <emphasis>
            favorite
         language is
        <reference name="Python" refuri="http://www.python.org/">
            Python
        .
    <target ids="python" names="python" refuri="http://www.python.org/">
