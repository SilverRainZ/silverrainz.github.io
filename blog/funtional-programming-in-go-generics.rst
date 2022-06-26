==================================
函数式编程在 Go 泛型下的实用性探索
==================================


.. post:: 2021-10-27
   :tags: Golang, 泛型, 函数式编程
   :author: LA
   :language: zh_CN

.. highlight:: go

背景
====

函数式编程（Functional Programming / FP）作为一种编程范式，具有无状态、无副作用、并发友好、抽象程度高等优点。目前流行的编程语言（C++、Python、Rust）都或多或少地引入了函数式特性，但在同作为流行语言的 Golang 中却少有讨论。

究其原因，大部分的抱怨 [2]_ [3]_ 集中于 Go 缺乏对范型的支持，难以写出类型间通用的函数。代码生成只能解决一部分已知类型的处理，且无法应对类型组合导致复杂度（比如实现一个通用的 TypeA → TypeB 的 map 函数）。

有关泛型的提案 `spec: add generic programming using type parameters #43651`__ 已经被 Go 团队接受，并计划在 2022 年初发布支持范型的 Go 1.18，现在 golang/go 仓库的 master 分支已经支持范型。

   This design has been proposed and accepted as a future language change. We currently expect that this change will be available in the Go 1.18 release in early 2022. [1]_

基于这个重大特性，我们有理由重新看看，函数式特性在 Go 范型的加持下，能否变得比以往更加实用。

__ https://github.com/golang/go/issues/43651

概述
====

这篇文章里，我们会尝试用 Go 的泛型循序渐进地实现一些常见的函数式特性，从而探索 Go 泛型的优势和不足。

除非额外说明（例如注释中的 `// INVALID CODE!!!`），文章里的代码都是可以运行的（为了缩减篇幅，部分删去了 `package main` 声明和 `main` 函数，请自行添加）。你可以自行 从源码编译__ 一个 master 版本的 go 来提前体验 Go 的泛型，或者用 `The go2go Playground`__ 提供的在线编译器运行单个文件。

__ https://golang.org/doc/install/source#install
__ https://go2goplay.golang.org/

泛型语法
========

提案的 `#Very high level overview`__ 一节中描述了为范型而添加的新语法，这里简单描述一下阅读本文所需要的语法：

- 函数名后可以附带一个方括号，包含了该函数涉及的类型参数（Type Paramters）的列表：`func F[T any](p T) { ... }`
- 这些类型参数可以在函数参数和函数体中（作为类型）被使用
- 自定义类型也可以有类型参数列表：`type M[T any] []T`
- 每个类型参数对应一个类型约束，上述的 `any` 就是预定义的匹配任意类型的约束
- 类型约束在语法上以 `interface` 的形式存在，在 `interface` 中嵌入类型 `T` 可以表示这个类型必须是 `T`::

   type Integer1 interface {
       int
   }

- 嵌入单个类型意义不大，我们可以用 `|` 来描述类型的 union::

   type Integer2 interface {
       int | int8 | int16 | int32 | int64
   }

- `~T` 语法可以表示该类型的「基础类型」是 `T`，比如说我们的自定义类型 `type MyInt int` 不满足上述的 `Integer1` 约束，但满足以下的约束::

   type Integer3 interface {
       ~int
   }

.. hint:: 「基础类型」在提案中为 "underlying type"，目前尚无权威翻译，在本文中使用仅为方便描述。

__ https://go.googlesource.com/proposal/+/refs/heads/master/design/43651-type-parameters.md#very-high-level-overview

高阶函数
========

在函数式编程语言中，:zhwiki:`高阶函数` （Higher-order function）是一个重要的特性。高阶函数是至少满足下列一个条件的函数： 

- 接受一个或多个函数作为输入
- 输出一个函数

Golang 支持闭包，所以实现高阶函数毫无问题::

   func foo(bar func() string) func() string {
           return func() string {
                   return "foo" + " " + bar()
           }
   }

   func main() {
           bar := func() string {
                   return "bar"
           }
           foobar := foo(bar)
           fmt.Println(foobar())
   }
   // Output:
   // foo bar

filter 操作是高阶函数的经典应用，它接受一个函数 f（`func (T) bool`）和一个线性表 l（`[] T`），对 l 中的每个元素应用函数 f，如结果为 `true`，则将该元素加入新的线性表里，否则丢弃该元素，最后返回新的线性表。

