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

清除构建缓存 [#]_ ::

   $ debian/rules clean

.. [#] https://www.debian.org/doc/manuals/maint-guide/build.en.html
.. [#] https://www.debian.org/doc/manuals/maint-guide/update.en.html
.. [#] https://stackoverflow.com/a/23872636
