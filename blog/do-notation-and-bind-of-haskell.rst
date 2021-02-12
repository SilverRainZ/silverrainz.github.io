

========================================
 do 记法和 >>= 的等效表达
========================================

.. post:: 2015-04-09
   :tags: Haskell
   :author: LA
   :language: zh


明明在开学的时候，:book:`Haskell 趣学指南` 就只剩下三十来页了，但是还书日在即，
我就到图书馆问阿姨能不能还了马上再借，这样做的结果是，书还在我手里，
可是至今没看完。

当然这和后面的内容有点难有关系（岂止是有点难？！），本来脑子就不够用，
看到State Monad那一段就懵了。

今晚看了挺久的，勉强算有点思路，当然对它的理解应该还是在一个比较low的水平上。
就算是看了大半本书， 知乎上对Haskell的讨论还是又非常多看不懂。

State Monad是一种函数，当然也是一种Monad，是一种带状态的计算，等待着一个状态，
如果得到状态后会产生一个值和新的状态。

书里用栈作为例子，实现了push和pop，但是只提供了do记法的示例，自己尝试用\ ``>>=``\ 改写并没有成功。

State Monad对于bind(>>=)的一种解释是这样子的：
来自：\ `https://wiki.haskell.org/State_Monad <https://wiki.haskell.org/State_Monad>`_

.. code-block:: haskell

   `>>=` :: State s a -> (a -> State s b) -> State s b
   (act1 >>= fact2) s = runState act2 is
                   where (iv,is) = runState act1 s
                         act2 = fact2 iv

可以看到\ ``>>=``\ 接受一个State，和一个生成State的函数，最后生成一个State，
注意最后生成的这个State是一个函数，还需要一个状态。

act1是一个带状态计算，接受状态s后（不能直接接受，必须用runState「脱壳」）生成一个tuple，
左边是值，右边是新的状态。从fact2的类型签名可以知道，act2是fact2应用值iv后得到的 **带状态计算** 。
那么它还需要一个状态，这个\ ``>>=``\ 函数的最终值就是act2脱壳后应用新状态的值。

注意上面这段代码是表示了当带有\ ``>>=``\ 的运算遇到一个状态时所做的操作，似乎少了一个runState?

那么对于：

.. code-block:: haskell

   type Stack = [Int]

   pop :: State Stack Int
   pop = state $ \(x:xs) -> (x, xs)

   push :: Int -> State Stack ()
   push a = state $ \xs -> ((), a:xs)

   test :: State Stack Int
   test = do
       push 3
       push 4
       push 5
       pop

结果应该是::

   ghci> runState test []
   (5,[4,3])


怎么用\ ``>>=``\ 改写上面的do notation呢？

do实际上是嵌套的>>=的一个语法糖，\ ``x <- foo`` 就是一个绑定， 而且一旦绑定，
在之后的语句里也可以使用x了，所以相当于\ ``foo >>= (\x -> 后面的语句)``\ 。
下面的两段程序是等价的，第二段程序为了最后能用\ ``return （x*y）``\ ，
就得两个lambda嵌套起来。

.. code-block:: haskell

   i = do
       x <- f 3
       y <- f 4
       return (x * y)

   j = f 3 >>= (\x ->
       f 4 >>= (\y ->
       return (x * y)))

但是do里面也可以不用绑定，不用绑定的话，\ ``>>=``\ 也可以不必嵌套，而且和上面的不同，
这里有push和pop两个函数，pop相当于act1，push则是fact2，他们的行为不同，
``>>=`` 的前面必须是一个act1类型，后面必须是fact2类型，
如果用\ ``>>=``\ 串起来应该是 ``pop >>= push >>= push >>= push``\ ，
但是要push三个值，push并不需要从\ ``>>=``\ 接收值，
可以用lambda来更改(因为没有利用到前面的值，所以这里嵌套与否都没问题)：

.. code-block:: haskell

   test' :: State Stack Int
   test' = push 3 >>= (\_ -> push 4) >>= (\_ -> push 5) >>= (\_ -> pop)

.. code-block:: text

   ghci> runState test' []
   (5,[4,3])


最后，书里的\ ``>>=`` 实现是这样子的：

.. code-block:: haskell

   (State h) >>= f = State $ \s -> let (a, newState) = h s
                                       (State g) = f a
                                   in  g newState

现在看来就好懂多了。对于State Monad，\ ``>>=``\ 的意义是，等待一个初始状态，
取一个带状态计算，讲初始状态应用到带状态计算上，得到一个值和新状态，
值和\ ``>>=``\ 右边的函数应用得到新的带状态计算，这个带状态计算又和新状态作用，
得到最终值和最终状态。当然这里的值和状态都可以继续传递下去，形成一条链。

（我觉得State Monad有个反人类的地方就是，本来按顺序沿着\ ``>>=``\ 处理状态，
偏偏初始状态是放在最右的)
