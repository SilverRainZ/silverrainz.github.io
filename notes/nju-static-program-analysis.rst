============
静态程序分析
============

:StartAt: 2022-7-16

南京大学《软件分析》课程。

- https://space.bilibili.com/2919428
- https://pascal-group.bitbucket.io/teaching.html

.. contents::
   :local:

1. Course Introduction
======================

.. term:: 莱斯定理
          Rice's theorem

   :zhwiki:`递归可枚举语言` 的所有非平凡（nontrival）性质都是 :zhwiki:`不可判定 <可判定性>` 的。 [rice0]_

   无法断言一个图灵机是否具有一个可以被图灵机计算的功能函数。[rice1]_

   .. figure:: /_images/2022-07-16_181851.png

   .. [rice0] :zhwiki:`莱斯定理`
   .. [rice1] https://zhuanlan.zhihu.com/p/339648002

.. term:: Sound and Complete
          Sound
          Complete

   Sound by default
      在静态分析中，几乎所有的分析方法都追求 Sound 而非 Complete。

   .. figure:: /_images/2022-07-16_182054.png

静态分析的思维
   Symbol evaluation，避免使用编程语言本身的思维。 TODO

静态分析的流程
   - 抽象
   - 近似

     - Transfer function <=  问题 + 语义
     - 控制流 <= flow merging

:math:`\top`: Top
   Unknown sign, 用来表示一个符号是未知的

:math:`\bot`: Bottom
   Undefined sign, 用来表示一个符号是未定义的
