=================
知识点 Check List
=================

.. contents::
   :local:

.. |x| replace:: ✔️ 

计算机网络
==========

TCP 三次握手 |x|
----------------

由 client 执行 :manpage:`connect(3)` 触发。

.. image:: /_images/tcp-connection-made-three-way-handshake.png
   :target: https://hit-alibaba.github.io/interview/basic/network/TCP.html

作用：

- 确认双方的接收和发送能力是否正常
- 协商初始序列号，交换窗口大小等

半连接队列
   服务端第一次受到 SYN 包（`SYN_RCVD`）的队列

TCP 四次挥手 |x|
----------------

由任意一方执行 :manpage:`close(3)` 触发。

.. image:: /_images/tcp-connection-closed-four-way-handshake.png
   :target: https://hit-alibaba.github.io/interview/basic/network/TCP.html

为什么是 4 次
   被动端（被 close 那一端）要额外的准备才能关闭连接，主动端发的 FIN 相当于一次 notification。
   当被动端准备好了会发 FIN，这个 FIN 也需要 ACK

Server 大量 `TIME_WAIT`
   Server 端主动关连接导致的，可能会耗尽可用的端口

   解决
      连接复用
      要求客户端关连接

Server 大量 `CLOSE_WAIT`
   Client 端主动关连接，Server 没有发第二个 FIN

TCP UDP 区别 |x|
----------------

TCP
   全双工，面向连接，可靠，一对一通信

UDP
   无连接，不可靠，可多播、广播

select，epoll |x|
-----------------

:zhwiki:`Select_(Unix)`
   - 是个单独的系统调用
   - 复杂度 :math:`O(n)`
   - 连接数：`FD_SETSIZE = 8`

:zhwiki:`Epoll`
   - 是个模块，由三个系统调用组成
   - 底层为红黑树，复杂度 :math:`O(log_n)`
   - 连接数：API 上无限制
   - 边沿触发（异步推荐）、状态触发

Web
---

HTTPS 原理
~~~~~~~~~~

Session 和 Cookie
~~~~~~~~~~~~~~~~~

GET PUT DEL PATCH HEAD
~~~~~~~~~~~~~~~~~~~~~~

分布式
======

Map-Reduce 概述 |x|
-------------------

映射（可并行） -> 归纳

分布式 ID 生成 |x|
------------------

:URL: https://zhuanlan.zhihu.com/p/107939861

基本要求是全局唯一 —— 不冲突。

UUID / 自己随机生成
   :pros: - 不依赖外部服务
   :cons: - 业务价值不大
          - 不利于储存和索引
          - 不能趋势递增

单数据库自增 ID
   :pros: - 支持递增
   :cons: - 单点故障
          - 不利于储存和索引
          - 不能趋势递增

数据库集群自增 ID
   :pros: - 支持递增
          - 不存在单点问题
   :cons: - 数据库集群方案麻烦
          - 扩容麻烦

   避免重复 ID
      为不同实例制定不同的 ID 起始值，协商步长

分配号段
   业界主流方式之一，就是一个 ID Quota Server，Client 每次取一段，用完再申请

   :pros: - 对数据库压力小
   :cons: - 要不集群化还是单点
          - 朴素的实现中，没有把内存中的ID消费完重启服务，则会产生重复的ID

Redis
   优缺点同数据库

   需要考虑持久化的问题


Snowflake 算法
   Timestamp + Machine ID + Data Center ID + Auto Increasement Num

   :pros: - 不依赖外部服务
          - 便于链路追踪
          - 支持递增
   :cons: - int64 需要小心处理（前端）

选主
----

脑裂
----

CAP |x|
-------

   对于一个分布式计算系统来说，不可能同时满足以下三点：

   - 一致性（Consistency） （等同于所有节点访问同一份最新的数据副本）
   - 可用性（Availability）（每次请求都能获取到非错的响应——但是不保证获取的数据为最新数据）
   - 分区容错性（Partition tolerance）（以实际效果而言，分区相当于对通信的时限要求。系统如果不能在时限内达成数据一致性，就意味着发生了分区的情况，必须就当前操作在C和A之间做出选择）

   —— :zhwiki:`CAP定理`

P（分区容错性）是说这个系统要允许分区？

分布式锁
--------

etcd
redis redlock
codis

分布式定时器
------------

一致性级别
----------

:URL: https://github.com/javagrowing/JGrowing/blob/master/%E5%88%86%E5%B8%83%E5%BC%8F/%E8%B0%88%E8%B0%88%E6%95%B0%E6%8D%AE%E4%B8%80%E8%87%B4%E6%80%A7.md

最终一致性

因果/会话一致性

强/线性一致性

顺序一致性

海量数据 TopN
-------------

关系型数据库
============

数据库范式
----------

ACID
----

:A: Atomicity 原子性 锁
:C: Consistency 一致性
:I: Isolation 隔离性
:D: Durability 持久性 数据库的 redo log


隔离等级
--------

索引
----

B、B+ 树等多叉树

局部性原理

不同索引的优劣

分表与分片
----------

架构
====

微服务概述
----------

服务降级
--------

服务重试
--------

幂等性

限流器
------

负载均衡
--------

一致性哈希
----------

灰度测试
--------

A/B Test

实现

并发和吞吐
----------

协程 异步 读写分离

中间件
======

Redis 等缓存
------------

Kafka 等消息队列
----------------

投递语义
~~~~~~~~

etcd zk 等集群协同
------------------

操作系统
========

进程、线程和协程
----------------

fork & exec
-----------

进程间通信方式概述
------------------

Golang
======

调度问题 |x|
------------

:URL: https://www.douban.com/note/300631999/

线程模型
   :N:1: 可以很快的进行上下文切换，但是不能利用多核系统（multi-core systems）的优势
   :1:1: 能够利用机器上的所有核心的优势，但是上下文切换非常慢，因为不得不使用系统调用
   :M:N: 可以快速进行上下文切换，并且还能利用你系统上所有的核心的优势。主要的缺点是它增加了调度器的复杂性

M.P.G
   :M: OS 线程
   :P: Processor，可以把它看作在一个单线程上运行代码的调度器的一个本地化版本，携带一个 Goroutine 的 runqueue
   :G: Goroutine

   P 就是 `runtime.GOMAXPROCS` 里的 *P*\ ROCS.

M 为什么不是 P
   如果正在运行的 M 为某种原因需要阻塞的时候，我们可以把 P 移交给其它 M

     Go 程序要在多线程上运行的原因就是因为要处理系统调用，哪怕 `GOMAXPROCS` 等于 1

偷取 runqueue
   ..

     为了保持运行Go代码，一个上下文能够从全局runqueue中获取goroutines，但是如果全局runqueue中也没有goroutines了，那么上下文就不得不从其它地方获取goroutines了。

垃圾回收问题
------------

Channel
-------

调度
----

算法
====

树
   - 树的遍历 |x|
   - 平衡树
   - 二叉堆

动态规划
   - 最长上升子序列 |x|
   - 最长公共子序列 |x|
   - 最长回文串 |x|
   - 01 背包 |x|

.. rubric:: 脚注
