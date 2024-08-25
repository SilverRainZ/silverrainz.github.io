========
永固笔记
========

自 2024-08 下旬，新增的笔记平坦放置在 :file:`/p` 下，p 意即永固（Permanent） [#]_，笔记一旦加入，除非删除，其 URL 不再改变。

原有的 :rst:dir:`toctree` 保留，但通过指定 docname 的方式继续更新（而非原来的 ``:glob:``）。原有的笔记暂不迁移，后续考虑通过 :pypi:`sphinx-reredirects` 也转化为永固笔记 |todo|。

Pros
   - URL 固定不变，SEO 友好
   - *归类负担降低：*

     - 归类后期可变，且变更不影响可访问性
     - 允许暂时不归类，一些内容可以提前发布

Cons
   - URL 级别丧失目录结构
   - 和原笔记稍显割裂

.. [#] 「永固」一词取自颜料名，通常耐受性较好，例如 永固玫红__

__ http://www.winsornewton.com.cn/artisist-oil-forever-rose.htm

--------------------------------------------------------------------------------

.. 定义一个目录树以防止出现：WARNING: document isn't included in any toctree

.. toctree::
   :caption: 永固笔记
   :titlesonly:
   :glob:

   *


