====
cURL
====

.. highlight:: console

:manpage:`curl(1)`

只显示 Status Code
==================

::

   $ curl -s -o /dev/null -I -w "%{http_code}" http://www.example.org/

:-s,--slient: `` 防止因输出重定向而显示 progress bar
:-w,--write-out: 按固定格式输出，详情看 manpage
