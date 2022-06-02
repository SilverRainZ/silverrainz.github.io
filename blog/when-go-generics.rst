================
何时使用 Go 泛型
================

.. post:: 2022-06-03
   :tags: Golang, 泛型, 翻译
   :author: Ian Lance Taylor, LA
   :language: zh_CN

.. highlight:: go

.. note::

   这篇文章是 `When To Use Generics`__ 的中文翻译，作者是 Go Team 的 :ghuser:`ianlancetaylor`。

__ https://go.dev/blog/when-generics

介绍
====

Go 1.18 新增了一个重大的语言特性：泛型。本文不会描述泛型是什么以及如何使用它们。本文的重点是：*什么时候应该在代码中使用泛型，什么时候不使用它们*。

.. admonition:: 译者注

   关于泛型的简要介绍，可以看看 :doc:`./funtional-programming-in-go-generics`

需要明确的是，这里提供的是通用的准则而非硬性的规定。请结合你自己的判断。但如果你拿不准，建议还是采用本文提供的准则。

编码
====

让我们从 Go 编程的一般准则开始：通过编写代码编写 Go 程序，而不是通过定义类型编写 Go 程序。

.. admonition:: 译者注

   这里的意思可能类似软件工程中的「避免过度设计」。
   对于一般的编程来讲，我们应优先选择通过编写代码来实现逻辑，而非设计符合该逻辑的类型。

涉及到泛型，如果你通过定义类型参数约束（type parameter constraints）来作为编程的第一步，那么你可能走在了错误的道路上。请从编写函数开始。当你写完之后，你就会清楚泛型对这个函数是否有用，此时再添加类型参数（type parameters）也是非常简单的。

何时使用 type parameter
=======================

让我们看看在哪些情况下，类型参数是有用的。

当使用内置容器类型时
---------------------

一种情况是，当你编写对语言定义的器器类型进行操作的函数：slice、map 和 channel。 如果函数参数中存在对应的类型，并且函数代码没有对元素的类型做出任何特定假设，那么使用 type parameter 可能很有用。

例如，这是一个返回任意类型 map 中所有 key 的函数::

   // MapKeys returns a slice of all the keys in m.
   // The keys are not returned in any particular order.
   func MapKeys[Key comparable, Val any](m map[Key]Val) []Key {
       s := make([]Key, 0, len(m))
       for k := range m {
           s = append(s, k)
       }
       return s
   }

这段代码对 map 的 key 的类型没有任何的假设，它也根本不使用 map 的 value。所以它适用于任何 map 类型，这使它成为使用 type parameter 的好选择。

在这里，类型参数的替代实现通常是使用反射，但这是一个更别扭的编程模型：没有静态类型检查，并且在运行时通常更慢。

当编写通用数据结构时
---------------------

类型参数可能有用的另一种情况是用于编写通用数据结构。 通用数据结构类似于 slice 或 map，但不是语言内置的，例如链表或二叉树。

在之前，这样的数据结构通常会有两种实现方式：

1. 硬编码，只持特定的元素类型；
2. 使用 `interface{}`

用 type parameter 替换特定元素类型可以生成更通用的数据结构，可以在程序的其他部分或其他程序中使用。用类型参数替换 `interface{}` 则可以让数据存储更加地高效，节省内存资源；它还可以允许代码避免类型断言（type assertion），并在编译时进行全面的类型检查。

下面节选了用 type parameter 实现的二叉树作为例子::

   // Tree is a binary tree.
   type Tree[T any] struct {
       cmp  func(T, T) int
       root *node[T]
   }

   // A node in a Tree.
   type node[T any] struct {
       left, right  *node[T]
       val          T
   }

   // find returns a pointer to the node containing val,
   // or, if val is not present, a pointer to where it
   // would be placed if added.
   func (bt *Tree[T]) find(val T) **node[T] {
       pl := &bt.root
       for *pl != nil {
           switch cmp := bt.cmp(val, (*pl).val); {
           case cmp < 0:
               pl = &(*pl).left
           case cmp > 0:
               pl = &(*pl).right
           default:
               return pl
           }
       }
       return pl
   }

   // Insert inserts val into bt if not already there,
   // and reports whether it was inserted.
   func (bt *Tree[T]) Insert(val T) bool {
       pl := bt.find(val)
       if *pl != nil {
           return false
       }
       *pl = &node[T]{val: val}
       return true
   }

