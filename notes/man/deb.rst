==============
Debian Packing
==============

.. highlight:: console

:file:`debian/rules` 其实就是一个 :doc:`./make` 文件。

构建 deb 包 [#]_ ::

   $ fakeroot debian/rules binary

安装本地的deb 包::

   # dpkg -i ./xxx.deb

更新 :file:`debian/changelog` [#]_ ，需要 `devscripts`::

   $ dch -i

`dch` 命令位于 `devscripts` 包中。

.. [#] https://www.debian.org/doc/manuals/maint-guide/build.en.html
.. [#] https://www.debian.org/doc/manuals/maint-guide/update.en.html
