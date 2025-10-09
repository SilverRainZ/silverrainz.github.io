===========
ImageMagick
===========

.. highlight:: console

压缩 JPG 的推荐参数 [#]_ ::

   $ convert -strip -interlace Plane -gaussian-blur 0.05 -quality 85% FILENAME

顺时针旋转::

   $ convert -rotate 180 FILENAME

.. [#] https://stackoverflow.com/a/7262050/4799273