根据上面的泛型语法，我们可以很容易地写出一个简单的 filter 函数::

   func Filter[T any](f func(T) bool, src []T) []T {
           var dst []T
           for _, v := range src {
                   if f(v) {
                           dst = append(dst, v)
                   }
           }
           return dst
   }

   func main() {
           src := []int{-2, -1, -0, 1, 2}
           dst := Filter(func(v int) bool { return v >= 0 }, src)
           fmt.Println(dst)
   } 
   // Output:
   // [0 1 2]

代码生成之困
------------

在 1.17 或者更早前的 Go 版本中，要实现通用的 Filter 函数有两种方式：

1. 使用 `interface{}` 配合反射，牺牲一定程度的类型安全和运行效率
2. 为不同数据类型实现不同的 Filter 变种，例如 `FilterInt`、`FilterString` 等，缺点在于冗余度高，维护难度大

方式 2 的缺点可以通过代码生成规避，具体来说就使用相同的一份模版，以数据类型为变量生成不同的实现。我们在 Golang 内部可以看到不少 代码生成的例子__ 。

那么，有了代码生成，我们是不是就不需要泛型了呢？

答案是否定的：

1. 代码生成只能针对已知的类型生成代码，明明这份模版对 `float64` 也有效，但作者只生成了处理 `int` 的版本，我们作为用户无能为力（用 `interface{}` 同理，我们能使用什么类型，取决于作者列出了多少个 type switch 的 cases）

   而在泛型里，新的类型约束语法可以统一地处理「基础类型」相同的所有类型::

      type signed interface {
              ~int | ~int8 | ~int16 | ~int32 | ~int64 | ~float32 | ~float64 | ~complex64 | ~complex128
      }

      func Neg[T signed](n T) T {
              return -n
      }

      func main() {
              type MyInt int

              fmt.Println(Neg(1))
              fmt.Println(Neg(1.1))
              fmt.Println(Neg(MyInt(1)))
      } 
      // Output:
      // -1
      // -1.1
      // -1

2. 代码生成难以应对需要类型组合的场景，我们来看另一个高阶函数 map：接受一个函数 f（`func (T1) T2`）和一个线性表 l1（`[]T1`），对 l1 中的每个元素应用函数 f，返回的结果组成新的线性表 l2（`[]T2`）

   如果使用代码生成的话，为了避免命名冲突，我们不得不写出 `MapIntInt`、`MapIntUint`、`MapIntString` 这样的奇怪名字，而且由于类型的组合，代码生成的量将大大膨胀。

   我们可以发现在现有的支持 FP 特性的 Go library 里：

   - 有的（ hasgo__ ）选择将 map 实现成了闭合运算（`[]T → []T`），牺牲了表达能力
   - 有的（ functional-go__ ）强行用代码生成导致接口数目爆炸
   - 有的（ fpGo__ ）选择牺牲类型安全用 interface{} 实现

   如果使用泛型的话，只需要定义这样的签名就好了::

      func Map[T1, T2 any](f func(T1) T2, src []T1) []T2

__ https://github.com/golang/go/search?q=filename%3Agen.go
__ https://pkg.go.dev/github.com/DylanMeeus/hasgo/types?utm_source=godoc#Ints.Map
__ https://pkg.go.dev/github.com/logic-building/functional-go/fp
__ https://pkg.go.dev/github.com/TeaEntityLab/fpGo#Map

无糖的泛型
----------

Go 的语法在一众的编程语言里绝对算不上简洁优雅。在官网上看到操作 channel 时 `<-` 的直观便捷让你心下暗喜，而一旦你开始写 real world 的代码，这个语言就处处难掩设计上的简陋。泛型即将到来，而这个语言的其他部分似乎没有做好准备：

闭包语法
~~~~~~~~

在 Haskell 中的匿名函数形式非常简洁：

.. code:: haskell

   filter (\x -> x >= 0) [-2, -1, 0, 1, 2] 
   -- Output:
   -- [0,1,2]

