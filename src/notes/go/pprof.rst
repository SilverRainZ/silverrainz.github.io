=====
PProf
=====

.. highlight:: console

生成 pprof 文件::

   $ go test ./foo -cpuprofile cpu.pprof

查看火焰图::

   $ go tool pprof -http :8080 cpu.pprof


Notable Sample 
==============

slice 扩容
   `runtime.growslice`


map 扩容
   `runtime.hashGrow`

   :`runtime.mapassign`:                              `runtime.growWork`
   :`runtime.mapassign_faststr`:                      `runtime.growWork_faststr`
   :`runtime.{mapassign_fast32,mapassign_fast32ptr}`: `runtime.growWork_fast32`
   :`runtime.{mapassign_fast64,mapassign_fast64ptr}`: `runtime.growWork_fast64`
