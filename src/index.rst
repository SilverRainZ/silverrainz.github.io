:layout: landing

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

   :ref:`联系我 <contact-me>`
   `网站怎么做的？ <https://github.com/SilverRainZ/bullet>`_

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
