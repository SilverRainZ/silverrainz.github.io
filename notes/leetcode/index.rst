=================
Leetcode 刷题记录
=================

:date: 2021-03-10

.. tip::

   用 :file:`./new-problem.sh` 来开始一道新题目：

   .. dropdown:: new-problem.sh

      .. literalinclude:: ./new-problem.sh
         :language: bash

.. contents:: 题解
   :local:

Two Sum
-------

.. leetcode:: _
   :id: two-sum
   :diffculty: Easy
   :language: rust

我居然以为是 a+b 真是太蠢了。

花了一些时间来回忆 rust 的语法，工作后技术直觉好了很多，之前觉得不容易理解的地方
（指 rust）现在觉得非常直观了。


Valid Parentheses
-----------------

.. leetcode:: _
   :id: valid-parentheses
   :diffculty: Easy
   :language: rust
   :date: 2021-05-04

熟悉语法……

LRU Cache
---------

.. leetcode:: _
   :id: lru-cache
   :diffculty: Medium
   :language: go
   :date: 2021-05-08

想用 rust 写个 LRU cache 吧发现 `std::collection:LinkedList` 没有暴露出类似
链表节点的结构体……有的话所有权也是问题，`Cursor` 看起来像然而 nightly only，
好像还是太菜了 —— 是说我自己。

但如果换成 go 的话…… :del:`这么简单的题也算 medium 吗` ，可能因为太实用了所以写起来不难？

LFU Cache
---------

.. leetcode:: _
   :id: lfu-cache
   :diffculty: Medium
   :language: go
   :date: 2021-05-08 2021-7-22
   :reference: https://github.com/halfrost/Halfrost-Field/blob/master/contents/Go/LRU:LFU_interview.md

解法 1
   在 touch 一个元素的的时候从链表尾部往上找，是一个 :math:`O(n)` 的操作，然而
   Leetcode 给过了…… 要是在 `SCAU OJ`_ 是肯定要 TLE。

   .. note:: 看一眼输入输出限制，想想边界值，比如 `cap == 0` 的情况就忽略了

解法 2
   更好的做法是按 freq 分成多个桶，每次 touch 一个元素就把它挪到对应的
   frequency 的桶里，并且 cache 内维护一个 minFreq 方便立刻找到最应该该淘汰的桶，
   桶内部是一个小的 LRU，这样 touch 就是 :math:`O(n)` 了。

想过另一个做法是维护一个 freq 为结点值的最小堆，但本质上和方法一没区别，只是把 :math:`O(n)`
的查找变成 :math:`O(\log n)` 而已，大量重复的 freq 值是很浪费时间和空间的。

.. _SCAU OJ: http://acm.scau.edu.cn:8000

Add Two Numbers
---------------

.. leetcode:: _
   :id: add-two-numbers
   :diffculty: Medium
   :language: go
   :date: 2021-05-13

凡是链表的题目都不能用 rust :'(

Partition Equal Subset Sum
--------------------------

.. leetcode:: _
   :id: partition-equal-subset-sum
   :diffculty: Medium
   :language: rust
   :key: 动态规划
   :date: 2021-06-21

把一个集合分成两个，使其 sum 分别相等，可以转化为：

.. |Sa| replace:: S\ :sub:`a`

假设原集合 sum 为 |Sa| ，从集合中选出一个子集，使其 sum 刚好的为 |Sa|/2 ——  这是一个 01 背包问题，背包容量为 |Sa|/2，要求恰好装满，填充物的 cost 是数字的值，value 统一设置为 1，因为只需要证有解。

Merge Two Sorted Lists
----------------------

.. leetcode:: _
   :id: merge-two-sorted-lists
   :diffculty: Easy
   :language: go
   :date: 2021-07-05
   :key: 链表

纯逻辑题。

Maximum Subarray
----------------

.. leetcode:: _
   :id: maximum-subarray
   :diffculty: Easy
   :language: go
   :key: 动态规划 分治法
   :date: 2021-07-05 2021-07-06

题目本身比较简单，一维 DP 或者贪心 :math:`O(n)` 可做。

.. |Ml| replace:: M\ :sub:`left`
.. |Mr| replace:: M\ :sub:`right`
.. |Mm| replace:: M\ :sub:`middle`

题干提示可用分治法做，"which is more subtle"，是一个吃力不讨好的解法。但很有代表性：

