=========================================
用 Sphinx + reStructuredText 构建笔记系统
=========================================

.. post:: 2017-03-29
   :tags: Sphinx, reStructuredText
   :author: LA
   :language: zh_CN


前几天把个人笔记从 GitBook 迁移到了 Sphinx 上，并在 `Read The Docs <http://readthedocs.io/>`_
上发布，地址是 `notes.silverrainz.me <http://notes.silverrainz.me>`_\ ，旧域名在过期前也同样有效。

.. contents::

前言
----

GitBook 是一个用于发布书籍的平台，允许你用 Markdown 编写书籍并使用 git 仓库管理，
还能通过这个平台发布到网络上，GitBook 同时也是 Gitbook 平台推出的书籍生成工具的名字。

去年十月的的时候我开始用 GitBook + Markdown 维护自己的一些零碎的笔记。
为此在 Arch Linux 打包了 `nodejs-gitbook <https://aur.archlinux.org/packages/nodejs-gitbook/>`_\ ，
又写了一个自动生成目录摘要的 `小脚本 <https://github.com/SilverRainZ/dotfiles/blob/master/bin/gitbook-summary>`_\ 。

为什么现在我又迁移到 Sphinx + reStructuredText 呢？因为：


#. GitBook 是 Node.JS 写的
#. Markdown 无法适应稍微复杂的写作场景

为什么我不喜欢 Node.js
----------------------

我不知道 Node.js 开发者为何如此热衷于用它来造各种轮子甚至用来写各种本地应用。
Node 的包管理器 npm 会将一个应用的所有依赖都安装在项目目录下。
每个应用的依赖都是独立的 —— 这对部署来说很方便。并且 npm 的分包粒度相当细，
随便装个包都能带上几百个依赖，连一个字符串的 leftpad 函数都可以单独作为一个包。
去年愚人节的时候，\ `这个梗 <https://www.npmjs.com/package/left-pad>`_\ 都玩得很开心……

因此 Linux 发行版的打包者要打包一个 Node 包，就得打包并维护它附带的成百上千
的依赖，或者直接将包本身和依赖打在一起，代价就是要更新其中一个依赖就得更新整个包
以及接受系统中的文件重复。总之，Node.js 的打包只能在麻烦和冗余两者之间作出选择。
听说 openSUSE 社区还写了一套工具专门用来从多如牛毛的 npm 包自动生成 rpm 包。

当然对于 Arch Linux 社区，肯定是拿起一把梭就干，即使是官方源的包也都是：

.. code-block:: bash

   npm install -g --user root --prefix "$pkgdir"/usr "$srcdir"/$pkgname-$pkgver.tgz

依赖什么的？不管，例行公事地从 source 下载要安装的包，依赖的什么完全由 npm 处理。

于是我打包的 nodejs-gitbook （事实上还包含了 nodejs-gitbook-cli）足足有 2w+
个文件，我仿佛看到无数细碎的 Javascript 脚本在我的 SSD 上蠕动……

.. code-block::

   / la @ la-arch 10:35 -> ~
   $ pacman -Ql nodejs-gitbook | wc -l
   23009


相比之下 python-sphinx 清爽多了：

.. code-block::

   / la @ la-arch 21:27 -> ~
   $ pacman -Ql python-sphinx | wc -l
   922


除去打包上的槽点，nodejs-gitbook 这工具的使用体验也是相当差：目录文件 SUMMARY.md
需要自己手动写；在我 i5 + 8G + SSD 的电脑上生成一本有 24 个 md 文件的书籍需要 **8.6 秒**
—— 它似乎并没有办法 incremental build；\ `gitbook serve` 命令能在本地启动一个 HTTP Server
预览书籍，并且文件改变的时候网页会自动刷新，这很赞，可是你为什么没告诉我每次文件改动
都要 **重载所有插件，重启 HTTP Server 并且所有的文件重新生成一遍** 呢？于是每次改动后你
需要十多秒后才能够「实时预览」。

以上所述的问题针对 GitBook 3.2.1 及以下版本。

Markdown vs reStructuredText
----------------------------

Markdown 是啥这里就不说了……Markdown 的问题在于它太轻又没有一个统一的标准。
因此各个社区都自顾自地实现了一套自己的方言，同样是叫 Markdown，
你在这里可以显示的内容，换了一个地方就打回原型。
当然你可以选择使用这些方言里面所共有的语法，而这点语法可能只够在论坛回回帖用。

