:isso-id: /p/permanent-notes

========
永固笔记
========

自 2024-08 下旬，新增的笔记平坦放置在 :file:`/p` 下，p 意即永固（Permanent） [#]_，笔记一旦加入，除非删除，其 URL 不再改变。

Pros
   - URL 固定不变，SEO 友好
   - *归类负担降低：*

     - 归类后期可变，且变更不影响可访问性
     - 允许暂时不归类，一些内容可以提前发布
     - 允许一个文档有多个分类

       - 悲报：文档 `实际上不允许被多个 toctree 包含`__

Cons
   - docname/URL 级别丧失目录结构，可读性变差

     - :pypi:`sphinxnotes-snippet` 目前根据 docname 匹配 snippet 类型

   - 和原笔记稍显割裂

.. [#] 「永固」一词取自颜料名，通常耐久性较好，例如 永固玫红__

__ https://github.com/orgs/sphinx-doc/discussions/12999#discussioncomment-10909269
__ http://www.winsornewton.com.cn/artisist-oil-forever-rose.htm

迁移
====

- 新增的，未能良好归类的笔记平坦放置在 ``/p`` 下

  - 归类良好的怎么办 |?|

- 原有的笔记大部分不迁移；归类不佳的、不希望展示的笔记，通过 *迁移脚本* 迁移到 ``/p`` 下
- 原有的 :rst:dir:`toctree` 保留，但通过指定 docname 的方式继续更新（而非原来的 ``:glob:``） |?|
- |todo|

目前的迁移脚本：

.. literalinclude:: /_utils/migrate-to-permnotes
   :language: shell

--------------------------------------------------------------------------------

.. 定义一个目录树以防止出现：WARNING: document isn't included in any toctree

.. toctree::
   :caption: 永固笔记
   :titlesonly:
   :glob:

   *