而在 Golang 里，函数的类型签名不可省略，无论高阶函数要求何种签名，调用者在构造闭包的时候总是要完完整整地将其照抄一遍 [2]_ ::

   func foo(bar func(a int, b float64, c string) string) func() string {
           return func() string {
                   return bar(1, 1.0, "")
           }
   }

   func main() {
           foobar := foo(func(_ int, _ float64, c string) string {
                   return c
           })
           foobar()
   }

这个问题可以归结于 Go 团队为了保持所谓的「大道至简」，而对类型推导这样提升效率降低冗余的特性的忽视（泛型的姗姗来迟又何尝不是如此呢？）。 `proposal: Go 2: Lightweight anonymous function syntax #21498`__ 提出了一个简化闭包调用语法的提案，但即使该提案被 accept，我们最快也只能在 Go 2 里见到它了。

__ https://github.com/golang/go/issues/21498

方法类型参数
~~~~~~~~~~~~

:enwiki:`链式调用 <Method_chaining>` （Method chaining）是一种调用函数的语法，每个调用都会返回一个对象，紧接着又可以调用该对象关联的方法，该方法同样也返回一个对象。链式调用能显著地消除调用的嵌套，可读性好。我们熟悉的 GORM 的 API 里就大量使用了链式调用::

   db.Where("name = ?", "jinzhu").Where("age = ?", 18).First(&user)

在函数式编程中，每个高阶函数往往只实现了简单的功能，通过它们的组合实现复杂的数据操纵。

在无法使用链式调用的情况下，高阶函数的互相组合是这样子的（这仅仅是两层的嵌套）::

   Map(func(v int) int { return v + 1 },
      Filter(func(v int) bool { return v >= 0 },
         []int{-2, -1, -0, 1, 2}))

如果用链式调用呢？我们继续沿用前面的 filter ，改成以下形式::

   type List[T any] []T

   func (l List[T]) Filter(f func(T) bool) List[T] {
           var dst []T
           for _, v := range l {
                   if f(v) {
                           dst = append(dst, v)
                   }
           }
           return List[T](dst)
   }

   func main() {
           l := List[int]([]int{-2, -1, -0, 1, 2}).
                   Filter(func(v int) bool { return v >= 0 }).
                   Filter(func(v int) bool { return v < 2 })
           fmt.Println(l)
   } 
   // Output:
   // [0 1]

看起来很美好，但为什么不用 map 操作举例呢？我们很容易写出这样的方法签名::

   // INVALID CODE!!!
   func (l List[T1]) Map[T2 any](f func(T1) T2) List[T2]

很遗憾这样的代码是没法通过编译的，我们会获得以下错误：

   invalid AST: method must have no type parameter

提案的 `#No parameterized methods`__ 一节明确表示了方法（method，也就是有 recevier 的函数）不支持单独指定类型参数：

   This design does not permit methods to declare type parameters that are specific to the method. The receiver may have type parameters, but the method may not add any type parameters. [1]_

这个决定实际上是个不得已的妥协。假设我们实现了上述的方法，就意味对于一个已经实例化了的 `List[T]` 对象（比如说 `List[int]`），它的 `Map` 方法可能有多个版本：`Map(func (int) int) List[int]` 或者 `Map(func (int) string) List[string]`，当用户的代码调用它们时，它们的代码必然在之前的某个时刻生成了，那么应该在什么时候呢？

1. 在编译期，更准确地说，在编译的 link 阶段，这需要 linker 去遍历整个 call graph，确定程序中到底使用了几个版本的 `Map`。问题在于反射（reflection）的存在：用户可以用 `reflect.MethodByName` 动态地调用对象的方法，所以即使遍历了整个 call graph，我们也无法确保用户的代码到底调用了几个版本的 `Map`
2. 在运行期，在第一次调用方法时 yield 到 runtime 中，生成对应版本的函数后 resume 回去，这要求 runtime 支持 JIT（Just-in-time compilation），而目前 Go 并不支持，即使未来 JIT 的支持提上日程，这也不是一蹴而就的事情

综上，Go 团队选择了不支持给 method 指定类型参数，完美了解决这个问题 🎉。

__ https://go.googlesource.com/proposal/+/refs/heads/master/design/43651-type-parameters.md#No-parameterized-methods

惰性求值
========

