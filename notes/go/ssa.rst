========================
Static Single-Assignment
========================

.. highlight:: console

Dump SSA funtion::

   GOSSAFUNC=XXX GOSSACFG=lower..layout go build

展示控制流程图::

   GOSSAFUNC=XXX:*  go build

https://go-review.googlesource.com/c/go/+/142517/

`golang.org/x/tools/go/ssa`
===========================

`*ssa.BasicBlock`
-----------------

https://pkg.go.dev/golang.org/x/tools/go/ssa#BasicBlock

代表控制流分析中的 :zhwiki:`基本块`

Dominate
~~~~~~~~

.. term:: _
          支配关系
   :field: CFG
   :zhwiki: 控制流图#支配关系

   若从进入程式块到达基本块 N 的所有路径，都会在到达基本块 N 之前先到达基本块 M，则基本块 M 支配（dominates）基本块 N。

   支配者树（Dominator Tree）
      以基本块为节点，支配关系为边形成的树。

   :enwiki:`Extended_basic_block`

支持以下方法：

:`Dominates`: 查询另一个 block 是否被当前 block 支配
:`Dominees`: 返回当前 block 的直接支配的所有 blocks （dominator tree 上的对应节点的所有子节点）
:`Idom`: 返回支配当前 block 的 blocks （dominator tree 上的对应节点的父节点）