树中的每个节点都包含类型参数 `T` 的值。当使用特定类型参数实例化 `Tree` 类型时，该类型的值将直接存储在节点中，它们不会被存储为 `interface{}`。

这是对 type parameter 的一种合理使用，因为 `Tree` 本身包括其方法的逻辑，在很大程度上是和元素类型 `T` 无关的。

Tree 确实需要知道如何比较元素类型 `T` 的值，为此它使用了一个比较函数 `func(T, T) int`。 您可以在 `find` 方法的第 4 行调用 `bt.cmp` 中看到这一点。除此之外，类型参数根本不重要。

优先函数（function）而非方法（method）
--------------------------------------

.. admonition:: 译者注

   function 和 method 的区别在于 method 会关联一个对象（receiver）。

   `func Name(){}` 是 function ，而 `func (f Foo) Name(){}` 是 mehtod。

上面 `Tree` 的例子说明了另一个准则：当你需要比较之类的操作时，优先使用函数而非方法。

我们可以定义这样的 `Tree` 类型，要求元素必须实现 `Compare` 或 `Less` 方法。这将通过编写带方法的的类型约束（type constraint that requires the method）完成，这意味着用于实例化 `Tree` 类型的任何类型都需要实现该方法。

这样做的结果是，想要使用简单数据类型（如 `int`）的人都必须定义自己的整数类型并编写对应的方法。如果我们定义还是和上面一样，让 `Tree` 接受一个比较函数，那一切还是那么简单。编写比较函数就像编写方法一样容易。

如果 `Tree` 的元素类型恰好已经有一个 `Compare` 方法，那么我们可以简单地使用 `ElementType.Compare` 之类的表达式来实现比较函数。

*换句话说，将「方法转换为函数」比将「方法添加到类型」要简单得多。因此，对于通用数据类型，优先使用函数，而非带方法的类型约束*。

当实现通用的 method 时
----------------------

类型参数有用的另一种情况是：当不同类型需要实现一些共同的方法，并且它们的实现都看起来都一样时。

例如，考虑标准库的 `sort.Interface`。它要求一个类型实现三种方法：`Len`、`Swap` 和 `Less`。

