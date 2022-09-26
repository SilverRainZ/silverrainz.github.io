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

.. term:: Top

   :math:`\top`，用来表示一个符号是未知的（Unknown）

.. term:: Bottom

   :math:`\bot`, 用来表示一个符号是未定义的（Undefined ）

2. Intermediate Representation
==============================

Intermediate Representation (IR) 是介于高级编程语言和字节码之间的一种中间表现形式，通常是 语言无关 + 机器无关的。用于编译优化和程序分析。

AST 和 IR 的异同：

.. figure:: /_images/18492e22-a308-4a83-9c1a-6819d8025917.png

常见的 IR 形式：

- :term:`3AC` 最常用
- :term:`SSA`

常见的 IR 语言：

- C - 天然的汇编抽象语言
- LLVM IR
- Soot (3AC)
- Jimple (Typed 3AC)

.. term:: Three-Addrress Code
          3AC
          TAC
          三地址码

   :enwiki:`Three-address_code`

   .. figure:: /_images/6e1456b0-5734-4083-8617-fb8676028fe3.png

.. term:: Static Single-Assignment
          SSA
          静态单赋值
   
   .. figure:: /_images/00cce13d-de57-41ac-b41b-84455cc2d6d7.png

.. term:: Control Flow Graph
          CFG
          控制流程图

   .. figure:: /_images/0bc9d1e2-3ea7-4c5f-b1ea-6f948c8684fb.png

.. term:: Basic Block
          BB
          基本块

   Entry of BB must be dest of a JUMP instr.
   Exit of BB must be a JUMP instr.

   .. figure:: /_images/dd34afeb-87e1-4cea-b8d5-d903eb179cb8.png

Some Soot Stuffs
----------------

`$x`: temp var of soot.

Java invoke type:

:special:   constructor, super class mentod, private method
:virtual:   instance method call (virtual dispatch)
:interface: can not optmizetion, check interface implementation
:static:    call static method
:dynamic:   for lambda

3. Data Flow Analysis I
=======================

.. term:: Data Flow Analysis
          数据流分析
          DFA

   How *Data* is *Flow* on :term:`CFG`?

   :Data: is application-specific data, an abstraction (such as :term:`Top`, :term:`Bottom`)
   :Flow: through the nodes(:term:`BB`\ s, statements) and edges (control flows)
          of CFG (program). Safe-approximation?


   Different data flow analysis application has:

   - different data abstraction
   - different flow safe-approximation strategies (策略)
   - different transfer functions and control-flow handlings

   .. figure:: /_images/screenshot-20220906-202633.png

.. term:: May Analysis::

   Output information *may* be true (over-approximation, sound?).

   Most static analyses is *May Analysis*.

   一般情况下 state 初始化为空集。

.. term:: Must Analysis::

   Output information *must* be must (under-approximation, complete?).

   一般情况下 state 初始化为全集。

Over- and under-approximation are both safty of analysis.

Input/Ouput States
   The set of possible data flow values is the domain for this application.

   .. figure:: /_images/screenshot-20220906-203643.png

      Target of :term:`DFA`.

Forward/Backward Analysis
   Nothing special.

Application
-----------

Reaching Definitions Analysis
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Intra-producedural CFG
2. No alias (alias: Pointer Analysis)

Dummy definition.

Bit Vectors

不动点计算

A\B => A but exclude B

模版

停机：IN[S] 不变时，OUT[S] 不变

OUT[S] never shrinks

.. figure:: /_images/screenshot-20220906-212807.png

   Iteration Cycles

4. Data Flow Analysis II
========================

Live Variable Analysis
~~~~~~~~~~~~~~~~~~~~~~

Abstraction
   Use a bit vector, one bit for one variable assignment (`v = x`). 1 for alive and 0 for dead.

Transfer function: (no formal)
   - Do backward iteratiom, find variable use statements in every basic block, once found, set corrspoind bit according its value.
   - Merge: `1 + ? -> 1` (It is a may analysis)
   - How to determine value?

Initial State
   All variables are dead, bit vector: `000...00`
