================
Slice Expression
================

.. highlight:: go

:Spec: https://go.dev/ref/spec#Slice_expressions

.. note::

   - Slice expr 只是创建「数据的视图」，*不会开辟新空间*
   - 和 Python 不同，Go 的 slice expr 会导致 out of range panic，
     但对于 low 和 high 来说 "range" 的定义是不同的

Out of Range
============

low 和 high 的取值范围如下，超出返回会导致 panic：

:low:    `[0, len)`
:high:   `[0, cap)`

.. literalinclude :: slice-expr.go
   :lines: 4-15

Extend Capacity
===============

利用 high 的取值范围可以将 slice 长度扩张到其容量上限::

   s = s[:cap(s)]

.. literalinclude :: slice-expr.go
   :lines: 19-24