下面是一个泛型类型 `SliceFn` 的示例，它为任意的 slice 类型实现了 `sort.Interface`::

   // SliceFn implements sort.Interface for a slice of T.
   type SliceFn[T any] struct {
       s    []T
       less func(T, T) bool
   }

   func (s SliceFn[T]) Len() int {
       return len(s.s)
   }
   func (s SliceFn[T]) Swap(i, j int) {
       s.s[i], s.s[j] = s.s[j], s.s[i]
   }
   func (s SliceFn[T] Less(i, j int) bool {
       return s.less(s.s[i], s.s[j])
   }

对于任何 slice 类型，`Len` 和 `Swap` 方法都是完全相同的。 `Less` 方法需要一个比较函数，也就是 `SliceFn` 的 `Fn` 部分（*F*\ u\ *n*\ ction 的缩写）。与前面的 `Tree` 示例一样，我们将在创建 `SliceFn` 时传入一个函数。

下面展示了 `SliceFn` 如何使用比较函数对 slice 进行排序::

   // SortFn sorts s in place using a comparison function.
   func SortFn[T any](s []T, less func(T, T) bool) {
       sort.Sort(SliceFn[T]{s, cmp})
   }

这类似于标准库里的 `sort.Slice`，但比较函数的参数是值本身而不是值在 slice 中的索引。

对这种代码使用 type parameter 是合适的，因为所有 slice 类型的方法看起来完全相同。

这里应该提一下，Go 1.19（而不是 1.18）的标准库很可能引入一个通用函数来使用比较函数对 slice 进行排序，并且该函数很可能不使用 `sort.Interface`。参见提案 `#47619`__。即使这个上面这个例子很可能不实用，但大体上的观点依然是正确的：*当你需要对所有相关类型实现看起来都相同的方法时，使用类型参数是合理的*。

.. note::

   这里插播一则新闻，Go 1.19 将会使用 pdqsort 作为默认的排序算法（包括 `sort.Interface` 和 `sort.Slice`），在所有的场景下相比原来的实现都快 2 到 60 倍（包括了算法本身和使用泛型带来的收益）这部分工作由我们组的同事 :ghuser:`zhangyunhao116` 在 `#50154`__ 提出并实现。

__ https://github.com/golang/go/issues/47619
__ https://github.com/golang/go/issues/50154

何时不使用 type parameter
=========================

现在让我们来讨论一下问题的另一面：什么时候不应该使用类型参数。

不要使用 interface 替代 type parameter
--------------------------------------

众所周知，Go 支持接口（interface）类型。interface 在一定程度上允许你在实现泛型编程。

例如，广泛使用的 `io.Reader` 接口提供了一种通用机制，用于从包含信息（例如文件）的对象或产生信息（例如随机数生成器）的对象中读取数据。如果你对某个类型的的所有操作就是对其值调用方法，请使用 interface，而不是 type parameter。直接使用 `io.Reader` 的代码更加易于阅读、高效且有效。这里没有必要使用 type parameter 通过调用 `Read` 方法从值中读取数据。

举个例子，这里将使用 interface 的第一个函数签名更改为使用 type parameter 的第二个版本，看起来也许很诱人::

   func ReadSome(r io.Reader) ([]byte, error)

   func ReadSome[T io.Reader](r T) ([]byte, error)

但请不要这么做，第一个省略类型参数的版本其实更易于编写、阅读，并且 *它们的执行时间可能相同*。

上面的最后一点值得强调：尽管泛型可以通过个好几种不同的方式实现，并且实现会随着时间的推移而改变和演进，但 Go 1.18 的实现在许多情况下会同等对待类型参数的值与接口类型的值。这意味着使用 type parameter 通常不会比使用 interface 快。所以不要仅仅为了速度而从 interface 更改为 type parameter，因为它可能不会运行得更快。

.. admonition:: 译者注

   就是说在这种情况下，可以认为 type parameter 只是 interface 的语法糖。

不要对不同的 method 实现使用 type parameter
-------------------------------------------

在决定是使用 type parameter 还是 interface 时，请考虑方法的实现是什么样的。前面我们说过，如果方法的实现对所有类型都相同，则使用 type parameter。反之，如果每种类型的实现都不一样，那就用 interface 写不同的方法实现。

例如，从文件中读取的实现和从随机数生成器读取的实现完全不同，这意味着我们应该编写两个不同的 `Read` 方法，并使用像 `io.Reader` 这样的接口类型。

在适当的地方使用反射
--------------------

Go 支持 运行时反射__。反射也能一定程度地实现泛型编程，因为它允许你编写适用于任何类型的代码。

如果某些操作支持的类型连方法都没有（因此没有办法定义 interface），并且针对每种类型的操作都不同（因此不适合使用 type parameter）的时候，请使用反射。

一个例子是 `encoding/json`__ 包。我们不想要求我们编码的每个类型都有一个 `MarshalJSON 方法`，所以我们不能使用接口类型。但是编码一个 interface 与编码一个 struct 的实现完全不同，所以我们不应该使用 type parameter。因此 encoding/json 使用了反射。使用反射实现的代码并不简单，但它确实能用。如果你想了解更多详情，请参阅其源代码。

__ https://pkg.go.dev/reflect
__ https://pkg.go.dev/encoding/json

一言以蔽之
==========

最后，关于何时使用泛型的讨论可以简化为一个简单的指导方针。

如果你发现自己多次编写完全相同的代码，而副本之间的唯一区别是代码使用了不同的类型，请考虑是否需要使用 type parameter。

换句话说，你应该避免使用 type parameter，直到你注意到你需要多次编写完全相同的代码。
