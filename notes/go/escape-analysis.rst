========
逃逸分析
========

.. highlight:: console

输出逃逸分析日志::

   $ go build -gcflags=-m main.go

传递两次可以显示更详细的信息::

   $ go build -gcflags='-m -m' main.go

可能出现的 log 如下：

- `XXX escapes to heap`
- `moved to heap: XXX`
- `XXX does not escape`
- `leaking param: XXX`
- `XXX ignoring self-assignment in YYY = ZZZ` [#]_
- `can inline XXX`
- `inlining call to XXX`


.. seealso:: :so.a:`51520445`

.. [#] https://github.com/golang/go/issues/27772

