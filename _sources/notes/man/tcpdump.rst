=======
tcpdump
=======

.. highlight:: console

:manpage:`TCPDUMP(1)`

Dump HTTP traffic in text format
================================

:-A: Print each packet (minus its link level header) in ASCII. Handy for capturing web pages.

::

   # tcpdump 'host example.com and port 80' -A
   # tcpdump 'dst 127.0.0.1 and port 80' -A
