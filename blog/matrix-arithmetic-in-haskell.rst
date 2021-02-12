

========================================
 用 Haskell 实现的矩阵运算
========================================

.. post:: 2015-03-17
   :tags: Haskell
   :author: LA
   :language: zh

这学期开线性代数, 虽然我一向不喜欢数学, 本着将Haskell运用到实践中的精神,
想把上课教的几个矩阵运算写出来...虽然调试了半天, 回头一看,
好吧原来这么久简单的东西花了我那么多时间.

虽然到现在的我都没把趣学指南看完因为课有点多\ :s:`事实上是太懒了`\ , 只看到了State Monad这里吧,
还不是太懂, 一旦碰到「作为Monad值的函数」,「作为Applicate值的函数」这种东西我就抓瞎了.

说回矩阵吧, 用Haskell写这个还是挺爽的, 相较于C来说:


* 不用和各种数组下标打交道
* 经常编译不过, 但一旦通过编译, 往往就得到正确的结果了
* 函数出乎意料地短, 数乘和矩阵加减本来都是用递归实现的, 写完后发现原来分别可以用map和zipWith来替代,
  一下子长度就缩短了一半不止

各种类型错误让我想起了以前写Delphi的时候...

实现矩阵转置的时候卡了一下, 我原来写的是

.. code-block:: haskell

   transpose :: Matrix -> Matrix
   transpose (Matrix []) = Matrix []
   transpose (Matrix ys) = map head ys : transpose (Matrix $ map tail ys)

一直爆empty list exception, 因为pattern matching 不到 ys, 最后一步是\ ``[[],[]...]``
而不是\ ``[]``\ , 上网查了一下矩阵转置函数才知道可以用\ ``[]:_``\ 来匹配.

对于矩阵乘法, 我采取的是将右边那个矩阵转置, 这样就可以简化成行乘行, 左边矩阵拆成单行乘过去.

在用\ ``$``\ 的时候总是遇到问题...总是报错, 也不知道为什么...我把简单地$当成让函数右结合的操作符,
但是如果写: ``getMartix $ Matrix xs `mmul` ys`` 就错误.
看来理解还是有偏差的.

下面的代码分别实现了:


* 矩阵加法 plus
* 矩阵减法 sub
* 矩阵数乘 smul
* 矩阵乘积 mmul
* 矩阵的Eq实例和show实例

到底乘法用的是 multiplication 还是 product 呢... 好奇怪.

因为定义矩阵直接用了 ``[[Int]]``\ , 无法限制每个list的长度,
所以并不能保证这个Matrix里面肯定是一个符合定义的矩阵, 这个不知道怎么加以限制.

看看接下来教的什么或许可以再往代码里加点东西, 改天看看别人是怎么写的.

.. code-block:: haskell

   data Matrix = Matrix {getMartix :: [[Int]]}

   smul :: Int -> Matrix -> Matrix
   i `smul` Matrix xs = Matrix $ map (map (*i)) xs

   plus ::  Matrix -> Matrix -> Matrix
   Matrix xs `plus` Matrix ys = Matrix $ zipWith (zipWith (+)) xs ys

   sub :: Matrix -> Matrix -> Matrix
   Matrix xs `sub` Matrix ys = Matrix $ zipWith (zipWith (-)) xs ys

   transpose :: Matrix -> Matrix
   transpose (Matrix ([]:_)) = Matrix []
   transpose (Matrix xs) =
       Matrix $ map head xs : getMartix (transpose $ Matrix $ map tail xs)

   mmul :: Matrix -> Matrix -> Matrix
   Matrix [] `mmul` _ = Matrix []
   Matrix (x:xs) `mmul` ys =
       Matrix $ (mul_ x $ getMartix (transpose ys)) : getMartix (Matrix xs `mmul` ys)

   mul_ :: [Int] -> [[Int]] -> [Int]
   mul_ _ [] = []
   mul_ x (y:ys) = sum (zipWith (*) x y) : mul_ x ys

   instance Eq Matrix where
       Matrix [] == Matrix [] = True
       Matrix (x:xs) == Matrix (y:ys) =
           length x == length y && and (zipWith (==) x y) && Matrix xs == Matrix ys

   instance Show Matrix where
       show (Matrix []) = ""
       show (Matrix (x:xs)) = show x ++ "\n" ++ show (Matrix xs)