目前最流行的 Markdown 方言应该是 GFM(GitHub Flavored Markdown) 了，
但即使你坚持只用 GFM 编写你的文档，你依然会遇到问题：
不同的 GFM 的实现存在细节上的差异。声明标题的 `#` 后面需要空格么？
加粗字体的 `**` 左右需要空格隔开么？直接跟非符号的文字会有问题么，
Unicode 的文字和符号能被分清么？在不将文件生成为 HTML 之前，你很难知道你的文档是
什么样子。

另，程序员是 Markdown 的主要使用群体，而 Markdown 居然使用「在行末空两格」
作为换行标记，trailing whitespace 怎么能忍呢……（这个貌似是扩展语法）

reStructuredText 同样是轻量标记语言的一种，Python Docutils 是其主要实现，
reStructuredText 的语法稍微复杂了一点，具体可以看
`reStructuredText 简介 <http://zh-sphinx-doc.readthedocs.io/en/latest/rest.html>`_\ 。

相对于 Markdown，reStructuredText：


* 提供了更丰富的语法元素：原生 Markdown 并不能调整插图大小，不支持表格（GFM 支持），
  不支持脚注，引用，注释 —— 当然这些 reStructuredText 都支持
* 对格式的要求更高：我所见过 Markdown 渲染器对待 Mardkown 的态度和浏览器对于
  HTML 类似，在处理无法识别的语法的时候会选择忽略。而 Docutils 在遇到未知语法的时候会报错。
  因此 Markdown 用户可能需要多次的预览文档来排错，而 reStructuredText 用户可以从报错获得
  出现错误的位置
* 有更统一的实现：这一点貌似不太公平，因为 Markdown 的实现众多，而 reStructuredText
  貌似就只有 Docutils 了？但实际上 reStructuredText 的标准也比 Markdown 明确得多
* 在语法上提供了扩展的途径。而 Markdown 并没有，通用的扩展方法是在文档里插入 HTML 标签……

就我所知， reStructuredText 有两种支持扩展的语法： 解释文本（Interpreted Text）
和 指令（Directives）。

在 reStructuredText 中，用单个反引号 `` ` 包围的字符串称为
`Interpreted Text <http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html#interpreted-text>`_
，反引号中的内容根据角色（Role）有不同解释方式。Role 由冒号 `:` 包围，可以位于
Interpreted Text 的前后。reStructuredText 利用 Interpreted Text 实现了不少的内联标记。比如：

.. code-block::

   :emphasis:`text` 等价于 *text*
   :strong:`text` 等价于 **text**


Interpreted Text 只能作为行内元素使用（无法跨行），而
`Explicit Markup <http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html#explicit-markup-blocks>`_
。作用的对象则是文本块。Explicit Mark 以在行首的两个句号 `..` 开始，后跟一个空格，
接下来的行保持相同缩进，直到文本块结束。

Explicit Markup 被用来实现


