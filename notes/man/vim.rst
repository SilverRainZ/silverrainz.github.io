==========
Vim/NeoVim
==========

:date: 2021-02-08

.. highlight:: vim

Mode line
=========

Execute script in comment::

    /* vim: set filetype=rst: */


批量处理文件
=============

用 `args` 批量打开文件, 用 `argdo` 批量处理::

    " 给 MnO2 的 PR: 把书中所有的 `` 替换为 ``haskell
    :cd GitHub\learnyouahaskell-zh\
    :args *\*\*.md
    :argdo %s/``\(\n.\)\@=/``haskell/ge | update

- 其中\ `\(\)\@=`\ 是正则的零宽断言
- `/ge`\ 的\ `e`\ 代表忽略错误
- `|`\ 是命令连接符
- `update` 表示文件发生改动后存盘, 不用 `update` 的话处理完一个文件会提示文件未保存
  (意思大概是处理完一个文件随即退出, 要手动存盘)

Vim Script
==========

.. seealso:: `Vim scripting cheatsheet <https://devhints.io/vimscript>`_

Variable Prefix
---------------

g: global::

    let g:foo = 'bar'

s: local (to script)::

    let s:foo = 'bar'

l: local (to function)::

    let l:foo = 'bar'

w: window::

    let w:foo = 'bar'

b: buffer::

    let b:foo = 'bar'

t: tab::

    let t:foo = 'bar'

Function Closure
----------------

``:h :func-closure``::

   function! s:my_function(dict_arg)
       let darg = copy(a:dict_arg)

       func! s:my_inner_func(cond) closure
         return darg[a:cond]
       endfunc

       return function('s:my_inner_func')
   endfunc

   let g:F = s:my_function({'a': 42, 'b': 5, 'c': 'str'})

.. seealso:: https://vi.stackexchange.com/a/21807

Tree Sitter
===========

 :``:Inspect``: to show the highlight groups under the cursor
 :``:InspectTree``: to show the parsed syntax tree ("TSPlayground")
 :``:EditQuery``: to open the Live Query Editor (Nvim 0.10+)

{Highlight,Injection} Query 
---------------------------

TreeSitter 支持用 Scheme 的 S-Expr 来手写节点树，称为 Query__，用以匹配 TreeSitter parser 产生的语法树。匹配到的节点可以被捕获（Capturing）并命名：

.. code:: scheme

   ; 捕获 strong 节点，命名为 makrup.strong
   (strong) @markup.strong

在 NeoVim 侧，使用 query 匹配的节点可以用来对代码做高亮（Highlight），以及正确处理代码 A 里嵌套的代码 B（Injection），例如以 Python 里的 docstring 注释以 |rst| 的语法编写，nvim-treesitter 可通过 Injection 来为 docstring 设定一个子 parser。

用 S-Expression 来手写节点树来匹配 TreeSitter 产生的 AST。

.. seealso::

   - `[Neovim Treesitter] Treesitter Query - YouTube <https://www.youtube.com/watch?v=86sgKa0jeO4>`_
   - `Add queries for sphinxnotes-strike and sphinx-design by SilverRainZ · Pull Request #21 · stsewd/sphinx.nvim <https://github.com/stsewd/sphinx.nvim/pull/21>`_

__ https://tree-sitter.github.io/tree-sitter/using-parsers#pattern-matching-with-queries
