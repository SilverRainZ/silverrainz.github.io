====
泛型
====


Generics in General
===================

   一般范型有三种实现方案：

   :泛型实例化: Rust、C++采用这种方案。是一种静态派发，性能是最好的。存在的问题是实现难度很大，需要进行语法树的深拷贝和指针的重定向，很容易出现段错误。另外在跨包的时候相同的类型会出现相同代码生成的问题。这些问题都是可以解决的，只是需要时间。
   :字典:       Swift 采用这种方案。这种方案实现起来最大的好处就是不容易出错。但是性能会差一点，因为泛型变量必须分配到堆上，而且要生成很多字典数据，从产物上来说不一定比第一种少多少。
   :类型擦除:   Java 采用这种方案。将泛型出现的地方都用 Object 代替。这种最简单，但是不支持基础类型 `int`、`bool` 等。Java 对于这些类型如果想要调用方法需要进行装箱

   —— from :people:`ganbo.xiao`


Go's Implementation
===================

GC Shape Stenciling = Stenciling + Dictionaries

Stenciling
   - 在编译期，据使用的类型为泛型函数生成多份代码
   - 运行速度快，编译速度慢，产物臃肿

Dictionaries
   - 一个泛型函数只生成一份代码
   - 在运行时传递一个包含类型参数信息的字典
   - 编译速度快，运行速度慢，产物精简

GC Shape of Type
   - 类型的 GC 相关信息
   - 和类型的大小 (size) 、内存对齐 (alignment) 以及指针成员的位置相关

GC Shape Stenciling ⇒ 根据 GC Shape 生成模版
   - 在编译期，根据不同的 GC Shape 生成多份代码（即，具有相同 GC Shape 的类型共享一份代码）
   - 在编译期，为「相同 GC Shape 的不同类型」生成多个字典
   - 在运行期，通过传递不同的字典处理「GC Shape 相同的不同类型」的差异
   - 在编译速度和运行速度之间取得了平衡