* 
  脚注：

  .. code-block::

       这是脚注 [#f1]_ ，这也是脚注 [#f2]_ 。

       .. [#f1] 第一条脚注的文本.
       .. [#f2] 第二条脚注的文本.

* 
  引用：

  .. code-block::

       这篇笔记参考了 [reStructuredText 简介]_

       .. [reStructuredText 简介]_ http://zh-sphinx-doc.readthedocs.io/en/latest/rest.html

* 
  显式的超链接：

  .. code-block::

       这是一个 `标题`_

       .. _标题: http://silverrainz.me

* 
  指令（Directives）是 reStructuredText 的又一扩展机制：插入图片，
  代码声明等语法均由 Directives 实现，和 Role 一样，指令可以被开发者定义。
  指令名后跟两个冒号，冒号后是参数。在新的一行里可以指定选项，选项由 `:` 包围，
  后跟选项值。选项之后还可能有文本块。

  .. code-block::

       .. 能够指定高宽，alt 文本，对齐的图片，比 Markdown 不知道高到哪里去了~
       .. image:: picture.jpeg
           :height: 100px
           :width: 200 px
           :scale: 50 %
           :alt: alternate text
           :align: right

Sphinx 简介
-----------

Sphinx 是 Georg Brandl 用 Python 编写的文档创建工具，以 BSD 协议开源，使用
reStructuredText 作为标记语言。Sphinx 被用来编写 `Python 的官方文档 <https://docs.python.org/>`_\ 。
去年 6 月的时候，\ `Linux Kernel 也开始使用 Sphinx + reStructuredText 管理内核文档 <https://lwn.net/Articles/692704/>`_\ 。
这里有一个使用 Sphinx 创建文档的项目列表：\ `Projects using Sphinx <http://www.sphinx-doc.org/en/stable/examples.html>`_\ 。


* Sphinx 能够将文档输出为 HTML，LaTex，Manuals page 等多种格式。
* 在 reStructuredText 的语法基础上提供了各种信息（文档，章节，函数，引用，术语）的交叉引用
* Sphinx 还能轻松地定义文档的层次结构：自动生成目录树，自动发现目录下的其他文档
* Sphinx 对 Python/C/C++ 等语言提供了良好的支持
* 支持扩展，你可以编写自己的模块

..

   看起来 Sphinx 的功能比 GitBook 丰富得多，但其实它们之间没什么可比性，
   因为 Sphinx 是文档生成工具而 GitBook 只是简单的书籍生成工具。


将 Markdown 笔记转化为 reStructuredText
---------------------------------------

使用 Sphinx 管理笔记的第一步是将之前笔记转成 rst 格式，Pandoc 大法好：

.. code-block:: bash

   for md in $(find . -name '*.md'); do
       pandoc --from=markdown --to=rst --output=$(dirname $md)/$(basename $md).rst $md;
   done

Shpinx 的安装和使用
-------------------

执行 `pip install sphinx` 即可安装 Sphinx，Arch Linux 用户可以执行
`pacman -S python-sphinx` 安装。Sphinx 提供了 `sphinx-quickstart` 程序，
可以交互式地建立一个 Sphinx 项目。项目目录下的 conf.py 储存了 Sphinx 的配置，
index.rst 则是默认的文档首页。

使用 `sphinx-build -b html <srcdir> <builddir>` 可以从 `<srcdir>` 生成 HTML
文档输出到 `<builddir>`\ ，如果在 `sphinx-quickstart` 中指定了生成 Makefile，通过
`make html` 即可生成 HTML 文档到预定义的 build 目录。

Sphinx 似乎没有提供类似 `gitbook serve` 在本地启动 HTTP 服务器的功能，Linux
用户在 Makefile 中增加如下内容则可方便的在默认浏览器打开文档的首页：

.. code-block:: makefile

   view:
       xdg-open "$(BUILDDIR)/html/index.html"

组织和索引
----------

Sphinx 定义了 `toctree` 指令作为目录树，各个文档由目录树组织在一起，
在构建文档的时候，如果存在没有被引用到的文档，Sphinx 会发出警告。

.. code-block:: rst

   .. toctree::
       :maxdepth: 2

       intro

上面的 rst 指令定义了一个最大深度为 2 的目录树，包含了当前目录下的 intro.rst 文件。
在渲染出来的 HTML 文件中，目录树会显示到 intro.html 的链接，链接的标题则会和
intro.rst 中的标题保持一致。如果 intro.rst 中存在章节，也会在目录树中显示出来，
但整个目录树的深度不超过 2。

如果只想要在目录树中显示文档的标题而不显示内部的章节，需要为 `toctree` 指令开启
`:titlesonly:` 选项。

`toctree` 在开启 `:glob:` 的情况下支持通配符，比如 `*` 匹配当前目录下所有的
（排除自身，下同）rst 文档。\ `index*` 匹配当前目录下所有以 index 开头的 rst 文档。

我在笔记的不同分类的文件夹中都建立了如下内容的 index.rst：

.. code-block:: rst

   Title
   =====

   Description.

   .. toctree::
      :glob:
      :titlesonly:

      *
      */index

这个 index.rst 会匹配当前目录所有的 rst 文档，并在所有的文件夹下寻找 index.rst。
所有的笔记通过 index.rst 被组织到一起。

使用 Read The Docs 发布
-----------------------

`Read The Docs <http://readthedocs.io/>`_ 是一个托管和展示文档的平台，支持 Sphinx
项目。在网站上注册后，授权 Github 即可从 Github 那边导入仓库。

因此可以将笔记本身托管在 Github 上，每次更新时会通过 webhook 自动更新
Read The Docs 上的文档。

P.S. Read The Docs 的主站看起来很简陋…… 给我一种要完蛋了的感觉。

--------------------------------------------------------------------------------

.. isso::
