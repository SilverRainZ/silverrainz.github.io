=============================
The Rust Programming Language
=============================

.. book:: _
   Rust 程序设计语言
   :isbn: 9781718500440
   :startat: 2021-03-11

.. highlight:: rust

.. contents::
   :local:

ch1
===

使用 community/rustup 包而不是 community/rust 包，方便获取比官方源还新的 rust。
community/rustup 没有自带 toolchain，和书中的描述不符。 但不重要，使用
``rustup toolchain install nightly`` 即可。

使用 ``cargo update`` 来更新 lock 文件，但默认只会 bump semver 的 fix 部分，
即 ``1.1.1 -> 1.1.2`` 而不是 ``1.1.1 -> 1.2.0`` 。若确定要更新，需要手动更改
``Cargo.toml`` 并重新 ``cargo build`` 。

ch2
===

需要 ``use namespace::of::trait`` 才能使用某个实现了 trait 的 struct 对应的方法。
需要 use的 trait 可以通过 ``cargo doc --open`` 生成的本地依赖的文档查看。

模式匹配真香！！！

Rust 允许重新声明变量，不会出现命名难题。这也很香。

ch3
===

变量默认不可变
    :del:`那为啥要叫变量` ， 好处是安全 & 并发友好，有利于优等等等等。

``isize`` 和 ``usize`` 类似 ``size_t`` in C

只有 ``cargo build --debug`` 才会检测整数溢出并 panic。

Rust 的 ``char`` 有 4 byte 长，足够容纳 unicode。

Tuple 可以用模式匹配或者 ``x.1`` 这样的下标索引。

函数返回值是最后一个表达式的值 -> 那就没法随时 return 了？
有 return 关键字，这设计有点奇怪。

ch4
===

所有权规则：
    1. 每一个值都有一个所被其称为所有者（owner）的变量
    2. 值在任一时刻有且只有一个所有者
    3. 当所有者（变量）离开作用域，这个值将被丢弃

移动语义
    - 借用（borrowing）而不是浅拷贝（shadow copy）
    - 永远不会自动 "deep copy"

    提供了 ``Copy`` trait 为简单类型提供支持。

Reference
    使用 reference ``&`` 来借用数据到一个更小的作用域。
    同一份数据的 mutable reference 只能有一个。
    reference 的作用域是「从声明开始到最后一次使用」。

ch5
===

Struct init::

    let email: String = String::new("i@example.com")
    let user = User {
        email,
    }

Struct update::

    let user2 = User {
        ..user1
    }

Tuple struct::

    struct Color(i32, i32, i32)

使用 ``#[derive(Debug)]`` 自动实现 ``Debug`` trait，便于被 ``println!("{:?}")``
答应出来。

Struct method::

    struct foo;
    impl foo {
        fn bar(&self) -> u32 {
            1
        }
    }

.. note:: 注意 self 的借用方式

Automatic referencing and dereferencing
    消除了 C/C++ 中 ``foo.bar`` 和 ``foo->bar`` 的区别

Associated function
    类似 class function，使用 ``::`` 操作符

ch6
===

Variant 翻译为「成员」似乎不妥？

为枚举成员（ :del:`等等，我不是说不妥吗？` ）附加类型，表达能力很强::

    enum IpAddr {
        V4(u8, u8, u8, u8),
        V6(String),
    }

``Option<T>``
    避免了空值的泛滥

    .. note:: 然而空值是广泛存在于现实的，因为「太好实现了」

``if let`` 语法怪怪的::

    if let Some(3) = some_u8_value {
        println!("three")
    }

ch7 模块系统
============

Rust module system:
    - Packages
    - Crates
    - Modules：``mod`` 和 ``use`` 关键字
    - Path?

- 各种符号默认私有
- 结构体成员默认私有，所以构造函数必须与结构体关联（associate）
- 枚举成员默认公有

- ``use`` 和 ``use ... as`` 之于 ``import`` 、 ``import ... as``
- ``pub use`` 允许外部调用 use 的 module
- 支持 ``use mod::{foo,bar}``
- 支持 ``use mod::*``

``mod`` 关键字
    有点奇妙，引发了我对模块系统的疑惑…

    Q:

    1. ``mod foo;`` 加载 foo 模块的内容
    2. ``mod foo {};`` 实现 foo 模块的内容

    There’s no implicit mapping between file system tree to module tree, so:

        We need to explicitly build the module tree in Rust, there’s no
        implicit mapping to file system. [#]_

    A:

    1. A module without a body is loaded from an external file. [#f1]_
    2. When the module does not have a path attribute, the path to
       the file mirrors the logical module path. [#f1]_

.. [#] http://www.sheshbabu.com/posts/rust-module-system/
.. [#f1] https://doc.rust-lang.org/reference/items/modules.html

ch8 数据结构
============

:page: 133
