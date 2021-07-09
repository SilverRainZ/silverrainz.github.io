=================
Leetcode 刷题记录
=================

:date: 2021-03-10

.. toctree::
   :titlesonly:

   dp

借鉴了 :ghrepo:`iosmanthus/leetcode-rust` 的做法，主要用 Rust 来刷题。
先从 🔥 `Top 100 Liked Questions`_ 开始看看？

.. _Top 100 Liked Questions: https://leetcode.com/problemset/all/?listId=79h8rn6

.. tip::

   用 :file:`./new-problem.sh` 来开始一道新题目：

   .. literalinclude:: ./new-problem.sh
      :language: bash

日记
====

:leetcode.date:`2021-07-05`
   刷 Easy 题练手感

:leetcode.date:`2021-07-06`
   刷 Easy 题练手感

:leetcode.date:`2021-07-07`
   继续刷 Easy 题练手感，:del:`尝试一道 Medium` ，做 :leetcode:`Best Time to Buy and Sell Stock` 系列三题，勉强出一道 Hard

:leetcode.date:`2021-07-08`
   有事早上出门一趟，回来也累的不想做题。晚上刷了一道二叉树的题目，因为粗心浪费了很多时间。

:leetcode.date:`2021-07-09`
   睡晚了，情绪不佳。两道 Medium 一道 Easy，就这样吧。

题解
====

.. contents::
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
   :date: 2021-05-08

在 touch 一个元素的的时候从链表尾部往上找，是一个 O(n) 的操作，然而
Leetcode 给过了…… 要是在 `SCAU OJ`_ 是肯定要 TLE。

.. note:: 看一眼输入输出限制，想想边界值，比如 `cap == 0` 的情况就忽略了

更聪明的做法是按 freq 分成多个桶，每次 touch 一个元素就把它挪到对应的
frequency 的桶里，并且 cache 内维护一个 minFreq 方便立刻找到最应该该淘汰的桶，
桶内部是一个小的 LRU，这样 touch 就是 O(n) 了。

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

.. [#] https://twitter.com/mxcl/status/608682016205344768

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
   :date: 2021-07-07
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

.. todo:: 更快的解法

Single Number
-------------

.. leetcode:: _
   :id: single-number
   :diffculty: Easy
   :language: rust
   :key: 位操作
   :date: 2021-07-07
   :reference: https://www.cnblogs.com/grandyang/p/4130577.html

遥想 pcf 师傅还跟我讨论过这题，可惜没记住。反正不看题解打死也做不出来。

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
