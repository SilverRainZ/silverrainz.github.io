:layout: landing
:nocomments:

.. Bullet documentation master file, created by
   sphinx-quickstart on Wed May 20 21:28:31 2020.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

========
银色子弹
========

.. rst-class:: lead

   :friend:`i` 的结构化笔记系统。

.. container:: buttons

   最近更新_
   :ref:`联系我吧 <contact-me>`

.. grid:: 1 1 2 3
   :gutter: 1
   :padding: 0
   :class-row: surface

   .. grid-item-card:: :octicon:`image` 画廊
      :link: /gallery.html

      这里陈列一些我觉得还不错的技术练习、小创作以及正式的作品。

   .. grid-item-card:: :octicon:`book` 博客
      :link: /blog/index.html

      我的博客，主要写一些编程相关的文章、介绍最近做的项目，也记录生活琐事。

   .. grid-item-card:: :octicon:`note` 笔记
      :link: /notes.html

      我的个人笔记，没有什么好阅读的，目录和内容都会不定期变动。

.. only:: private

   .. toctree::
      :class: hidden
      :caption: 私有笔记
      :maxdepth: 1

      in/index
      in/gtd/okr/index
      in/homelab/index

.. toctree::
   :class: hidden
   :caption: 笔记
   :maxdepth: 1
   :glob:

   notes/zxsys/index
   notes/artstory/index
   notes/books/index
   notes/man/index
   notes/*/index

.. toctree::
   :class: hidden
   :caption: 博客
   :maxdepth: 1

   所有文章 <blog/index>
   blog/transit/archive
   blog/transit/category
   blog/transit/tag
   blog/transit/feed

最近更新
========

.. recentupdate::
   :group-by: month

   .. container:: timeline

      .. - 不展示删除的文章（意义不大）
         - 博客仅展示新增（不会有值得注意的改动）

      {% for r in revisions %}
      .. card:: :octicon:`calendar` {{ r.date.strftime('%Y 年 %m 月') }}
         :width: 50%
         :margin: 0 2 {{ loop.cycle('0 auto', 'auto 0') }}
         :class-card: surface

         {% if r.added_docs %}
         :新增了: {{ r.added_docs | roles("doc") | join("、") }}
         {% endif %}

         {% set ns = namespace(nonblog_docs=[]) %}
         {% for doc in r.changed_docs %}
           {% if not doc.startswith('/blog') %}
             {% set ns.nonblog_docs = ns.nonblog_docs + [doc] %}
           {% endif %}
         {% endfor %}

         {% if ns.nonblog_docs %}
         :修改了: {{ ns.nonblog_docs | roles("doc") | join("、") }}
         {% endif %}
      {% endfor %}
