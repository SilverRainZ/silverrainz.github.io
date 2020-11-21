==========================
The Docutils Document Tree
==========================

:date: 2020-11-12
:reference: https://docutils.sourceforge.io/docs/ref/doctree.html

这篇文档介绍了 docutils 的文档节点树（doctree），给出了一张节点元素的继承关系图::

    +--------------------------------------------------------------------+
    | document  [may begin with a title, subtitle, decoration, docinfo]  |
    |                             +--------------------------------------+
    |                             | sections  [each begins with a title] |
    +-----------------------------+-------------------------+------------+
    | [body elements:]                                      | (sections) |
    |         | - literal | - lists  |       | - hyperlink  +------------+
    |         |   blocks  | - tables |       |   targets    |
    | para-   | - doctest | - block  | foot- | - sub. defs  |
    | graphs  |   blocks  |   quotes | notes | - comments   |
    +---------+-----------+----------+-------+--------------+
    | [text]+ | [text]    | (body elements)  | [text]       |
    | (inline +-----------+------------------+--------------+
    | markup) |
    +---------+

表的含义可以看原文，几个比较重要的信息：

- document 总是 root 节点
- section 可以递归地包含自身
- 部分的 body elements 可以包含 body elements
- inline markup 没有提到 (?)

Content Model
-------------

    The Docutils document model uses strict element content models.
    Every element has a unique structure and semantics,
    but elements may be classified into general categories (below).

doctree 采用了严格的元素内容模型，相比 HTML 则松散得多。

.. note::

   这里的元素内容模型（element content model）应该类似 HTML 的
   `Content categories <https://developer.mozilla.org/zh-CN/docs/Web/Guide/HTML/Content_categories>`_ 。
   模型描述了某个元素可以包含何种内容。

..

    Only elements which are meant to directly contain text data have a mixed content model,
    where text data and inline elements may be intermixed.
    This is unlike the much looser HTML document model,
    where paragraphs and text data may occur at the same level.

只有能够直接包含文本（text data）的元素才拥有一个混合的内容模型（mixed content model），
即能够混排文本（text data）和内联元素（inline elements ）（下述）。
HTML 则宽松得多，段落和文本是能在同一嵌套级别出现的（比如 ``<p>prargraph</p>text`` ）。

Element Categories
------------------

doctree 上的元素可分为如下几类：

Structural Elements
    不能包含文本，只能包含子元素，且 Structural Elements 的父元素必须是 Structural Elements
    （e.g ``document`` ）

    Structural Subelements
        必须被特定的 Structural Elements 包含，简单的 Structural Subelements
        可以直接包含文本（e.g ``title``, ``subtitle``, ``docinfo`` ）

        Bibliographic Elements
             ``docinfo`` 是 ``document`` 可选的子元素，用于描述文档的 metadata，
             Bibliographic Elements 的父元素只能是 ``docinfo``（e.g. ``author``, ``copyright`` ）

        Decorative Elements
             是 ``document`` 可选的子元素，用于生成文档的页头与页脚
             （e.g. ``header``, ``footer`` ）

Body Elements
    只能被 Structural Elements 或者复合的（compound）Body Elements 包含。

    Simple Body Elements
        只能包含文本或者不包含任何内容，能包含文本的 Simple Body Elements
        同样能包含 Inline Elements，即前述的 "mixed content model"。
        不包含任何内容的 Simple Body Elements 是 doctree 的叶子节点
        （e.g.  ``paragraph``, ``comment`` ）

    Compound Body Elements
        不直接包含文本，能够包含 Body Subelements 和其他的 Body Elements。

        Body Subelements
            必须被特定的 Compound Body Elements 包含
            （ e.g. ``bullet_list`` 包含 ``list_item`` ）
            Body Subelements 本身可以包含其他的 Compound Body Elements

Inline Elements
    直接包含文本，也可能包含其他的 Inline Elements。Inline Elements 只能被
    Simple Body Elements 包含。大部分的 Inline Elements 都支持 "mixed content model"。
    （e.g. ``strong``, ``subscript`` ）
