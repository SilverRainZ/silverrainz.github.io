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

         ronin/okr/index
         ronin/inbox/index
         ronin/ops/index

--------------------------------------------------------------------------------

.. grid:: 1 2 2 2
   :gutter: 2

   .. grid-item-card::

      .. toctree::
         :caption: 笔记
         :maxdepth: 1
         :glob:

         notes/zxsys/index
         notes/artstory/index
         notes/books/index
         notes/man/index
         notes/color/index
         notes/*/index

   .. grid-item-card::

      .. toctree::
         :caption: 博客
         :maxdepth: 1

         所有博客 <blog/index>

      .. postlist:: 8
         :format: {title}
         :list-style: disc

   .. grid-item-card::

      .. toctree::
         :caption: 随记
         :maxdepth: 2
         :glob:

         jour/2024/index
         jour/2023/index
         jour/more


   .. grid-item::

      .. card::

         .. toctree::
            :caption: 关于
            :maxdepth: 1

            about/site
            我 <about/me>
            about/friends

      .. card::

         .. toctree::
            :caption: 收集室
            :maxdepth: 1
            :glob:

            collections/*
            collections/*/index
