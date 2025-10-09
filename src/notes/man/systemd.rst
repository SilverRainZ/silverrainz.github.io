=======
SystemD
=======

.. highlight:: console

systemctl
=========

List all running services::

   $ systemctl list-units --type=service --state=running

journalctl
==========

查看本次开机内核错误日志::

   journalctl -p 3 -xb

:`-p 3`: priority err
:`-x`:   provides extra message information
:`-b`:   print logs since last boot
