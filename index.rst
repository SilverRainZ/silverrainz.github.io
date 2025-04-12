:nocomments:

.. Bullet documentation master file, created by
   sphinx-quickstart on Wed May 20 21:28:31 2020.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

====
首页
====

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

.. only:: private

   .. card::

      .. toctree::
         :caption: 浪人泊处
         :maxdepth: 1

         ronin/inbox/index
         ronin/okr/index
         ronin/ops/index
         ronin/loveletters/index

--------------------------------------------------------------------------------

.. grid::
   :gutter: 2

   .. grid-item-card::
      :columns: 12 4 4 4

      .. toctree::
         :caption: 笔记
         :maxdepth: 1
         :glob:

         notes/zxsys/index
         notes/artstory/index
         notes/books/index
         notes/man/index
         notes/*/index

   .. grid-item-card::
      :columns: 12 8 8 8

      .. toctree::
         :caption: 文章
         :maxdepth: 1

         所有文章 <blog/index>

      .. postlist:: 8
         :format: {title}
         :list-style: disc

   .. grid-item-card::
      :columns: 12 4 4 4

      .. toctree::
         :caption: 随记
         :maxdepth: 2
         :glob:

         jour/2024/index
         jour/2023/index
         jour/more


   .. grid-item-card::
      :columns: 12 4 4 4

      .. toctree::
         :caption: 关于
         :maxdepth: 1

         about/site
         我 <about/me>
         about/friends

   .. grid-item-card::
      :columns: 12 4 4 4

      .. toctree::
         :caption: 收集室
         :maxdepth: 1
         :glob:

         collections/*
         collections/*/index
