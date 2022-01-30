.. Bullet documentation master file, created by
   sphinx-quickstart on Wed May 20 21:28:31 2020.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

========
银色子弹
========

.. only:: prod

   .. recentupdate:: 5

      .. dropdown:: 最近更新
         :open:

         {% for r in revisions %}
         :{{ r.date | strftime }}:
            {% if r.modification %}
            - 修改了 {{ r.modification | roles("doc") | join("、") }}
            {% endif %}
            {% if r.addition %}
            - 新增了 {{ r.addition | roles("doc") | join("、") }}
            {% endif %}
            {% if r.deletion %}
            - 删除了 {{ r.deletion | join("、") }}
            {% endif %}
         {% endfor %}

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

      man/*/index
      man/*

   -----------------------------------------------------------------------------

   .. toctree::
      :caption: 随记
      :reversed:
      :maxdepth: 2
      :glob:

      misc/*/index

   -----------------------------------------------------------------------------

   .. toctree::
      :caption: 收集室
      :maxdepth: 1
      :glob:

      collections/*
      collections/*/index

   -----------------------------------------------------------------------------

   .. toctree::
      :caption: 关于
      :maxdepth: 1

      我 <about/me>
      about/site
      about/friends
      简历 <about/resume>
