=============================
The Rust Programming Language
=============================

.. book:: _
   Rust 程序设计语言
   :isbn: 9781718500440
   :startat: 2021-03-11

.. highlight:: rust

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

ch4
===

所有权规则：

1. 每一个值都有一个所被其称为所有者（owner）的变量
2. 值在任一时刻有且只有一个所有者
3. 当所有者（变量）离开作用域，这个值将被丢弃

Bookmark: P63
