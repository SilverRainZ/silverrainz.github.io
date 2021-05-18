Learning Scheme
===============

教程
----

-  `Teach Yourself Scheme in Fixnum
   Days.zh-CN <http://songjinghe.github.io/TYS-zh-translation/>`__
-  `Yet Another Scheme
   Tutorial.zh-CN <http://deathking.github.io/yast-cn/index.html>`__
-  The Little Schemer

编译器
------

-  guile 的自动补全

.. code:: scheme

    ; pcaman -S readline
    ; ~/.guile
    (use-modules (ice-9 readline))
    (activate-readline)

-  chicken (csi) 的自动补全

.. code:: scheme

    ; chicken-install readline
    ; ~/.csirc
    (use readline)
    (current-input-port (make-readline-port))
    (install-history-file #f "/.csi.history")

正文
----

以下代码使用 chicken 运行。

quote
^^^^^

`quote` 用来阻止符号（symbol）被求值，\ `'` 是其缩略形式:

.. code:: scheme

    (+ 1 2)         => 3
    (quote (+ 1 2)) => (+ 1 2)
    '(+ 1 2)        => (+ 1 2)
    '()             => ()

特殊形式(?)
'''''''''''

普通的 symbol 会对所以参数求值并返回值，特殊形式的 symbol
不会对所有的参数求值： `qutoe`\ （这是当然的） `lambda` `define`
`if` `set!`

pair & list
^^^^^^^^^^^

`(cons 1 2)` 生成一个 pair `(1 . 2)`\ ，pair 的第一个元素被称为
car， 第二个元素被称为 cdr.

按照如下定义嵌套的 pair 被称为 list：

-  `'()` 是 list
-  `(cons element list)` 是 list，element 可以是任意类型

可以使用 `(null? list)` 来判断表是否空（\ `'()`\ ）

.. code:: scheme

    (cons 1 2)                      => (1 . 2)
    (cons 1 (cons 2 (cons 3 '())))  => (1 2 3)
    (cons 1 (cons 2 5))             => (1 2 . 5)
    (cons #\a (cons 3 "hello"))     => (#\a 3 . "hello")

car & cdr & list
''''''''''''''''

函数 `car` 和 `cdr` 分别取回一个 pair 的 car 部分和 cdr 部分，
`list` 用于构造一个表

.. code:: scheme

    ; pair
    (car '(1 . 2))                          => 1
    (cdr '(1 . 2))                          => 2
    ; list
    (cdr '(1 . (2 . ())))                   => (2)
    (cdr (cons 1 (cons 2 (cons 3 '()))))    => (2 3)
    (list 1 3 4)                            => (1 3 4)
    (list (cons 1 2) (cons 1 3))            => ((1 . 2) (1 . 3))

atom
''''

以下数据类型是 atom：

-  numbers
-  strings
-  symbols
-  booleans
-  characters

以下是 The Little Schemer 中对 atom 的定义：

.. code:: scheme

    ; All that not a pair or null is an atom.
    ; define in The Little Schemer
    (define atom?
      (lambda (x)
        (and (not (pair? x)) (not (null? x)))))

procedure
^^^^^^^^^

lambda
''''''

`lambda`\ ，接受两个参数，返回一个
procedure，参数一是参数表，参数二是函数体：

.. code:: scheme

    (lambda () (display "archlinuxcn"))     => #<procedure (?)>
    ((lambda () (display "archlinuxcn")))   => archlinuxcn
    ((lambda (x y) (+ x y)) 1 2)            => 3

define
''''''

`define`
声明并绑定一个全局变量，参数一为变量名，参数二为被绑定的对象，
借此可以复用 `lambda` 所生成的 procedure。

.. code:: scheme

    (define add (lambda (x y) (+ x y)))
    add         => #<procedure (add x y)>
    (add 1 3)   => 4
    (define str "arch")
    str         => "arch"

不使用 lambda
'''''''''''''

.. code:: scheme

    (define (add3 a b c) (+ a b c))
    add3            => #<procedure (add3 a b c)>
    (add3 1 2 3)    => 6

分支
^^^^

if
''

`(if predicate then_value else_value)` 当 `predicate` 为真则对
`then_value` 求值， 反之则对 `else_value` 求值，\ `else_value`
部分可以省略，求得的值会传出括号外。 对于 `predicate`\ ，任意值（包括
`#t`\ ）被认为 ture，\ `#f` 则是 false。

.. code:: scheme

    (define (abs x) (if (< x 0) (- x)  x))

not & and & or
''''''''''''''

-  `not` 接受一个参数，取反
-  `and` 接受任意个参数，从左到右求值，若出现 `#f` 则返回 `#f`\ ，
   若全不为 `#f` 则返回最后一个参数的值
-  `and` 接受任意个参数，从左到右求值，返回第一个不是 `#f` 的参数，
   若全是 `#f` 则返回最后一个参数的值

cond
''''

类似 case：

.. code:: scheme

    (cond
      (predicate_1 clauses_1)
      (predicate_2 clauses_2)
        ...
      (predicate_n clauses_n)
      (else        clauses_else))

遇到成立的 `predicate` 则执行对应的子句后返回，全部不成立则执行
`else` 的子句。

equ
'''

-  `=` 判断两个数字是否相等
-  `eq?`
   比较两个参数的地址，不要使用它来比较数字：其结果取决于编译器实现
-  `eqv?` 是 `eq` 的超集，对于原子类型（atom？）会进行正确的比较
-  `equal?` 比较 list 与 vector

ref:
http://stackoverflow.com/questions/16299246/what-is-the-difference-between-eq-eqv-equal-and-in-scheme

let
^^^

`(let bind body)` 为 `body` 语句绑定局部变量，变量在 `bind`
中初始化， `bind` 中的变量不可互相引用：

.. code:: scheme

    (let ((i 1)) (+ i 2))   => 3

`let` 是 `lambda` 的语法糖：

.. code:: scheme

    (let ((p v)) (+ p 1))       => 2
    ; equal to
    ((lambda (p) (+ p 1)) v)    => 2

let\*
'''''

使用 `let*` 可以引用定义在同个绑定中的变量（\ `let*` 事实上是嵌套的
`let` 的语法糖）：

.. code:: scheme

    (let* ((i 1) (j (- i))) (+ i j))    => 0

named let
'''''''''

可以为一个 `let` 命名来实现循环：

.. code:: scheme

    (define (fact-let n)
      (let loop((n1 n) (p n))
        (if (= n1 1) p
        (let ((m (- n1 1)))
            (loop (sub1 n1) (* p (sub1 n1)))))))

letrec
''''''

允许 `bind` 中的变量递归地调用自己：

.. code:: scheme

    (define (sum-letrec xs)
      (letrec ((sum1 (lambda (xs1)
                      (if (null? xs1) 0
                        (+ (car xs1) (sum (cdr xs1)))))))
        (sum1 xs)))

do
^^

`(do binds (predicate value) body)` 变量在 `bind` 中被绑定， 若
`predicate` 为真， 则函数跳出 `do` 语句，值 `value` 被传递出来，
否则循环继续。 `bind` 的形式是 `((p i j) ... )` 变量 `p`
被初始化为 `i`\ ， 在循环后被更新为 `j`

.. code:: scheme

    (define (fact-do n)
      (do ((n1 n (- n1 1)) (p n (* p (- n1 1)))) ((= n1 1) p)))

递归
^^^^

::

    (define (fact n)
      (if (= n 1) 1 (* n (fact (- n 1)))))

尾递归
''''''

.. code:: scheme

    (define (fact-tail n)
      (fact-rec n n))

    (define (fact-rec n p)
      (if (= n 1) p
        (fact-rec (sub1 n) (* p (sub1 n)))))
    ; 使用 named let 或者 letrec 的话可以不用两个函数

Higher Order Function
^^^^^^^^^^^^^^^^^^^^^

map
'''

`(map procedure list1 list2 ...)` `map` 把 `procedure`
应用到列表上， 返回新的列表，表的个数由 `procedure` 决定

.. code:: scheme

    (map sub1 '(1 2 3)) => (0 1 2)

for-each
''''''''

格式与 `map` 相同，不返回具体的值，用于副作用：

.. code:: scheme

    (define sum 0)
    (for-each (lambda (x) (set! sum (+ sum x))) '(1 2 3 4))
    => 10
    (map (lambda (x) (set! sum (+ sum x))) '(1 2 3 4))
    => (#<unspecified> #<unspecified> #<unspecified> #<unspecified>)

fold
''''

有左折叠（\ `foldl`\ ）和右折叠（\ `foldr`\ ）:

.. code:: scheme

    (foldl + 0 '(1 2 3))    => 6
    (foldr + 0 '(1 2 3))    => 6

apply
'''''

将一个表展开作为过程的参数，接受任意多的参数，
第一个和最后一个参数分别应该是一个过程和一个列表（还不知道有什么用）：

.. code:: scheme

    (apply + 1 2 '(3 4 5))

IO
~~

input
^^^^^

port
''''

`(open-input-file file-name)` 用于打开一个文件返回一个端口，
`(read-char port)` 从端口读取一个字符，读取到 EOF 的时候返回一个
`eof-object`\ ， 可用 `eof-object?` 检查，使用
`(close-input-port port)` 关闭端口

.. code:: scheme

    (define (kitten fname)
      (let ((fp (open-input-file fname)))
        (let loop ((chr (read-char fp)))
          (if (eof-object? chr)
            (close-input-port fp)
            (begin
              (display chr)
            (loop (read-char fp)))))))

`(call-with-input-file file-name procedure)` ： 函数将打开
`file-name` 得到的端口传递给 `procedure`\ ， `procedure`
结束后端口需要手动关闭

`(with-input-from-file file-name procedure)` ：
将文件作为标准输入打开，因此 `procedure` 不需要参数， `procedure`
结束后文件会自动被关闭

read
''''

`(read port)` 从端口中读入一个 S-Expression（!）：

.. code:: scheme

    (define (read-s fname)
      (with-input-from-file fname
        (lambda ()
          (begin
            (display (read))
            (newline)))))
    (read-s "1.scm")    => (define (myabs x) (if (< x 0) (- x) x))

output
^^^^^^

port
''''

`(open-output-file file-name)`
打开一个文件，返回一个用于输出到该文件的端口

`(open-output-file file-name)` 关闭输出端口

`(call-with-output-file file-name procedure)`

`(with-output-to-file file-name procedure)`

output func
'''''''''''

以下函数的 `port` 都是可选参数，省略则输出到 stdout

`(wirte obj port)` 将 `obj` 输出至 `port`\ ，

.. code:: scheme

    (write #\c)         => #\c
    (write "string")    => "string"

`(display obj port)` 将 `obj` 输出至 `port`\ ，

.. code:: scheme

    (display #\c)         => c
    (display "string")    => string

`(wirte-char char port)` 往 `port` 写入一个字符

赋值
^^^^

赋值具有破坏性（destructive）, Scheme 中具有破坏性的方法都以 `!` 结尾

`(set! var val)` 为一个参数赋值，赋值前参数应该被定义

词法闭包（lexical closure）
'''''''''''''''''''''''''''

    **WikiPedia:** 闭包又称词法闭包，是引用了自由变量的函数。
    这个被引用的自由变量将和这个函数一同存在，即使已经离开了创造它的环境也不例外。
    所以，有另一种说法认为闭包是由函数和与其相关的引用环境组合而成的实体。
    闭包在运行时可以有多个实例，不同的引用环境和相同的函数组合可以产生不同的实例。

副作用
''''''

赋值 `set!` 和 IO 操作都是副作用，

表的赋值
''''''''

`set-car!` `set-cdr!` 分别用于为表的 car 和 cdr 部分赋值，
参数可以是 S-Expression

用 list 实现一个队列
''''''''''''''''''''

list 的 car 部分储存了整个队列，cdr 部分储存了指向队列尾部的引用。

.. figure:: /_images/queue.png
   :alt: structure of queue

   structure of queue

`图片出处 <http://www.shido.info/lisp/scheme_asg_e.html>`__

.. code:: scheme

    (define (make-queue)
      (cons '() '()))

    (define (enqueue! queue obj)
      (let ((lobj (cons obj '())))
        (if (null? (car queue))
        (begin
            ; lobj :: (1 . ()) :: (1)
            ; queue :: (() . ()) :: (())
          (set-car! queue lobj)
            ; queue :: ((1 . ()) . ()) :: ((1))
          (set-cdr! queue lobj))
            ; queue ::  ((1 . ()) . (1 . ())) :: ((1) 1)
            ; 此时队列的 car 和 cdr 部分都 *引用* 同一个对象 lobj
        (begin
            ; lobj :: (2 . ()) :: (2)
            ; queue ::  ((1 . ()) . (1 . ())) :: ((1) 1)
          (set-cdr! (cdr queue) lobj)
            ; queue ::  ((1 . (2 . ())) . (1 . (2 .()))) :: ((1 2) 1 2)
            ; 借助 cdr 的引用将 lobj 入队
          (set-cdr! queue lobj)))
            ; queue ::  ((1 . (2 . ())) . (2 .())) :: ((1 2) 2)
            ; 把 cdr 更新为当前的队尾 lobj
        (car queue)))

    (define (dequeue! queue)
      (let ((obj (car (car queue))))
        (set-car! queue (cdr (car queue)))
        obj))

    (define q (make-queue))
    (enqueue! q 'a)     => (a)
    (enqueue! q 'b)     => (a b)
    (enqueue! q 'c)     => (a b c)
    (dequeue! q)        => a
    q                   => ((b c) c)


.. note:: 此处有小坑，（尚未找到对此的规范描述，仅为自行总结）
          不清楚 pair 中储存的到底是值还是引用，还是两者都有， 反正当 pair
          中储存了 pair 时，用的是引用， 注意 `set!`
          更改的是这个变量名的指向， `set-cdr!` 更改的是指向的对象内部的值
          :(

.. code:: scheme

    ; 普通类型
    (define a 1)
    (define b (cons 1 a))
    a   => 1
    b   => (1 . 1)
    (set! a 2)
    a   => 2
    b   => (1 . 1)

    ; pair
    (define a (cons 2  3))
    (define b (cons 1 a))
    a   => (2 . 3)
    b   => (1 2 . 3)
    (set-cdr! a 4)
    a   => (2 . 4)
    b   => (1 2 . 4)
    (set! a (cons 4 5))
    b   => (1 2 . 4)

Symbol
------

`(symbol? x)` 判断 `x` 是否为一个符号，\ `(string->symbol str)` 将
`str` 转换为符号，\ `(symbol->string sym)` 将 `sym` 转化为字符串
