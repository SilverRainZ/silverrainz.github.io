====================================================
我如何用 Sphinx 建立笔记系统（一）选择 Sphinx 的理由
====================================================

.. post:: 2021-05-24
   :tags: Sphinx
   :author: LA
   :category: 我如何用 Sphinx 建立笔记系统
   :language: zh_CN

.. hint:: 这是 :ref:`category-我如何用-sphinx-建立笔记系统` 系列的第 |n| 篇，你可以通过订阅 :ref:`RSS <blog-feed>` 来获取后续更新。

.. |n| replace:: 一

.. hint:: 这个笔记系统是带有强烈个人色彩的 :ref:`笔记系统需求` 下诞生的，并不适合所有人，你可以稍作了解，再决定是否继续阅读。

.. hint:: 这篇文章作为系列的开场白，非常切题地只讲了我选择 Sphinx 的理由，不感兴趣也可以直接看 :doc:`下一篇文章 </blog/sphinx-as-note-taking-system-2>`

..

     :friend:`SilverRainZ` （指我自己）在使用一个还未存在的自建笔记系统，每次想写点东西都因为「无法解决依赖」而失败。 [#]_

不知何时我养成了一种奇怪的癖好，想读一本有价值的书，没有合适工具记读书笔记，所以不读。 想记录一些不成体系的知识，不知道如何组织分类这些碎片，所以不记。想写一篇博客，文章里有一些交叉引用，不想用粗暴的 `<a href=xxx>` ，所以不写。因噎废食大概就是这样吧。

.. contents::
   :local:

漫长的尝试
==========

我并非没有在找合适的记录工具，大学时用 OneNote，在我还热衷于成为一个黑客的时候，我用 OneNotes 记下了几十篇 OllyDBG 的学习笔记。那时候云同步功能还不够好，在一次误操作中丢失了部分笔记，从此成为软黑。

后来 GitBook 流行起来，尝试用其管理笔记，缺点有三：

- 太慢了
- Markdown 表达力太孱弱，索引靠手写，引用靠 HTML 链接
- 打包非常恶心：我曾在 AUR 维护过 :aur:`nodejs-gitbook`，gitbook 提供了一个只许全局安装（Root 下而非 Home 下）的 gitbook-cli 作为安装器，而不允许用户单独安装 gitbook 本身：这让发行版的打包非常困难。

2017 年我开始用 :doc:`Sphinx 管理我的笔记 </blog/use-sphinx-and-rst-to-manage-your-notes>` ，reStructuredText 已经很接近我心中理想的 markup language 的样子，结果刚建起一个框架便开始荒废。从那时到现在已经过去了四年，我记录下了些什么呢？——什么都没有

2020 年，3、4 月的时候我尝试用 Golang 从零开始写一个笔记软件，后来发现无论是设计和工作量都不是我单枪匹马能胜任的，最后只留下只有零星几个 commit 的仓库。

5 月，我建立了 :ghrepo:`SilverRainZ/bullet` 仓库准备再试试 Sphinx，之后学画需要记 :doc:`大量的笔记 </notes/zxsys/index>`，将他们电子化也是一个强大的驱动力。

9 月的时候生病，居然也因祸得福，捡到了几个月的疗养时间。在家的时候里我好好学习了一下 Sphinx 和 Docutils，思考各种类型的文档要如何组织，尝试使用社区提供的 :ghorg:`各种扩展 <sphinx-contrib>` 来增强文档的功能，再后来发现自己的需求社区并不能满足，便自己建立了一个一人社区 :ghorg:`sphinx-notes`。

2021 年，在陆续完善一些关键的 Sphinx 扩展之后，我的笔记系统 :del:`发出了响亮的第一声啼哭` 开始慢慢形成了。

.. _笔记系统需求:

需求
====

在漫长的寻找中我慢慢明确了自己的需求，以及自己心目中的笔记系统是什么样子的。

- 我希望 *笔记被良好分类且结构合理* ，对目录（Table Of Content）、交叉引用（Cross Reference）有一定需求

  - 我有一个 :ref:`博客 <blog-posts>`，我认为它一种 :del:`生产级别的` 笔记，应当作为系统的一部分
  - 一些不成体系的 :doc:`笔记片段 </misc/2021/index>` 有碎片化的属性，我需要他们能被合理组织

- 我希望能 *结构化地描述笔记中的对象* ，并对它们进行引用、索引和分类，听起来有些强迫症但并非空穴来风：

  - 我的 :doc:`绘画训练计划 </notes/zxsys/index>` 中包含大量的习作，我用希望用统一的方式记录他们的日期、尺幅、媒介，例如：:ref:`any-artworkmediumindex`
  - 我在学艺术史，以艺术家为脉络的话，我可以建立这样的索引：:ref:`any-artistindex`
  - 我的 :ref:`朋友们 <any-friendindex>` 经常会出现在我的行文中，我想漂亮地 mention 到 TA，比如 :friend:`quininer`，其实也是避免冗余的一个方式

- 我是 Linux 用户（B.T.W. Arch Linux [#]_），我在终端下工作，*我希望我的笔记在终端能被良好地检索和浏览*
- 我偏爱纯文本，作为曾经的 Mircosoft Word 的用户，我不喜欢复杂的富文本带来的难以预测的排版问题，以及兼容问题
- 我乐于折腾配置，有一定的编程经验：我清楚自己的需求特殊，愿意为此折腾，包括写一些代码

指标
====

我将上面的需求尽量转化为一些指标用于选型：

使用纯文本
    就编辑体验的一环来说，富文本往往绑定一个复杂的，羸弱（想想论坛编辑器）或者
    难以预料的（想想 MS Word）的编辑器，这当然不能怪他们，富文本编辑真是是太难了

    纯文本给我一种踏实感：

    - 不会产生冗余代码 -- 你写什么它就是什么
    - 不限制编辑器 -- 我可以继续用 (Neo)Vim

      .. note:: 其实不一定，看看 VimWiki、Org-mode

    - 容易自动化地修改

表达能力及格
   笔记系统所使用的表达方式（Markup language、富文本）要有一定的表达能力，对于书写中的常用格式（链接，引用，代码块、脚注、表格、提示、图片）都要有足够支持。

标准可扩展
   在前面的指标里为什么我不要求「表达能力强」呢？

   #. 强实际上意味着集成度高，和后面某一条指标相悖
   #. 强也意味着 Domain Specified，所有的通用 Markup language 都无法做到方方面面让人满意，笔记写多了总有自己的特殊需求。富文本里能打的可能只有也 OneNote 一个 —— 但我怎么可能去用它呢（笑）

   因此，够用就行—— 只要系统是可扩展，我们自己动手把它变强。

   B.T.W. 我不喜欢所有使用 Markdown 方言的笔记软件，这是不「标准」的扩展方式。

自由开源
    我不信任商业软件、共享软件：软件项目会倒闭，会改变定价，会做 Breaking Change，会停止维护——当然自由软件也会，只是你和社区并非无能为力

组件化
   我希望我的系统最终是由多个组件组合而成的，组件化意味着 *复杂度被分摊到了不同的组件上* ，在未来某一个项目跑路的时候，我只需要寻找它那一部分的替代品就好了。

目的单纯
   承上，在系统里负责解释和渲染笔记的核心组件几乎是不可替代的，那么我希望那个它是目的是单纯且稳定的。如果它还多做了很多事情。比如说发布系统、帐号体系、权限控制，甚至 APP 等，又或者它是某个庞大项目的附庸，那么我也倾向于不使用它。


reStructuredText + Sphinx
=========================

其实上面写一堆有些 :zhwiki:`先射箭再画靶` 的意思了，如题，最终我选择了 reStructuredText + Sphinx 作为笔记系统的核心。

现在介绍会不会太晚？

   |rst-badge| is an easy-to-read, what-you-see-is-what-you-get plaintext markup syntax and parser system. …  reStructuredText is designed for extensibility for specific application domains.  [#]_

   |sphinx-badge| Sphinx is a tool that makes it easy to create intelligent and beautiful documentation, written by Georg Brandl and licensed under the BSD license. It was originally created for the Python documentation, and it has excellent facilities for the documentation of software projects in a range of languages. [#]_

.. |rst-badge| image:: /_images/rst.png
   :target: https://docutils.sourceforge.io/rst.html
   :height: 1em

.. |sphinx-badge| image:: /_images/sphinx.png
   :target: https://www.sphinx-doc.org
   :height: 4em

针对上面的指标，reStructuredText（下称 reSt） + Sphinx 具有哪些优势呢？

#. reST 虽然稍显繁琐，但其表达能力非常优秀（从本文可见一斑）
#. "reST is designed for extensibility for specific application" 这不就是我想要的吗？
#. Sphinx 作为 Python 官方的文档生产系统，久经考验，同时也被大量著名非 Python项目（Blender、DPDK、Linux Kernel）采用
#. Sphinx 在 reST 的基础上实现了优秀的扩展机制，同时有 `大量的现成的扩展 <https://pypi.org/search/?q=sphinxcontrib>`_ 可用

更细节一点，Sphinx 提供的功能直击我的痛点（:del:`组合拳来一套`）：

- toctree 指令能将文档以树状的形式组织起来
- 交叉引用功能非常全面
- Domain_ 机制为后续的 :ref:`描述、引用和索引` 提供了基础

.. _Domain: https://www.sphinx-doc.org/en/master/usage/restructuredtext/domains.html

除此之外，单纯靠 Sphinx 无法达到的指标，我用扩展 + 其他组件搞定，请看下一篇文章：:doc:`/blog/sphinx-as-note-taking-system-2`。

.. rubric:: 脚注

.. [#] 和 :friend:`VOID001` 的 `对话节选 <https://void-shana.moe/linux/zh-taking-notes-with-vim.html#comment-530>`_
.. [#] https://www.quora.com/What-is-meant-by-btw-I-use-arch
.. [#] https://docutils.sourceforge.io/rst.html
.. [#] https://www.sphinx-doc.org

--------------------------------------------------------------------------------

.. isso::