:zhwiki:`惰性求值` （Lazy Evaluation）是另一个重要的函数式特性，一个不严谨的描述是：在定义运算时候，计算不会发生，直到我们需要这个值的时候才进行。其优点在于能使计算在空间复杂度上得到极大的优化。 

下面的代码展示了一个平平无奇的 Add 函数和它的 Lazy 版本，后者在给出加数的时候不会立刻计算，而是返回一个闭包::

   func Add(a, b int) int {
           return a + b
   }

   func LazyAdd(a, b int) func() int {
           return func () int {
                   return a + b
           }
   }

上面这个例子没有体现出惰性求值节省空间的优点。基于我们之前实现的高阶函数，做以下的运算::

   l := []int{-2, -1, -0, 1, 2}
   l = Filter(func(v int) bool { return v > -2 }, l)
   l = Filter(func(v int) bool { return v < 2 }, l)
   l = Filter(func(v int) bool { return v != 0 }, l)
   fmt.Println(l)

计算过程中会产生 3 个新的长度为 5 的 `[]int`，空间复杂度为 :math:`O(3 * N)`，尽管常数在复杂度分析时经常被省略，但在程序实际运行的时候，这里的 3 就意味着 3 倍的内存占用。

假设这些高阶函数的求值是惰性的，则计算只会在对 `fmt.Println` 对参数求值的时候发生，元素从原始的 `l` 中被取出，判断 `if v > -2`、`if v < 2`，最后执行 `v + 1`，放入新的 `[]int` 中，空间复杂度依然是 :math:`O(N)`，但毫无疑问地我们只使用了一个 `[]int``。

泛型的引入对惰性求值的好处有限，大致和前文所述一致，但至少我们可以定义类型通用的 接口了::

   // 一个适用于线性结构的迭代器接口
   type Iter[T any] interface{ Next() (T, bool) }

   // 用于将任意 slice 包装成 Iter[T]
   type SliceIter[T any] struct {
           i int
           s []T
   }

   func IterOfSlice[T any](s []T) Iter[T] {
           return &SliceIter[T]{s: s}
   }

   func (i *SliceIter[T]) Next() (v T, ok bool) {
           if ok = i.i < len(i.s); ok {
                   v = i.s[i.i]
                   i.i++
           }
           return
   }

接着实现惰性版本的 filter::

   type filterIter[T any] struct {
           f   func(T) bool
           src Iter[T]
   }

   func (i *filterIter[T]) Next() (v T, ok bool) {
           for {
                   v, ok = i.src.Next()
                   if !ok || i.f(v) {
                           return
                   }
           }
   }

   func Filter[T any](f func(T) bool, src Iter[T]) Iter[T] {
           return &filterIter[T]{f: f, src: src}
   }

可以看到这个版本的 filter 仅仅返回了一个 `Iter[T]`（`*filterIter[T]`），实际的运算在 `*filterIter[T].Next()` 中进行。

我们还需要一个将 `Iter[T]` 转回 `[]T` 的函数::

   func List[T any](src Iter[T]) (dst []T) {
           for {
                   v, ok := src.Next()
                   if !ok {
                           return
                   }
                   dst = append(dst, v)
           }
   }

最后实现一个和上面等价的运算，但实际的计算工作是在 `List(i)` 的调用中发生的::

   i := IterOfSlice([]int{-2, -1, -0, 1, 2})
   i = Filter(func(v int) bool { return v > -2 }, i)
   i = Filter(func(v int) bool { return v < 2 }, i)
   i = Filter(func(v int) bool { return v != 0 }, i)
   fmt.Println(List(i))

Map 的迭代器
------------

Golang 中的 Hashmap `map[K]V` 和 Slice `[]T` 一样是常用的数据结构，如果我们能将 map 转化为上述的 `Iter[T]`，那么 map 就能直接使用已经实现的各种高阶函数。

`map[K]V` 的迭代只能通过 `for ... range` 进行，我们无法通过常规的手段获得一个 iterator。反射当然可以做到，但 `reflect.MapIter` 太重了。:ghrepo:`modern-go/reflect2` 提供了一个 更快的实现__ ，但已经超出了本文的讨论范围，此处不展开，有兴趣的朋友可以自行研究。

__ https://pkg.go.dev/github.com/modern-go/reflect2#UnsafeMapIterator

局部应用
========

:enwiki:`局部应用 <Partial_application>` （Partial Application）是一种固定多参函数的部分参数，并返回一个可以接受剩余部分参数的函数的操作。

.. note:: 局部应用不同于 :zhwiki:`柯里化` （Currying） [4]_ ，柯里化是一种用多个单参函数来表示多参函数的技术，在 Go 已经支持多参函数的情况下，本文暂时不讨论 Currying 的实现。

我们定义一个有返回值的接收单个参数的函数类型::

   type FuncWith1Args[A, R any] func(A) R

对一个只接受一个参数的函数进行一次 partial application，其实就相当于求值::

   func (f FuncWith1Args[A, R]) Partial(a A) R {
           return f(a)
   }

接受两个参数的函数被 partial application 后，一个参数被固定，自然返回一个上述的 `FuncWith1Args`::

   type FuncWith2Args[A1, A2, R any] func(A1, A2) R

   func (f FuncWith2Args[A1, A2, R]) Partial(a1 A1) FuncWith1Args[A2, R] {
           return func(a2 A2) R {
                   return f(a1, a2)
           }
   }

我们来试用一下，将我们之前实现的 filter 包装成一个 `FuncWith2Args`，从左到右固定两个参数，最后得到结果::

   f2 := FuncWith2Args[func(int) bool, Iter[int], Iter[int]](Filter[int])
   f1 := f2.Partial(func(v int) bool { return v > -2 })
   r := f1.Partial(IterOfSlice([]int{-2, -1, -0, 1, 2}))
   fmt.Println(List(r)) 
   // Output:
   // [-1 0 1 2]

类型参数推导
------------

我们勉强实现了 partial application，可是把 `Filter` 转换为 `FuncWith2Args` 的过程太过繁琐，在上面的例子中，我们把类型参数完整地指定了一遍，是不是重新感受到了 闭包语法_ 带给你的无奈？

这一次我们并非无能为力，提案中的 `#Type inference`__ 一节描述了对类型参数推导的支持情况。上例的转换毫无歧义，那我们把类型参数去掉::

   // INVALID CODE!!!
   f2 := FuncWith2Args(Filter[int])

