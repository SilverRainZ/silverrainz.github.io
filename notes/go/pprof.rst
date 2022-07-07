=====
PProf
=====

.. highlight:: console

生成 pprof 文件::

   $ go test ./foo -cpuprofile cpu.pprof

查看火焰图::

   $ go tool pprof -http :8080 cpu.pprof
