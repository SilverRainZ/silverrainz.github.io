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

熟悉语法……

LRU Cache
=========

.. leetcode:: _
   :id: lru-cache
   :diffculty: Medium
   :language: go

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

凡是链表的题目都不能用 rust :'(

Partition Equal Subset Sum
==========================

.. leetcode:: _
   :id: partition-equal-subset-sum
   :diffculty: Medium
   :language: rust
   :key: 动态规划

把一个集合分成两个，使其 sum 分别相等，可以转化为：

.. |Sa| replace:: S\ :sub:`a`

假设原集合 sum 为 |Sa| ，从集合中选出一个子集，使其 sum 刚好的为 |Sa|/2 ——  这是一个 01 背包问题，背包容量为 |Sa|/2，要求恰好装满，填充物的 cost 是数字的值，value 统一设置为 1，因为只需要证有解。

Merge Two Sorted Lists
======================

.. leetcode:: _
   :id: merge-two-sorted-lists
   :diffculty: Easy
   :language: go

纯逻辑题。

Maximum Subarray
================

.. leetcode:: _
   :id: maximum-subarray
   :diffculty: Easy
   :language: go
   :key: 动态规划 分治

题目本身比较简单，一维 DP 或者贪心均可做。
