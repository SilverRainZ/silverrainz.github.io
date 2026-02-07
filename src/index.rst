:layout: landing

.. Bullet documentation master file, created by
   sphinx-quickstart on Wed May 20 21:28:31 2020.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

========
银色子弹
========

.. rst-class:: lead

   :friend:`i` 的结构化笔记系统

.. container:: buttons

    `继续浏览 <#entrance>`_
    `源码 <https://github.com/SilverRainZ/bullet>`_

.. recentupdate:: 5

   .. dropdown:: 最近更新

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

.. only:: private

   .. card::

      .. toctree::
         :caption: 浪人泊处
         :maxdepth: 1

         in/inbox/index
         in/gtd/okr/index
         in/homelab/index

.. grid::
   :gutter: 2

   .. grid-item-card::
      :columns: 12 4 4 4

      .. toctree::
         :name: entrance
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

      .. class:: ablog-toctree
      .. toctree::
         :caption: 博客
         :maxdepth: 1

         所有文章 <blog/index>

      .. postlist:: 8
         :format: {title}
         :list-style: disc
