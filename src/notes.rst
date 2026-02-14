:layout: landing
:nocomments:

==================
SilverRainZ 的笔记
==================

.. rst-class:: lead

   这里是我的个人笔记，没有什么好阅读的，目录和内容都会不定期变动。

.. raw:: html

   <style>
   .sd-card-body .reference,
   .sd-card-body dt,
   .sd-card-text {
      color: var(--sd-color-card-text);
      font-size: 0.9rem;
   }
   </style>

.. grid:: 1 1 3 3
   :gutter: 2
   :padding: 0
   :class-row: surface

   .. grid-item-card:: :octicon:`image` 艺术

      :doc:`/notes/zxsys/index`:
         我脱产两年学习绘画和创作的笔记，如果对我我画画的经历感兴趣，可以看看 :ref:`category-辞职为学画`。
      :doc:`/p/artistory/index`
         一些外行人学习艺术史的记录，可能有错漏，见谅。
      :doc:`/notes/books/index`
         如题，很少更新，我读书很少。

   .. grid-item-card:: :octicon:`code` 编程

      :doc:`/notes/man/index`
         我个人的 :manpage:`man(1)`，在 AI 时代显得意义缺缺。
      :doc:`/notes/go/index`
         在字节时我供职于 Go 语言组，虽然不参与编译器工作，也算跟着大佬同事们学了一些皮毛。
      :doc:`/notes/writeups/index`
         陈芝麻烂谷子的一些题解，Leetcode、CTF and etc.

   .. grid-item-card:: :octicon:`bell` 音乐

      :doc:`/p/lyscores/index` 
         我用 :doc:`/notes/man/lily` 做的一些谱子
      :doc:`/p/ly/index` 
         Lilypond 支持用 Scheme 扩展，我用它实现了一些方便的音乐函数。
         源码单独放在 :ghrepo:`SilverRainZ/bullet.ly`
      吉他
         业余爱好者，水平初级，自娱自乐。

         这些内容对我很有用，希望对你有帮助：:doc:`/p/guitar-neck`、
         :doc:`/notes/music-theory/cadge-system`、:doc:`/p/small-triad`、
         :doc:`/p/kodaly-rhythm-syllables`
         

最近更新
========

.. recentupdate:: 5

   .. grid:: 1 1 2 2
      :gutter: 2
      :padding: 0
      :class-row: surface

      {% for r in revisions %}
      .. grid-item-card:: :octicon:`calendar` {{ r.date | strftime }}

         {% if r.modification %}
         :修改了: {{ r.modification | roles("doc") | join("、") }}
         {% endif %}
         {% if r.addition %}
         :新增了: {{ r.addition | roles("doc") | join("、") }}
         {% endif %}
         {% if r.deletion %}
         :删除了: {{ r.deletion | join("、") }}
         {% endif %}
      {% endfor %}

所有笔记
========

由于历史原因，目前的笔记有两种组织方式，我还在探索更好的组织方法。

.. grid:: 1 1 2 2
   :gutter: 2
   :padding: 0
   :class-row: surface

   .. grid-item-card:: 旧版索引

      .. toctree::
         :maxdepth: 2

         notes/zxsys/index
         notes/books/index
         notes/man/index
         notes/*/index

   .. grid-item-card:: 永固笔记

      .. toctree::
         :maxdepth: 2

         /p/index
