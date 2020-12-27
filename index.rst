.. Bullet documentation master file, created by
   sphinx-quickstart on Wed May 20 21:28:31 2020.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

.. rst-class:: center-title

========
银色子弹
========

.. centered:: *Yes silver bullet here.*

.. centered:: :ref:`genindex` | :doc:`todo`

--------------------------------------------------------------------------------

.. panels::

   .. toctree::
      :caption: 笔记
      :titlesonly:
      :glob:

      notes/*
      notes/*/index

   -----------------------------------------------------------------------------

   .. toctree::
      :caption: 博客
      :titlesonly:

      所有日志 <blog/index>

   .. postlist:: 10
      :format: {title}
      :list-style: disc

   -----------------------------------------------------------------------------

   .. toctree::
      :caption: 手册
      :titlesonly:
      :glob:

      man/*

   -----------------------------------------------------------------------------

   .. toctree::
      :caption: 随记
      :titlesonly:
      :glob:

      misc/*/index

   -----------------------------------------------------------------------------

   .. toctree::
      :caption: 关于
      :titlesonly:

      我 <about/me>
      about/site
      about/friends
