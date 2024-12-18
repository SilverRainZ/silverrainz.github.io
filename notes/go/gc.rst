==
GC
==

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

GC Trace
========

setting `gctrace=1` causes the garbage collector to emit a single line to standard
error at each collection, summarizing the amount of memory collected and the
length of the pause. The format of this line is subject to change.
Currently, it is::

   gc # @#s #%`: #+#+# ms clock, #+#/#/#+# ms cpu, #->#-># MB, # MB goal, # MB stacks, #MB globals, # P

where the fields are as follows:

:`gc #`:         the GC number, incremented at each GC
:`@#s`:          time in seconds since program start
:`#%`:           percentage of time spent in GC since program start
:`#+...+#`:      wall-clock/CPU times for the phases of the GC
:`#->#-># MB`:   heap size at GC start, at GC end, and live heap
:`# MB goal`:    goal heap size
:`# MB stacks`:  estimated scannable stack size
:`# MB globals`: scannable global size
:`# P`:          number of processors used

The phases are stop-the-world (STW) sweep termination, concurrent
mark and scan, and STW mark termination. The CPU times
for mark/scan are broken down in to assist time (GC performed in
line with allocation), background GC time, and idle GC time.
If the line ends with "(forced)", this GC was forced by a
`runtime.GC()` call. [#]_

.. [#] https://pkg.go.dev/runtime