编译器如是抱怨：

   cannot use generic type FuncWith2Args without instantiation

提案里的类型参数推导仅针对函数调用，`FuncWith2Args(XXX)` 虽然看起来像是函数调用语法，但其实是一个类型的实例化，针对类型实例化的参数类型推导（ `#Type inference for composite literals`__ ）还是一个待定的 feature。

如果我们写一个函数来实例化这个对象呢？很遗憾，做不到：我们用什么表示入参呢？只能写出这样「听君一席话，如听一席话」的函数::

   func Cast[A1, A2, R any](f FuncWith2Args[A1, A2, R]) FuncWith2Args[A1, A2, R] {
           return f
   }

但是它能工作！当我们直接传入 Filter 的时候，编译器会帮我们隐式地转换成一个 `FuncWith2Args[func(int) bool, Iter[int], Iter[int]]`！同时因为函数类型参数推导的存在，我们不需要指定任何的类型参数了::

   f2 := Cast(Filter[int])
   f1 := f2.Partial(func(v int) bool { return v > -2 })
   r := f1.Partial(IterOfSlice([]int{-2, -1, -0, 1, 2}))
   fmt.Println(List(r)) 
   // Output:
   // [-1 0 1 2]

__ https://go.googlesource.com/proposal/+/refs/heads/master/design/43651-type-parameters.md#type-inference
__ https://go.googlesource.com/proposal/+/refs/heads/master/design/43651-type-parameters.md#type-inference-for-composite-literals

可变类型参数
------------

`FuncWith1Args` 、`FuncWith2Args` 这些名字让我们有些恍惚，仿佛回到了代码生成的时代。为了处理更多的参数，我们还得写 `FuncWith3Args`、`FuncWith4Args`… 吗？

是的， `#Omissions`__ 一节提到：Go 的泛型不支持可变数目的类型参数：

   No variadic type parameters. There is no support for variadic type parameters, which would permit writing a single generic function that takes different numbers of both type parameters and regular parameters.

对应到函数签名，我们也没有语法来声明拥有不同类型的可变参数。

__ https://go.googlesource.com/proposal/+/refs/heads/master/design/43651-type-parameters.md#omissions