设数组最大子序列为 M ，M = max(|Ml|, |Mr|, |Mm|)，分别为左半边数组的最大子序列，右半边数组的最大子序列，或者是从中间算起，横跨左右的最大子序列。

- 当问题规模缩减至 1 的时候， |Ml|, |Mr|, |Mm| 显然为数组里唯一的元素
- |Mm| 的值不可由子问题推导出来，只能在数组 l 和 r 分别逆序和顺序遍历，求各自的从边缘开始的最大子序列，是一个 :math:`O(n)` 的操作 -- 这就决定了这个解法比 DP 慢，在每一轮子问题的解决都要遍历一次
- 二分法，所以问题要 :math:`O(\log_{2}n)` 个规模的子问题

复杂度为 :math:`O(n\log n)` 。

.. seealso:: `算法复杂度中的O(logN)底数是多少`_

   .. _算法复杂度中的O(logN)底数是多少: https://www.cnblogs.com/lulin1/p/9516132.html

Climbing Stairs
---------------

.. leetcode:: _
   :id: climbing-stairs
   :diffculty: Easy
   :language: go
   :key: 搜索 动态规划
   :date: 2021-07-06
   :reference: https://blog.csdn.net/zgpeace/article/details/88382121

记忆化搜索
   写一个暴力版本，时间复杂度 :math:`O(2^n)`。记忆冗余结果后复杂度应为 :math:`O(n)`(?)。空间复杂度 :math:`O(n)`

递推
   有一点动态规划的味道，但逻辑上非常简单，时间空间复杂度都是 :math:`O(n)`

斐波那契数列
   空间上当然可以到 :math:`O(1)` ，不写了

Binary Tree Inorder Traversal
-----------------------------

.. leetcode:: _
   :id: binary-tree-inorder-traversal
   :diffculty: Easy
   :language: go
   :key: 二叉树
   :date: 2021-07-06

纯数据结构题，没啥好说。

Symmetric Tree
--------------

.. leetcode:: _
   :id: symmetric-tree
   :diffculty: Easy
   :language: go
   :key: 二叉树
   :date: 2021-07-06
   :reference: https://leetcode-cn.com/problems/binary-tree-inorder-traversal/solution/er-cha-shu-de-zhong-xu-bian-li-by-leetcode-solutio/

递归解法
   按递归做的话是带点变化的数据结构题，左右子树互为镜像，任意对称的节点的左子树等于右子树。 

非递归解法
   引入栈，按 `左->中->右` 和 `右->中->左` 应得到完全相同的序列。

   .. tip:: 前序遍历写起来应当简单一点

Maximum Depth Of Binary Tree
----------------------------

.. leetcode:: _
   :id: maximum-depth-of-binary-tree
   :diffculty: Easy
   :language: go
   :key: 二叉树
   :date: 2021-07-07

数据结构题。

Best Time to Buy and Sell Stock
-------------------------------

.. leetcode:: _
   :id: best-time-to-buy-and-sell-stock
   :diffculty: Easy
   :language: rust
   :key: 动态规划
   :date: 2021-07-07
   :reference: https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock/solution/bao-li-mei-ju-dong-tai-gui-hua-chai-fen-si-xiang-b/

写了三个版本：

暴力
   TLE，每次 `i+1..prices.len()` 的回溯有大量荣誉计算，复杂度为 :math:`O(n!)`

DP1
   其实不太算 DP，参考里给出了非常 DP 的解法。 
   `profit[i]` 第 i 天卖出股票的最大正收益（亏本不卖）。以为状态转移方程是 `profit[i] = profit[j] + (prices[i] - prices[j])`, where `j < i && prices[j] <= prices[i]` 。复杂度依然为 :math:`O(n!)` ，只是有几率避免冗余计算，勉强 AC 但时间上只超过了 8% 的选手，有问题。

   .. note:: 实际上 `profit[i]` 可以只从 `profit[i-1]` 推断，见下

DP2
   更好的状态转移方程是 `profit[i] = max(profit[i-1] + (prices[i] - prices[i-1]), 0)` 。复杂度为 :math:`O(n)` ，超过了 85%+ 的选手，够了。

   从题意上看，方程的意思是：在第 i-1 天我们已经取得了能取得的最大收益，那第 i 天也应该参考第 i-1 天的购入时机，如果亏本了，则不购入。

