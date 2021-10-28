.. Bullet documentation master file, created by
   sphinx-quickstart on Wed May 20 21:28:31 2020.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

========
银色子弹
========

.. centered:: *Yes silver bullet here.*

.. centered:: :doc:`关于我 <about/me>`
   | :doc:`关于本站 <about/site>`
   | :doc:`友人帐 <about/friends>`
   | :doc:`todo`

--------------------------------------------------------------------------------

.. panels::

   .. toctree::
      :caption: 笔记
      :maxdepth: 1
      :glob:

      notes/zxsys/index
      notes/artstory/index
      notes/books/index
      notes/music-theory/index
      notes/6-lectures-on-sketch

      notes/*/index

   -----------------------------------------------------------------------------

   .. toctree::
      :caption: 博客
      :maxdepth: 1

      博客首页 <blog/index>

   .. postlist:: 10
      :format: {title}
      :list-style: disc

   :ref:`所有日志…  <blog-posts>`

   -----------------------------------------------------------------------------

   .. toctree::
      :caption: 手册
      :maxdepth: 1
      :glob:

      man/*

   -----------------------------------------------------------------------------

   .. toctree::
      :caption: 随记
      :maxdepth: 2

      misc/2021/index
      misc/2020/index
      misc/2017/index

   -----------------------------------------------------------------------------

   .. toctree::
      :caption: 收集室
      :maxdepth: 1
      :glob:

      collections/*/index

   -----------------------------------------------------------------------------

   .. toctree::
      :caption: 关于
      :maxdepth: 1

      我 <about/me>
      about/site
      about/friends
      简历 <about/resume>
