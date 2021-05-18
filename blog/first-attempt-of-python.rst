========================================
 Python 初试
========================================

.. post:: 2015-06-15
   :tags: Python
   :author: LA
   :language: zh_CN


因为现在经常在三个系统(Win, openSUSE, Arch)之间切换, 一些软件的配置文件的部署成了问题,
每次都从一台机复制到另一台实在麻烦, 而且不知道哪台电脑上使用的配置是最新改动的.

所以后来就把配置文件托管到了GitCafe, 后来因为用不惯 GitCafe 的 web 界面,
还是在把配置文件放在 GitHub 上了:
`https://github.com/SilverRainZ/dotfiles <https://github.com/SilverRainZ/dotfiles>`_
(不过还是觉得更新这些配置文件的 Commit 太影响我的 ContributionsCalendar 了)

即使托管到 Github, 每次把文件拉下来都要复制到相应的位置上去, 依然麻烦,
所以就打算写个脚本来帮忙, 但是我并不会任何一门脚本
(Batch和Shell这些不跨平台的就算了...写起来又麻烦), 所以就现学现卖用 Python 试一试,
花了一个晚上, 写了个100来行的小脚本(有够慢的).
`https://github.com/SilverRainZ/dotfiles/blob/master/sync.py <https://github.com/SilverRainZ/dotfiles/blob/master/sync.py>`_

脚本
----

这个脚本的功能很简单, 就是根据指定的参数, 把指定的配置从仓库中复制到用户目录(deploy),
或者把用户目录下的配置复制到仓库(collect).\ :del:`这样都能写100多行!`

现在只支持我常用的三个软件的配置: vim, pentadacytl, zsh.

.. code-block::

   sync   -- a simple script used to sync profile
   python sync.py [operation]
   python sync.py [operation] [target]
   operation:
       deploy   [target]: copy target's profiles form repo to local
       collect  [target]: copy target's profiles form local to repo
       push:    push profiles to reomote repo
       pull:    pull profiles form reomote repo
   target:
       vim
       zsh
       pen(pentadactyl)
       all = vim + zsh + pen
   require: python3 or above, git


缩进
----

Python 的一大特点就是用缩进来划分代码块, 这会让 if 的嵌套变得很不清晰,
偏偏又不提供 switch 语句或者 Pattern Matching, 所以代码中的各种 if 又省不了,
这个有点痛苦. 不过 `if xx in [...]` 这样的语法我倒是觉得挺好的,
避免了\ `if a==xx || a == xxx || ...` 这样的超长 if.

函数式特性
----------

再跑一下题, 我在这学期看了F叔的「Haskell趣学指南」, 自觉 Haskell 这门语言难以入门,
至今写过的代码也不过寥寥数行, 只能算是大概了解了他的语法, 却因此沾染上了一些「恶习」,
老想在其他语言里使用那些FP的语法特性, 或者是当用这些特定可以让代码更好的时候,
抱怨 xxx 怎么没有这个语法. 我自己都觉得有点可笑, 不过, Python 一定程度上满足了我这奇怪的要求.

高阶函数
--------

很高兴 Python 里面提供了部分函数式语言的特性, 我在这个小脚本里用\ `map`\ 用得很爽.
sync.py 这个脚本是一个带参数运行的小工具, 需要输出 help 信息, 本来我是这样写的:

.. code-block:: python

   print('sync -- a simple script used to sync profile')
   print('python sync.py [operation]')
   print('python sync.py [operation] [target]')

有了\ `map`\ , 可以把所有的 help 信息放在一个 list 里面, 再用\ `map`\ 对每个元素应用\ `print`\ :

.. code-block:: python

   helpstr = [ 'sync -- a simple script used to sync profile'
             , 'python sync.py [operation]'
             , 'python sync.py [operation] [target]'
             ]
   list(map(print, helpstr))

注意这里不能直接\ `map(print, helpstr)`\ , `map`\ 返回一个\ `generator`\ ,
而\ `list()`\ 接受一个\ `generator`\ 得到一个列表, 这样\ `print`\ 才会得以执行.(大概是这样?)

`map`\ 不仅在这里有用到, `deploy`\ 和\ `collect`\ 是两个相反的操作, 无非是把两个地址交换,
地址被存在一个二元组的列表里, 所以可以用\ `map`\ 翻转:

.. code-block:: python

   if op == 'deploy':
       path = list(map(lambda x:(x[1],x[0]), path))

被弃用的元组参数解包
--------------------

本来上面那个翻转元组的 lambda 在 Python 2+ 可以这么写:

.. code-block:: python

   lambda (a, b):(b, a)

类似模式匹配的写法感觉很不错, 可是不知道为什么在 3.0 中这个语法被移除了.

部分应用
--------

`map`\ 只能对 list 映射只有一个参数的函数, 在 Haskell 中我们可以用部分应用
获得一个只需要一个参数的函数, 在 Python 中似乎不能直接做到, 但我们有折衷的办法:

.. code-block:: python

   def deploy(op, target):
   # ...
   list(map(lambda x: deploy(op,x),g_target[1:]))

用一个 lambda 来使得\ `deploy`\ 对外只有一个参数.

库
--

Python 库大概是 Python 备受推崇的一个重要原因, 可惜我的脚本只是在做文件复制,
没有用到什么特别的库.

不过拜 Python 良好的跨平台能力, 我不需要为处理 Windows 和 Linux 下不同的文件操作各写一份代码,
只需要对路径做些处理就行了.

:del:`感觉好像什么都没写啊(摔...`

--------------------------------------------------------------------------------

.. isso::
