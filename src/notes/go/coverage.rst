======
覆盖率
======

.. highlight:: console

显示覆盖率::

   $ go test ./... -cover

测试覆盖报告::

   $ go test -coverprofile=c.out ./iter/...
   $ go tool cover -html=c.out