Invert Binary Tree
------------------

.. leetcode:: _
   :id: invert-binary-tree
   :diffculty: Easy
   :language: go
   :key: 二叉树
   :date: 2021-07-07

我能去 Google 了吗？[#]_

Best Time to Buy and Sell Stock II
----------------------------------

.. leetcode:: _
   :id: best-time-to-buy-and-sell-stock-ii
   :diffculty: Easy
   :language: rust
   :key: 动态规划
   :date: 2021-07-07

:leetcode:`Best Time to Buy and Sell Stock` 的一个简单变体，允许多次买卖，没啥好说。

Best Time to Buy and Sell Stock III
-----------------------------------

.. leetcode:: _
   :id: best-time-to-buy-and-sell-stock-iii
   :diffculty: Hard
   :language: rust
   :key: 动态规划
   :date: 2021-07-07 2021-07-28
   :reference: https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-iii/solution/mai-mai-gu-piao-de-zui-jia-shi-ji-iii-by-wrnt/

:leetcode:`Best Time to Buy and Sell Stock` 的一个更难的变体，允许至多两次不重叠的买卖。

解法一
   按 :leetcode:`Best Time to Buy and Sell Stock` 的解法，进行一次买卖，在此基础得到一个第 i 天收入的数组 `max_profit1` ，*该收入不一定是当日卖出所得*

   第二次买卖，需在第一次买卖后一天（当天卖，当天买没有意义，收益和一次买卖没差）::

      profit2[i] = max(max_profit1[i-2], profit2[i-1]) + (prices[i] - prices[i-1])

   `profit2` 数组为第一次买卖 *后* ，第 i 天的收入的数组，若收入为负，则放弃该交易，收入为 0。

   可以看到 `profit2[i]` 肯定会赚 i-1 天的差价 `prices[i] - prices[i-1]`，但可以选择加上 i-2 天时第一次买卖的最大收入 `max_profit1[i-2]` 或者沿用 i-1 t天做第二次买卖的最优策略。

   最终 `profit2` 数组中的最大值为答案。

   复杂度为 :math:`2*O(n)` ，这个常数可以优化掉，测评里只比 6.67% 的选手快，:math:`O(n)` 已经是这个问题的极限了，暂时不知道哪里有问题。

解法2
   看的题解。

   对每个状态（两次购买，两次出售）各构造一个互相依赖的状态转移方程。

Single Number
-------------

.. leetcode:: _
   :id: single-number
   :diffculty: Easy
   :language: rust
   :key: 位操作
   :date: 2021-07-07
   :reference: https://www.cnblogs.com/grandyang/p/4130577.html

遥想 :friend:`pcf` 师傅还跟我讨论过这题，可惜没记住。反正不看题解打死也做不出来。

Diameter Of Binary Tree
-----------------------

.. leetcode:: _
   :id: diameter-of-binary-tree
   :diffculty: Easy
   :language: go
   :key: 二叉树
   :date: 2021-07-08
   :reference: https://www.cnblogs.com/wangxiaoyong/p/10449634.html

这题本不难，答案是所有节点中「左子树深度 + 右子树深度」最大的值。

解法1
   没能 AC，留下是为了提醒自己。

   实现稍复杂，思路上是实现一个对每个节点返回左右臂展（其实就是深度）的函数：需要考虑 `root.Left != nil` 和 `root.Right != nil` 的情况，总之是对的，但因为思路的不明确，实现了一个 `func maxInts(s ...int)` 的函数，在递归前存了 `res` 在数组里，在递归后拿它来做运算…… 非常典型的错误

解法2
   仅修正了比较前的 `res` 被覆盖的问题，AC ，但 `maxInts` 很慢。

解法3
   标准解法，参考里的题解有个莫名其妙的 `+1` 再 `-1` ，没有用。

Merge Two Binary Trees
----------------------

.. leetcode:: _
   :id: merge-two-binary-trees
   :diffculty: Easy
   :language: go
   :key: 二叉树
   :date: 2021-07-09

数据结构题。

Maximum Product Subarray
------------------------

.. leetcode:: _
   :id: maximum-product-subarray
   :diffculty: Medium
   :language: rust
   :key: 动态规划
   :date: 2021-07-09
   :reference: https://leetcode-cn.com/problems/maximum-product-subarray/solution/cheng-ji-zui-da-zi-shu-zu-by-leetcode-solution/

:leetcode:`Maximum Subarray` 的变体，求乘积最大的子序列。偷偷看了一眼题解：得到了「开两个 dp 数组」的提示。

`N` 为给定数组，用 `P[i]` 表示以 i 结尾的子序列的最大乘积，假设数组只有非负数，那么 `P[i]` 的值只和 `N[i]` 和 `P[i-1]` 相关： `P[i] = P[i-1] * N[i]` 。

但数组可能出现负数：

- 用 `P[i]` 表示以 i 结尾的子序列的最大正乘积
- 用 `Pn[i]` 表示以 i 结尾的子序列的最小负乘积

根据 `N[i]` 的正负不同：`Pn` 的值可能转化为 `P`，`P` 的值可能也转化为 `Pn`:

- `P[i] = max(N[0], P[i-1]*N[0], Pn[i-1]*N[0])`
- `Pn[i] = min(N[0], P[i-1]*N[0], Pn[i-1]*N[0])`


Shortest Subarray To Be Removed To Make Array Sorted
----------------------------------------------------

.. leetcode:: _
   :id: shortest-subarray-to-be-removed-to-make-array-sorted
   :diffculty: Medium
   :language: rust
   :date: 2021-07-09

略难，写了很复杂的代码依然 WA，感受是：当你需要判断非常复杂的情况时，思路大概率部队。

移除 *一个* 最短的子序列使整个数组有序，那该数组必形如：`[ 有序..., 无序..., 有序...]`，当然两个有序的部分可能是空数组。数组为 `N`，易从左到右分别求出有序的部分 `[0,l]` 和 `[r, len(N)-1]`，那 `[l+1, r-1]` 是否就为最小的无序子序列呢？

非也，`[0,l]` 和 `[r, len(N)-1]` 分别有序，但整体不一定有序，而且可能重叠，如 `[1, 2, 100]` 和 `[0, 2, 5]`，从 `ll in l->0` 和 `rr in len(N)-1 -> r` 两个方向找恰好 `N[ll] < N[rr]` 即为答案，递归可做。

.. note:: 注意整个数组有序的边界条件。

House Robber
------------

.. leetcode:: _
   :id: house-robber
   :diffculty: Medium
   :language: rust
   :key: 动态规划
   :date: 2021-07-09

抢劫第 i 间房子能获得财产 `M[i]`，最大收入 `R[i]`。递推方程：`R[i] = max(R[i-2], R[i-2]) + M[i]`，答案为最大的 `R[i]`。

手动初始化前三个 R 有点累。

Longest Increasing Subsequence
------------------------------

.. leetcode:: _
   :id: longest-increasing-subsequence
   :diffculty: Medium
   :language: rust
   :key: 动态规划 二分法
   :date: 2021-07-12
   :reference: https://blog.csdn.net/lxt_Lucia/article/details/81206439

经典 DP 题。

维护以 `i` 结尾的 LIS 的长度
   设数组为 `N`，`F[i]` 为以 `i` 结尾的最长上升子序列的长度，有递推式：`F[i] = F[j]+1`，where `N[i] < N[j]`，这个 j 得通过一个 `0..i` 的循环获取，因此复杂度 为 :math:`O(n^2)`

维护长度为 `i` 的 LIS 结尾元素的最小值
   复杂度 :math:`O(n\log n)`，是我想不出来的解法 T_T。

   .. note:: 感觉没有说明白，算了。

Edit Distance
-------------

.. leetcode:: _
   :id: edit-distance
   :diffculty: Hard
   :language: rust
   :key: 动态规划
   :date: 2021-07-12
   :reference: https://leetcode-cn.com/problems/edit-distance/solution/bian-ji-ju-chi-by-leetcode-solution/

太难了……毫无思路直接看题解。

Minimum ASCII Delete Sum for Two Strings
----------------------------------------

.. leetcode:: _
   :id: minimum-ascii-delete-sum-for-two-strings
   :diffculty: Medium
   :language: rust
   :key: 动态规划
   :date: 2021-07-12

:leetcode:`Edit Distance` 的变种，将最少操作数变成了最少的 ASCII 之和而已。

一开始审错题，难受。

Longest Common Subsequence
--------------------------

.. leetcode:: _
   :id: longest-common-subsequence
   :diffculty: Medium
   :language: rust
   :key: 动态规划
   :date: 2021-07-13

涉及两个数组的 DP 问题常常是二维 DP，和 `:leetcode:`Edit Distance` 的思路有相似之处。

两串为 `S1`, `S2`。`定义数组 `D[i][j]` 表示 `S1[0..i]` `S2[0..j]` 的 LCS 长度：

- 讨论 `D[i-1][j]`, `D[i][j-1]`, `D[i-1][j-1]` 和 `D[i][j]` 的递推关系
- 讨论可能的 `D[0..i][j]`, `D[i][0..j]` 的初始化

.. note:: 当 `S1[0..i] = A B C D` `S2[0..j] = A D`，不需要在 `D[i-1][j]` 中讨论 
   `S1[i-1] == D` 的加入对 LCS 长度的影响，这部分情况完全由 `D[i-1][j-1]` 覆盖。

因此递推公式为::

   D[i][j] = max(D[i-1][j], D[i][j-1], D[i-1][j-1] + X)

   where X = 1 when S1[i-1] == S2[j-1]

当 `S1[i-1] == S2[j-1]` 时，LCS 延长。

Longest Palindromic Subsequence
-------------------------------

.. leetcode:: _
   :id: longest-palindromic-subsequence
   :diffculty: Medium
   :language: rust
   :key: 动态规划
   :date: 2021-07-13

最长回文串。

作为 :leetcode:`Longest Common Subsequence` 的变种
   将字符串翻转过来作为第二个数组，求 LCS 即可。

.. todo:: 常规解法

Longest Palindromic Substring
-----------------------------

.. leetcode:: _
   :id: longest-palindromic-substring
   :diffculty: Medium
   :language: rust
   :key: 递归 动态规划
   :date: 2021-07-13

钻了牛角尖……还不如直接看题解。

分情况递归
   字符串为 `S`，开一个全局变量存最大回文字串的区间 `ANS = (0, 0)`，对每一个 `S[i]`，从中间往两边扫，可获得所有的 "YXY" 的奇数回文串。但注意有 "YXXY" 的偶数回文串，则对每一个相等的 `S[i-1]` 和 `S[i]` 往两边扫。

   复杂度为 :math:`O(n^2)`，感觉可以用记忆化优化一下。

DP
   状态数组 `D[i][j]` 表示 `S[i..j]` 是否为回文串。若 `S[i] == S[j]`，则 `D[i][j]` 为回文串的话需要：

   - `i - j < 2`
   - 或者 `D[i+1][j-1]` 为回文串 where `i - j < 2`

   复杂度同为 :math:`O(n^2)`。
   
   .. note:: 应当注意两层循环的方向，外层 `i = n -> 0`，内层 `j = i -> n` 是为了保证求 `D[i][j]` 时 `D[i+1][j-1]` 已解出

.. todo:: 听说有 :math:`O(n)` 的做法，改日再学习吧。

Linked List Cycle
-----------------

.. leetcode:: _
   :id: linked-list-cycle
   :diffculty: Easy
   :language: go
   :key: 链表 快慢指针
   :date: 2021-07-13

无论如何时间复杂度都是 :math:`O(n)`，用哈希标表存 visited 的做法不用说了。

题目要求用 :math:`O(1)` 空间，估计我独立做不出来。很久前听 :friend:`pcf` 说到用两个指针，所以稍微回忆了一下：用两个步长不一致的指针，一个每次一个节点，一个每次两个节点，如果成环的话总会相遇。

.. seealso:: :friend:`fei.li` 的 解法_ 惊为天人

   .. _解法: https://leetcode-cn.com/problems/linked-list-cycle/solution/qiao-miao-li-yong-zhi-zhen-cun-chu-jie-d-xeca/

Linked List Cycle II
--------------------

.. leetcode:: _
   :id: linked-list-cycle-ii
   :diffculty: Medium
   :language: go
   :key: 链表 快慢指针
   :date: 2021-07-15
   :reference: https://leetcode-cn.com/problems/linked-list-cycle-ii/solution/huan-xing-lian-biao-ii-by-leetcode-solution/

看的题解。

我根本没在动脑子…… :(

Product of Array Except Self
----------------------------

.. leetcode:: _
   :id: product-of-array-except-self
   :diffculty: Medium
   :language:
   :key: 前缀数组
   :date: 2021-07-15
   :reference: https://cntofu.com/book/186/problems/238.product-of-array-except-self.md


不许用除法，想不出来，看的题解。

双前缀数组
   巧妙的双前缀数组，时间空间复杂度均为 :math:`O(n)`。

双前缀数组 无无额外空间
   题目希望 :math:`O(1)` 的空间复杂度，可以用一个临时变量存累乘结果，直接用存答案的数组的空间。

Trapping Rain Water
-------------------

.. leetcode:: _
   :id: trapping-rain-water
   :diffculty: Hard
   :language: rust
   :key: 动态规划 双指针 单调栈
   :date: 2021-07-15

似乎 :friend:`pcf` 也和我提到过，然而完全忘了。

看题解。

动态规划
   其实也不像动态规划……倒不如说是 :leetcode:`Product of Array Except Self` 的变种，同样用到两个数组。

   `L[i]`, `R[i]` 为以第 `i` 格为中心，左右的最高点的高度，每一格可能容纳的水量为 `W[i] = min(L[i], R[i]) - Height[i]`。

单调栈 [#]_
   利用单调栈的性质，维护一个由高到低的水洼左边，每次 pop 的时候，算该水洼里的一层水

.. todo:: 还有 :math:`O(1)` 解法…… 歇会儿。

Next Greater Element I
----------------------

.. leetcode:: _
   :id: next-greater-element-i
   :diffculty: Easy
   :language: rust
   :key: 单调栈
   :date: 2021-07-16

读题花了挺久……

暴力法可直接做，复杂度 :math:`O(m*n)，`m` 为 `nums1` 长度，`n` 为 `nums2` 长度。

更好的做法是对 `nums2` 维护一个数组 `G[i]`，代表在 `nums2[i]` 右边比它大的元素（即 Next Greater Element），将 `nums1[i] => i` 的映射存在哈希表中，遍历 `nums2` 时可以得出答案。

`G[i]` 的求法为：从 `nums2.len() => 0` 方向维护一个单调递减的栈，依次尝试 push `nums2[i]`，当比栈顶大时，将栈中已有元素 pop 出；当比栈顶小时，`G[i] = top_of_stack`，之后 `nums2[i]` 入栈。

.. tip:: `G[i]` 不依赖上一次循环的结果，在实际中可以就地求出，不必开辟空间

建哈希表复杂度为 :math:`O(m)`，建单调栈复杂度为 :math:`O(n)`，总的时间复杂度为 :math:`O(m+n)`。

Swap Nodes in Pairs
-------------------

.. leetcode:: _
   :id: swap-nodes-in-pairs
   :diffculty: Medium
   :language: go
   :key: 链表
   :date: 2021-07-16

用一个步进为 2 的循环即可。

Reverse Linked List
-------------------

.. leetcode:: _
   :id: reverse-linked-list
   :diffculty: Easy
   :language: go
   :key: 链表
   :date: 2021-07-16
   :reference: https://zhuanlan.zhihu.com/p/86745433

:del:`没啥好说`。

递归
   万万没想到……递归我没写出来。看题解，题解说很明白了。

迭代
   拿个栈。


Reverse Linked List II
----------------------

.. leetcode:: _
   :id: reverse-linked-list-ii
   :diffculty: Medium
   :language: go
   :key: 链表
   :date: 2021-07-16

:leetcode:`Reverse Linked List` 的变种。被翻转的链表的 tail 应始终指向右边不翻转的部分，因此处理右边界的时候要花点心思。

Implement Trie Prefix Tree
--------------------------

.. leetcode:: _
   :id: implement-trie-prefix-tree
   :diffculty: Medium
   :language: go
   :key: Tire树
   :date: 2021-07-16

纯数据结构题。

Combination Sum
---------------

.. leetcode:: _
   :id: combination-sum
   :diffculty: Medium
   :language: rust
   :key: 回溯
   :date: 2021-07-17

从给定的 `candicates` 生成 sum 为 `target` 的组合。

递归可破，和之前的题不一样的是在每一次调用都伴随着一个新的解，所以要带着解的数组一起递归。

Generate Parentheses
--------------------

.. leetcode:: _
   :id: generate-parentheses
   :diffculty: Medium
   :language: rust
   :key: 回溯
   :date: 2021-07-17

和 :leetcode:`Combination Sum` 类似的解法。

每一次递归中需要的决策是：要闭合几个未闭合的括号。

Sort an Array
-------------

.. leetcode:: _
   :id: sort-an-array
   :diffculty: Medium
   :language: rust
   :key: 排序
   :date: 2021-07-19
   :reference: https://rust-algo.club/sorting/quicksort

:2021-07-17: 情绪又不好了，看了近两个小时的快排教程没看进去。

使用固定 pivot 的普通的快排会 TLE，因为有一个近乎有序的大数组 case。

Rust 标准库没有生成随机数的函数……糊了一个。

Combination Sum II
------------------

.. leetcode:: _
   :id: combination-sum-ii
   :diffculty: Medium
   :language: rust
   :key: 回溯
   :date: 2021-07-19

:leetcode:`Combination Sum` 的变种。

增加了 `candicates` 可重复、以及结果不许重复的两个限制。

3Sum
----

.. leetcode:: _
   :id: 3sum
   :diffculty: Medium
   :language: rust
   :key: 双指针
   :date: 2021-07-19
   :reference: https://leetcode-cn.com/problems/3sum/solution/san-shu-zhi-he-by-leetcode-solution/

题目有双指针的标签，我怎么觉得回溯法就能做？试试看。

不能，评测 TLE 了，本地则是爆栈

双指针
   看题解，把三重循环优化到二重了，复杂度 :math:`O(n^2)`

   .. note:: 答案不许重复，`i`，`j` 的循环里都有 `nums[i] == nums[i - 1]` 的判断以跳过重复元素，但不必要对 `k` 判断，因为 `i`，`j` 已经不重复了，`k` 自然不重复

Reverse Nodes In K Group
------------------------

.. leetcode:: _
   :id: reverse-nodes-in-k-group
   :diffculty: Hard
   :language: go
   :key: 链表
   :date: 2021-07-19

:leetcode:`Reverse Linked List II` 的变种，多了两个返回值： 一个用于返回翻转后的链表 tail，方便接下一段翻转链表，另一个一个用于判断该段需不需要 reverse，比较琐碎。

Evaluate Reverse Polish Notation
--------------------------------

.. leetcode:: _
   :id: evaluate-reverse-polish-notation
   :diffculty: Medium
   :language: rust
   :date: 2021-07-20

模拟题，只是对 rust 的字符串操作不太熟悉。

Balanced Binary Tree
--------------------

.. leetcode:: _
   :id: balanced-binary-tree
   :diffculty: Easy
   :language: go
   :key: 二叉树 平衡二叉树
   :date: 2021-07-20

判断子树是否平衡的时候要同时返回子树深度供父节点用。

Convert Sorted Array To Binary Search Tree
------------------------------------------

.. leetcode:: _
   :id: convert-sorted-array-to-binary-search-tree
   :diffculty: Easy
   :language: go
   :key: 二叉树 二叉搜索树
   :date: 2021-07-20

数组本身排好序了，用二分的方法就能找到每一层的 root。

Balance A Binary Search Tree
----------------------------

.. leetcode:: _
   :id: balance-a-binary-search-tree
   :diffculty: Medium
   :language: go
   :key: 二叉树 平衡二叉树
   :date: 2021-07-20

:leetcode:`Convert Sorted Array To Binary Search Tree` 的变种。

中序遍历 BST 能得到一个有序数组，用二分法构造出来的 BST 就是平衡的。

Ones and Zeroes
---------------

.. leetcode:: _
   :id: ones-and-zeroes
   :diffculty: Medium
   :language: go
   :key: 动态规划
   :date: 2021-07-28

01 背包问题，但需要同时填满两个容量不同的背包。

.. note:: 

   在不优化的情况下，空间复杂度为 :math:`O(len*m*n)`，需要一个三维的状态数组，
   在 `m < count0 && n < count1` 的情况下，需要将 `dp[i-1]` 的状态复制到 `dp[i]`
   反之，可以应用递推公式。

   在优化的空间的情况下，第 i 轮循环中，未遍历 dp 的值即为 i-1 轮循环残留的值。

--------------------------------------------------------------------------------

.. rubric:: 脚注

.. [#] https://twitter.com/mxcl/status/608682016205344768
.. [#] https://oi-wiki.org/ds/monotonous-stack/