类型系统
========

众多函数式特性的实现依赖于一个强大类型系统，Go 的类型系统显然不足以胜任，作者不是专业人士，这里我们不讨论其他语言里让人羡慕的类型类（Type Class）、代数数据类型（Algebraic Data Type），只讨论在 Go 语言中引入泛型之后，我们的类型系统有哪些水土不服的地方。

.. hint:: 其实上文的大部分问题都和类型系统息息相关，case by case 的话我们可以列出非常多的问题，因此以下只展示明显不合理那部分。

编译期类型判断
--------------

当我们在写一段泛型代码里的时候，有时候会需要根据 `T` 实际上的类型决定接下来的流程，可 Go 的完全没有提供在编译期操作类型的能力。运行期的 workaround 当然有，怎么做呢：将 `T` 转化为 `interface{}`，然后做一次 type assertion::

   func Foo[T any](n T) {
           if _, ok := (interface{})(n).(int); ok {
                   // do sth...
           }
   }

无法辨认「基础类型」
--------------------

我们在 代码生成之困_ 提到过，在类型约束中可以用 `~T` 的语法约束所有 基础类型为 `T` 的类型，这是 Go 在语法层面上首次暴露出「基础类型」的概念，在之前我们只能通过 `reflect.(Value).Kind` 获取。而在 type assertion 和 type switch 里并没有对应的语法处理「基础类型」::

   type Int interface {
           ~int | ~uint
   }

   func IsSigned[T Int](n T) {
           switch (interface{})(n).(type) {
           case int:
                   fmt.Println("signed")
           default:
                   fmt.Println("unsigned")
           }
   }

   func main() {
           type MyInt int
           IsSigned(1)
           IsSigned(MyInt(1))
   } 
   // Output:
   // signed
   // unsigned

乍一看很合理，`MyInt` 确实不是 `int`。那我们要如何在函数不了解 `MyInt` 的情况下把它当 `int` 处理呢？答案是还不能： `#Identifying the matched predeclared type`__ 表示这是个未决的问题，需要在后续的版本中讨论新语法。总之，在 1.18 中，我们是见不到它了。

__ https://go.googlesource.com/proposal/+/refs/heads/master/design/43651-type-parameters.md#identifying-the-matched-predeclared-type

类型约束不可用于 type assertion
-------------------------------

一个直观的想法是单独定义一个 Signed 约束，然后判断 T 是否满足 Signed::

   type Signed interface {
           ~int
   }

   func IsSigned[T Int](n T) {
           if _, ok := (interface{})(n).(Signed); ok {
                   fmt.Println("signed")
           } else {
                   fmt.Println("unsigned")
           }
   }

但很可惜，类型约束不能用于 type assertion/switch，编译器报错如下：

   interface contains type constraints

尽管让类型约束用于 type assertion 可能会引入额外的问题，但牺牲这个支持让 Go 的类型表达能力大大地打了折扣。

总结
====

函数式编程的特性不止于此，代数数据类型、引用透明（Referential Transparency）等在本文中都未能覆盖到。
总得来说，Go 泛型的引入：

1. 使的部分 *函数式特性能以更通用的方式被实现*
2. *灵活度比代码生成更高* ，用法更自然，但细节上的小问题很多
3. 1.18 的泛型在引入 type paramters 语法之外并没有其他大刀阔斧的改变，导致泛型和这个语言的其他部分显得有些格格不入，也使得泛型的能力受限。 *至少在 1.18 里，我们要忍受泛型中存在的种种不一致*
4. 受制于 Go 类型系统的表达能力，我们无法表示复杂的类型约束，自然也 *无法实现完备的函数式特性*

参考
====

.. [1] `Type Parameters Proposal`__
.. [2] `Golang 函数式编程简述`__
.. [3] `GopherCon 2020: Dylan Meeus - Functional Programming with Go`__
.. [4] `Partial Function Application is not Currying`__

__ https://go.googlesource.com/proposal/+/refs/heads/master/design/43651-type-parameters.md
__ https://hedzr.com/golang/fp/golang-functional-programming-in-brief/
__ https://www.youtube.com/watch?v=wqs8n5Uk5OM
__ https://www.uncarved.com/articles/not-currying/
