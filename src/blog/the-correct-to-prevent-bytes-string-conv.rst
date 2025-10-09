======================================================
Golang 中避免 `[]bytes` 和 `string` 转换开销的正确方法
======================================================

.. post:: 2024-05-19
   :tags: Golang, 性能优化
   :author: LA
   :language: zh_CN
   :location: 杭州

.. default-role:: code

.. |b| replace:: `[]byte`
.. |s| replace:: `string`
.. |bxs| replace:: |b| ⇆  |s|
.. |b2s| replace:: |b| →  |s|
.. |s2b| replace:: |s| →  |b|

.. note::

   本文写于 2024 年 5 月，基于 `go version go1.22.3 linux/amd64` 展开讨论。
   一些事实（尤其是编译优化的条件）会随着时间发生改变。

   本文涉及的所有测试脚本与代码可在 此处__ 获取。

   __ https://github.com/SilverRainZ/silverrainz.github.io/tree/master/_assets/bsconv

背景和现状
==========

在 Golang 中，绝大部分的 type conversion 的运行时开销较小，但 |bxs| 是一个
特例：由于 |s| 类型不可变（immutable），而 |b| 类型可变（mutable），
两者转换时会导致内存的拷贝 [1]_：

- |s2b| 会导致运行时的 `runtime.stringtoslicebyte` 开销
- |b2s| 会导致运行时的 `runtime.slicebytetostring` 开销

不少开发人员对此类转换缺乏足够的敏感，导致编码中这样的开销随处可见。
另一方面这也是 Go 语言本身的缺陷：无法对变量的可变性进行约束，无法做更精准的
逃逸分析，导致 runtime 对此类转换的开销优化相当有限。

unsafe is not safe
------------------

而当开销逐渐累计为性能瓶颈时，开发人员又会开始寻求快速优化的途径，且往往会
尝试简单粗暴的操作：通过 `unsafe` 包强制将 |s| 指向 |b| 的底层数据，
或反之，以避免内存的拷贝。

unsafe 绝非理想的解决方案，首先它打破了类型上 immutable 和 mutable 的约定，
可能导致程序的逻辑错误，在广泛使用并发的 Go 里就更容易出问题了；其次，使用
unsafe 时稍有不当就会导致非预期的内存 BUG，即使是有经验的开发者也很难
不踩坑：

- `modern-go/reflect2#12`__: |s| 转 |b| 的过程中，将构造好的
  `reflect.SliceHeader` 转回 |b| 之前，GC 可能将 `SliceHeader.Data` 指向的
  数据回收
- `DataDog/zstd#91`__: 将栈上分配的 |b| 强转为 |s| 后，栈扩张导致 |s| 底层数据
  失效

__ https://github.com/modern-go/reflect2/pull/13
__ https://github.com/DataDog/zstd/pull/91

不完美的解决方案们
==================

Go Team 在编译器和标准库层面提供了一些方案，但总的来说不够好：

- 指标不治本：不够通用，不能覆盖所有场景
- 手段不一致：有些是编译器优化，有些是标准库 API

这些方案在不同的 Go 版本中被陆续加入，文档也散落在不同的地方，在我印象里似乎没有
人好好地把他们收集起来捋一捋。比起在网上的哪个旮旯里随便找个博客抄一段易燃易爆炸
的 unsafe 代码，我更希望使用官方推荐的解决方案，这对项目的稳定性和可维护性都
是大有裨益的。

编译优化
========

在以下的情况，编译器已经能直接省略 |bxs| 的开销了。如果你的应用对性能比较敏感，
你需要了解如何编写代码才能让它享受到编译器的优化，必要时可借助编译器的日志和
benchmark 做进一步的确认。

Go1.22: zero-copy |s2b| conversions
-----------------------------------

Go1.22 默认启用了一项叫 zerocopy 的优化 [2]_，如果一个由 |s| 转化
而来的 |b| 没有逃逸到堆上（`什么是逃逸？`__），且在它所有代码路径上都是
只读的（没有进行任何修改操作），那么转换的开销可以被省略。如下代码：

