:layout: landing

====
画廊
====

.. data:template::

   {% for line in content %}
   .. grid-item::
      .. artwork+embed:: {{ line }} 

         .. figure:: /_assets/aw/{{ '{{ id }}' }}.webp

            {{ '``{{ name }}``, {{ date.year}}' }}

   {% endfor %}

.. data:schema::

   words of str

.. grid:: 1 2 5 5

   .. data:def::

      xfczk-039 xfczk-018 xfczk-030 cs-003 bflv-008 bflv-022
      letter-002 cs-008 m-006

最近画了……
==========

- 2026, :doc:`/notes/zxsys/way-to-artist/prod` 
- 2025, :doc:`/p/belated-drawing` 
- 2024, :doc:`/p/be-fall-in-love` 

所有作品
========

======== ================================
索引类型 索引页面
-------- --------------------------------
系列     :ref:`any-artwork.id+by-hyphen`
媒介     :ref:`any-artwork.medium`
尺幅     :ref:`any-artwork.size`
时间     :ref:`any-artwork.date+by-year`
======== ================================
