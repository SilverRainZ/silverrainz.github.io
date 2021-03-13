===
Vim
===

---------------------------
By the way I use NeoVim :-)
---------------------------

:date: 2021-02-08

.. highlight:: vim

Execute script in comment(mode line)::

    /* vim: set filetype=rst: */


批量处理文件
=============

用 ``args`` 批量打开文件, 用 ``argdo`` 批量处理::

    " 给 MnO2 的 PR: 把书中所有的 ``` 替换为 ```haskell
    :cd GitHub\learnyouahaskell-zh\
    :args *\*\*.md
    :argdo %s/```\(\n.\)\@=/```haskell/ge | update

-  其中\ ``\(\)\@=``\ 是正则的零宽断言
-  ``/ge``\ 的\ ``e``\ 代表忽略错误
-  ``|``\ 是命令连接符
-  ``update`` 表示文件发生改动后存盘, 不用 ``update`` 的话处理完一个文件会提示文件未保存
  (意思大概是处理完一个文件随即退出, 要手动存盘)