.. literalinclude:: /_assets/bsconv/zerocopy_test.go
   :language: go
   :linenos:
   :lines: 7-
   :lineno-start: 7

我们通过分别设置 `-gcflags='-d zerocopy=1'` [3]_ 和 `-gcflags='-d zerocopy=0'`
来开启和关闭优化，在此基础上进行测试：

.. code-block: console

   $ go test -gcflags='-d zerocopy=1 -m' -bench . -benchmem ./zerocopy_test.go
   $ go test -gcflags='-d zerocopy=0 -m' -bench . -benchmem ./zerocopy_test.go

结果如下：

.. literalinclude:: /_assets/bsconv/zerocopy.txt
   :language: text
   :emphasize-lines: 5,12

在测试的同时，我们还可以用 `-gcflags '-m'` [3]_ 输出编译器的优化日志，
通过对比可以发现，第 10 行的 |s2b| 转换在 `zerocopy=1` 的情况下被正确识别了：

.. literalinclude:: /_assets/bsconv/zerocopy1.log
   :diff: /_assets/bsconv/zerocopy0.log

.. note::

   这个优化并不支持另一个方向 |b2s| 的 zero copy，`@randall77 说`__ 难以实现
   |b| *在 conversions 之后是只读的* 这样的检查，并且多个 |b| 可以指向同一份
   数据，难以追踪。我其实没有完全理解，因为将优化的条件再收紧一些，
   感觉是可以做的？

   - 要求 |b| 完全地只读，而非在 conversions 之后只读
   - |b| 没有逃逸的话，完全跟踪所有指向底层存储的 slice 也非难事？

   这两点都已经在当前的 zerocopy 优化里实现了，好奇为什么不这么做。如果有熟悉
   编译器的朋友知道原因，希望不吝赐教。

   我纠结它为什么不实现的原因是，编译器在下面两种特殊情况下已经实现了 |b2s|，
   但只允许转换出来的 |s| 用于特定的内置操作（map查找和字符串运算），不能赋值给
   变量也不能传递给其他函数，非常受限。


__ https://golang2.eddycjy.com/posts/ch6/08-stack-heap/
__ https://github.com/golang/go/issues/2205#issuecomment-1067303496

Go1.5: bytes comparison
-----------------------

`[]bytes` 本质上是 slice 类型，无法直接判等，可以通过标准库 `bytes.Equal` 实现。
Go1.5 引入了一个优化 [4]_，将 |b| 临时转化为 |s| 用于判等时，不会产生额外的内存
分配。例如：

.. literalinclude:: /_assets/bsconv/equal_test.go
   :language: go
   :linenos:
   :lines: 12-16
   :lineno-start: 12

但如果你用一个变量储存转换出来的 |s|，哪怕逻辑上完全等价，优化会失效：

.. literalinclude:: /_assets/bsconv/equal_test.go
   :language: go
   :linenos:
   :lines: 17-23
   :lineno-start: 17

其他的字符串操作，例如比较大小 `>`、`<` 或者连接 `+` 也同样支持该优化：

.. literalinclude:: /_assets/bsconv/equal_test.go
   :language: go
   :linenos:
   :lines: 24-28
   :lineno-start: 24

Benchmark 结果如下：

.. literalinclude:: /_assets/bsconv/equal.txt
   :language: text
   :emphasize-lines: 5

其中 `bytes.Equal` 的结果看起来也是优化过的，这是因为在 Go1.13 以后
`bytes.Equal` 就是简单地用 `==` 实现了 [5]_：

.. code-block:: go
   :emphasize-lines: 6
   :caption: https://pkg.go.dev/bytes#Equal

   // Equal reports whether a and b
   // are the same length and contain the same bytes.
   // A nil argument is equivalent to an empty slice.
   func Equal(a, b []byte) bool {
           // Neither cmd/compile nor gccgo allocates for these string conversions.
           return string(a) == string(b)
   }
      
