.. highlight:: console

=================================
Golang Compiler and Related Tools
=================================

:Date: 2022-02-08

.. contents::
   :local:

编译
====

逃逸分析
--------

输出逃逸分析日志::

   $ go build -gcflags=-m main.go

传递两次可以显示更详细的信息::

   $ go build -gcflags='-m -m' main.go

可能出现的 log 如下：

:so.a:`51520445`

- `XXX escapes to heap`
- `moved to heap: XXX`
- `XXX does not escape`
- `leaking param: XXX`
- `XXX ignoring self-assignment in YYY = ZZZ` :ghissue:`golang/go#27772`
- `can inline XXX`
- `inlining call to XXX`

测试
====

Profiling
---------

生成 pprof 文件::

   $ go test ./foo -cpuprofile cpu.pprof

查看火焰图::

   $ go tool pprof -http :8080 cpu.pprof

覆盖率
------

显示覆盖率::

   $ go test ./... -cover

测试覆盖报告::

   $ go test -coverprofile=c.out ./iter/...
   $ go tool cover -html=c.out

Runtime
=======
