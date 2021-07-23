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

进程、线程和协程 |x|
---------------------

进程有独立地址空间，线程无

协程：纯粹的用户态实现

fork & exec |x|
---------------

没啥好说。

进程间通信方式概述 |x|
----------------------

- 文件
- 信号
- 信号量（PV 原语维护一个临界区）
- Unix socket
- Message Queue
- 管道
- `mkfifo` 命名管道（传统管道属于匿名管道，其生存期不超过创建管道的进程的生存期。但命名管道的生存期可以与操作系统运行期一样长）
- Shared Memory
- Mapped File

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

垃圾回收
--------

:URL: http://legendtkl.com/2017/04/28/golang-gc/

经典 GC 算法 |x|
~~~~~~~~~~~~~~~~

经典的 GC 算法
   - 引用计数（reference counting）
   - 标记-清扫（mark & sweep）
   - 节点复制（Copying Garbage Collection）
   - 分代收集（Generational Garbage Collection）。

引用计数
   Pros
      - 渐进式的，能够将内存管理的开销分布到整个程序之中
      - 易于实现
      - 回收速度快
   Cons
      - 不能处理循环引用（引入强弱引用可破）
      - 降低运行效率
      - free list 实现的话不是 cache-friendly

标记-清扫
   内存单元并不会在变成垃圾立刻回收，而是保持不可达状态，直到到达某个阈值或者固定时间长度。这个时候系统会挂起用户程序，也就是 STW，转而执行垃圾回收程序。垃圾回收程序对所有的存活单元进行一次全局遍历确定哪些单元可以回收。算法分两个部分：标记（mark）和清扫（sweep）。标记阶段表明所有的存活单元，清扫阶段将垃圾单元回收。

   Pros
      - 支持循环引用
      - 运行时开销小
   Cons
      - 需要 STW

三色标记
   是「标记-清扫」的变种，对标记阶段进行了改进：

   1. 起初所有对象都是白色
   2. 从根出发扫描所有可达对象，标记为灰色，放入待处理队列
   3. 从队列取出灰色对象，将其引用对象标记为灰色放入队列，自身标记为黑色
   4. 重复 3，直到灰色对象队列为空。此时白色对象即为垃圾，进行回收

   Pros
      能够让用户程序和 标记 并发的进行（？），减少 STW 的时间

      .. note:: 标记期间有新的对象分配/释放怎么办？

         通过设置写屏障（write barriar）记录下来，标记完 STW 再检查一遍

   .. note:: Golang GC 使用三色标记法

节点复制
   Pros
      - 无内存碎片
      - allocate 简单，通过递增自由空间指针即可
   Cons
      - 总有一半的内存空间处于浪费状态

基于追踪的垃圾回收算法（标记-清扫、节点复制）一个主要问题是在生命周期较长的对象上浪费时间（长生命周期的对象是不需要频繁扫描的）。同时，内存分配存在这么一个事实：

   most object die young  [Ungar, 1984]

分代收集
   分代垃圾回收算法将对象按生命周期长短存放到堆上的两个（或者更多）区域，这些区域就是分代（generation）。对于新生代的区域的垃圾回收频率要明显高于老年代区域。

   分配对象的时候从新生代里面分配，如果后面发现对象的生命周期较长，则将其移到老年代，这个过程叫做 promote。随着不断 promote，最后新生代的大小在整个堆的占用比例不会特别大。收集的时候集中主要精力在新生代就会相对来说效率更高，STW 时间也会更短。

   Pros
      性能优
   Cons
      实现复杂

Go 的垃圾回收 |x|
~~~~~~~~~~~~~~~~~

何时触发 GC 检测
   :被动触发: 在堆上分配大于 32K byte 对象时触发 GC 检测
   :主动触发: 调用 `rumtime.GC()`

GC 触发条件
   `forceTrigger || memstats.heap_live >= memstats.gc_trigger`

   当前堆上的活跃对象大于我们初始化时候设置的 GC 触发阈值

   `memstats.gc_trigger` 在 `gcinit()` 时被设置

两次 mark
   1. 从 root 开始遍历，标记为灰色。遍历灰色队列
   2. re-scan 全局指针和栈。因为 mark 和用户程序是并行的，所以在过程 1 的时候可能会有新的对象分配，这个时候就需要通过写屏障（write barrier）记录下来。re-scan 再完成检查

两次 STW
   1. GC 将要开始的一些准备工作，比如 enable write barrier
   2. re-scan，如果这个时候没有 STW，那么 mark 将无休止

写屏障
   收集 mark 期间的对象分配情况

Dive in to code
   :gcBgMarkStartWorkers: 为每个 P（线程上的本地调度器）启动一个 gcMarkWoker
   :gcDrain: Mark 阶段的标记代码主要实现

内存管理 |x|
------------

逃逸分析: `go run` with `-gcflags '-m -l'`

如何得知变量是分配在栈（stack）上还是堆（heap）上？
   不需要关心，由 go 内部决定

多级分配器
   :mcache: per-P cache，可以认为是 local cache，不需要加锁
   :mcentral: 全局 cache，mcache 不够用的时候向 mcentral 申请。
   :mheap: 当 mcentral 也不够用的时候，通过 mheap 向操作系统申请。

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