Go1.3: map lookup
------------------

Go1.3 引入了一个优化 [6]_，当将 |b| 临时转化为 |s| 并用于查询 map 时，
可以免去转换：

.. literalinclude:: /_assets/bsconv/maplookup_test.go
   :language: go
   :linenos:
   :lines: 13-17
   :lineno-start: 13

和上面类似，如果你用一个变量储存转换出来的 |s|，优化会失效：

.. literalinclude:: /_assets/bsconv/maplookup_test.go
   :language: go
   :linenos:
   :lines: 18-22
   :lineno-start: 18

Benchmark 结果如下：

.. literalinclude:: /_assets/bsconv/maplookup.txt

标准库使用姿势
==============

Go1.18 之前不支持泛型，因此标准库中有关 |s|/|b| 的接口如果需要另一种类型的支持，
基本就要加一个新接口。

当然，即使在已经有了泛型的 2024 年，标准库还是没有统一的方式来操作它们。
具体可以看这里的讨论：

- `proposal: byteseq: add a generic byte string manipulation package · Issue #48643 · golang/go <https://github.com/golang/go/issues/48643>`_
- `proposal: spec: byte view: type that can represent a []byte or string · Issue #5376 · golang/go <https://github.com/golang/go/issues/5376>`_

`strings` 和 `bytes`
--------------------

两个库提供了基本相同的功能，但分别针对 |s| 和 |b| 类型，
合理挑选函数可以避免转换：

.. code-block:: diff

     var s = []byte("hello world")
   - strings.HasPrefix(string(s), "hello")
   + bytes.HasPrefix(s, []byte("hello"))

`io.Writer` 和 `io.StringWriter`
--------------------------------

往 `io.Writer` 写入数据时，如果 writer 还同时实现了 `io.StringWriter`，
可以根据数据的类型选择调用 `Write` 方法或者 `WriteString` 方法以避免转换：

.. code-block:: diff

     var s = "hello world"
   - w.Write([]byte(s))
   + w.(io.StringWriter).WriteString(s)

标准库的 `io.WriteString` 就帮用户自动实现了这个逻辑：

.. code-block:: go
   :caption: https://pkg.go.dev/io#WriteString

   // WriteString writes the contents of the string s to w, which accepts a slice of bytes.
   // If w implements [StringWriter], [StringWriter.WriteString] is invoked directly.
   // Otherwise, [Writer.Write] is called exactly once.
   func WriteString(w Writer, s string) (n int, err error) {
           if sw, ok := w.(StringWriter); ok {
                   return sw.WriteString(s)
           }
           return w.Write([]byte(s))
   }

于是刚刚的代码就可以简化为：

.. code-block:: diff

     var s = "hello world"
     var w io.Writer
   - w.Write([]byte(s))
   + io.WriteString(w, s)

.. hint::

   比较遗憾的是，要求每个 `io.Writer` 都实现 `io.StringWriter` 是不现实的，
   很多情况下，我们持有一个 |s|，要喂给 `io.Writer` 时还是只能乖乖地转换。

   `io.Writer.Write` 的入参在约定上是只读的：

   .. code-block:: go
      :caption: https://pkg.go.dev/io#Writer
      :emphasize-lines: 7

      // Writer is the interface that wraps the basic Write method.
      //
      // Write writes len(p) bytes from p to the underlying data stream.
      // It returns the number of bytes written from p (0 <= n <= len(p))
      // and any error encountered that caused the write to stop early.
      // Write must return a non-nil error if it returns n < len(p).
      // Write must not modify the slice data, even temporarily.
      //
      // Implementations must not retain p.
      type Writer interface {
              Write(p []byte) (n int, err error)
      }

   我们可以畅想一下，编译器其实可以考虑直接省略该转换，但约定毕竟只是约定，
   没有强制力，如何识别修改 |b| 的边角 case 是个问题。社区对此有一些讨论：

   - `cmd/compile: read-only escape analysis and avoiding string -> []byte copies #2205`__
     已经由刚才提到的 zerocopy [2]_ 优化部分实现了
   - `cmd/compile: optimize Write([]byte(stringVal)) to not copy the string #18822`__

   __ https://github.com/golang/go/issues/2205#issuecomment-726468940
   __ https://github.com/golang/go/issues/18822

