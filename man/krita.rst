=====
Krita
=====

快捷键
======

``e``:
    切换画笔和橡皮

``v``:
    画直线

``+``/``-``:
    放大缩小，不需要按 ``shift``

按住 ``space`` + 拖动:
    移动画布

``shift`` + ``space`` + 拖动:
    旋转画布

``5``/``4``/``6``:
    复位画布角度/左旋 15 度/右旋 15 度

``shift`` + 拖动:
    调整笔刷大小

``ctrl`` + ``shift`` + ``a``:
    取消选区

来自 :friend:`frantic1048` 的一图流。

.. image:: /_images/krita-shortcut.png

Tips
====

至少建立三个图层
----------------

背景图层 bg，线稿图层 sketch，明暗图层 Ink。

线稿透明化
----------

将线稿转换为透明度高的颜色可以更方便地勾线，通常以蓝色为宜。

1. 转换线稿为蓝色

  - 在图层的属性(Porperties)的活动通道(Acitve Channel)中取消蓝色通道的选择
  - 或者使用油漆桶工具选取蓝色（或者其他透明度高的颜色），再选中工具栏中的
    Preserve Alpha 选项，接着对图层进行着色

2. 调整图层的透明度

.. Note:: Preserve alpha will keep the transparency of the layer you're applying
    a filter or FX (whatever when applicable) intact, meaning the effect/filter
    etc will not affect/expand to the transparent areas.
    即，透明区域不会被当前的操作影响到。
