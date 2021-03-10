Rust Book
=========

C 程序员的《Rust Book》笔记。

语法
----

Vector
******

* 使用宏 ``vec![]`` 创建 Vector
* Vector 使用 ``usize`` 索引
* Vector 单元大小需要在编译时确定
* 可用三种方式遍历 Vector::

    for i in &v {}
    for i in &mut v {}
    for i in v {}



所有权系统
**********

所有权
......


借用
....

即用 ``&`` 和 ``&mut`` 对变量进行引用和可变引用。

* 任何借用必须位于比拥有者更小的作用域
* 在同个作用域下，对于同个资源，只能同时拥有一个可变引用或者多个不可变引用

生命周期
........

具名的作用域

``'static``

Lifetime Elison

字符串
******

``&str``
    字符串切片（String slices），字符串常量的类型是 ``&'static str``

``String``
    堆分配的字符串

* ``"xxx".to_string()``: ``&str`` => ``String``  需要在堆上分配，代价较大
* ``&"xxx".to_string()``: ``String`` => ``&str``

> 为什么对于 ``println!`` ， ``&String`` 和 ``&*String`` 结果一样？
> ``&String`` 会因为 deref coercions 成为 ``&str``
> 而对 String 解引用会得到  ``str`` ，于是 ``&*String`` = ``&str``
> 两者的结果都是 ``&str``

拼接： ``String + &str`` 或 ``String + &String``

泛型
****

在 struct 中储存泛型::

    struct Point<T> {
        x: T,
        y: T,
    }

为该 struct 增加实现::

    impl<T> Point<T> {
        fn swap(&mut self) {
            std::mem::swap(&mut self.x, &mut self.y);
        }
    }

Traits
******

类似于接口。

用 trait 限定泛型函数::

    use std::fmt::Debug

    trait HasArea {
        fn area(&self) -> f64;
    }

    fn print_area<T: HasArea>(shape: T) {
        ...
    }

    // 限定多个 trait
    fn print_area2<T: HasArea + Debug>(shape: T) {
        ...
    }

    // 使用 where
    fn print_area3<T>(shape: T) where T: HasArea {
        ...
    }

* 如果 trait 的定义没有处于当前作用域，这个 trait 是不可用的。
* 带有 trait 限制的泛型函数是单态（monomorphization）的(?)
* trait 可以继承，在子 trait 实现之前必须先实现父 trait
* ``#[derive(Debug)]`` 允许你自动实现一些特定的 trait
