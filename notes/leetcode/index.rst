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

.. contents::
   :local:

Two Sum
=======

.. leetcode:: _
   :id: two-sum
   :diffculty: Easy
   :language: rust

我居然以为是 a+b 真是太蠢了。

花了一些时间来回忆 rust 的语法，工作后技术直觉好了很多，之前觉得不容易理解的地方
（指 rust）现在觉得非常直观了。


Valid Parentheses
=================

.. leetcode:: _
   :id: valid-parentheses
   :diffculty: Easy
   :language: rust
   :date: 2021-05-04

熟悉语法……

LRU Cache
=========

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
=========

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

想过另一个做法是维护一个 freq 为结点值的最小堆，但本质上和方法一没区别，只是把 O(n)
的查找变成 O(logN) 而已，大量重复的 freq 值是很浪费时间和空间的。

.. _SCAU OJ: http://acm.scau.edu.cn:8000

Add Two Numbers
===============

.. leetcode:: _
   :id: add-two-numbers
   :diffculty: Medium
   :language: go
   :date: 2021-05-13

凡是链表的题目都不能用 rust :'(

Partition Equal Subset Sum
==========================

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
======================

.. leetcode:: _
   :id: merge-two-sorted-lists
   :diffculty: Easy
   :language: go
   :date: 2021-07-05

纯逻辑题。

Maximum Subarray
================

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
===============

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
=============================

.. leetcode:: _
   :id: binary-tree-inorder-traversal
   :diffculty: Easy
   :language: go
   :key: 二叉树
   :date: 2021-07-06

纯数据结构题，没啥好说。

Symmetric Tree
==============

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