`strconv.AppendXXX`
-------------------

`strconv.FormatXXX` 系列函数将其他的基本类型（`int`、`float64` 等）转化为
|s|。某些情况下我们需要 |b| 形式的结果，可以使用 `strconv.AppendXXX`：

.. code-block:: diff

     var data []byte
   - data = []byte(strconv.FormatInt(1234, 10))
   + data = strconv.AppendInt(nil, 1234, 10)

Go1.20: `strconv.ParseXXX`
--------------------------

很遗憾，`ParseXXX` 系列函数至今没有等价的 |b| 版本实现，在 `strconv: add
equivalents of Parsexxx() with []byte arguments`__ 有过讨论但最终没有下文。
不过鉴于这类函数的合法入参总是比较短（不超过 `math.Max{Uint,Float64}`），
在栈上多复制一份也没什么大不了。

但有一个问题：当 parse 发生错误时，为了方便调试，错误信息会包含输入参数，例如执行
`strconv.ParseInt("a")` 会返回错误 `strconv.ParseInt: parsing "a": invalid syntax`。
在 Go1.20 前 [7]_，这会导致从而导致参数逃逸到堆上。

以下代码：

.. literalinclude:: /_assets/bsconv/strconv_test.go
   :language: go
   :linenos:
   :lines: 8-
   :lineno-start: 8

在 Go1.22 和 Go1.19 分别运行可以明显看到区别：

.. literalinclude:: /_assets/bsconv/strconv.txt
   :language: text
   :emphasize-lines: 5,12

对比两个版本的编译器的优化日志，临时变量 `string(s)` 在 1.22 是不会发生逃逸的：

.. literalinclude:: /_assets/bsconv/strconv122.log
   :diff: /_assets/bsconv/strconv119.log

__ https://github.com/golang/go/issues/2632

Go1.19: `fmt.Append{,f,ln}`
---------------------------

`fmt.Sprint{,f,ln}` 的返回值是 |s|，Go1.19 引入 [8]_ 的 `fmt.Append{,f,ln}` 可以
直接格式化地输出 |b|：

.. code-block:: diff

     var data []byte
   - data = []byte(fmt.Sprintf("hello %s", "alice"))
   + data = fmt.Appendf(nil, ("hello %s", "alice"))

脚注
====

.. [1] `Source file src/runtime/string.go <https://go.dev/src/runtime/string.go>`_
.. [2] `cmd/compile: enable -d=zerocopy by default (520600) · Gerrit Code Review <https://go-review.googlesource.com/c/go/+/520600>`_ 
.. [3] `compile command - cmd/compile - Go Packages <https://pkg.go.dev/cmd/compile>`_
.. [4] `cmd/gc: don't copy []byte during string comparison (3410) · Gerrit Code Review <https://go-review.googlesource.com/c/go/+/3410>`_
.. [5] `bytes: Equal more expensive than string equality · Issue #31587 · golang/go <https://github.com/golang/go/issues/31587>`_
.. [6] `Issue 83740044: code review 83740044: cmd/gc, runtime: optimize map[string] lookup from []byte key - Code Review <https://codereview.appspot.com/83740044>`_
.. [7] `strconv: optimize Parse for []byte arguments (345488) · Gerrit Code Review <https://go-review.googlesource.com/c/go/+/345488>`_
.. [8] `fmt: add Append, Appendln, Appendf (406177) · Gerrit Code Review <https://go-review.googlesource.com/c/go/+/406177>`_
