======================
From Anyting to Sphinx
======================

.. post::
   :tags: Draft
   :author: LA
   :language: zh

..

     :friend:`SilverRainZ` （指我自己）在使用一个还未存在的自建笔记系统，
     每次想写点东西都因为「无法解决依赖」而失败。 [#]_

不知何时我养成了一种奇怪的癖好，想读一本有价值的书，没有合适工具记读书笔记，
所以不读。 想记录一些不成体系的知识，不知道如何组织分类这些碎片，所以不记。
想写一篇博客，文章里有一些交叉引用，不想用粗暴的 ``<a href=xxx>`` ，所以不写。
因噎废食大概就是这样吧。

.. contents::
   :local:

挑选标准
========

我并非没有在找合适的记录工具，大学时用 OneNote，在我还热衷于成为一个黑客的时候，
我用 OneNotes 记下了几十篇 OllyDBG 的学习笔记。那时候云同步功能还不够好，
在一次误操作中丢失了笔记，从此成为软黑。

后来 Gitbook 流行起来，尝试用其管理笔记，奈何 Node.js 太慢而 Markdown 表达力太孱弱。
我还在 AUR 维护了 :aur:`nodejs-gitbook` ，它的打包非常恶心，提供了一个只许全局
安装的 :aur:`nodejs-gitbook-cli` 作为安装器，而不允许用户单独安装 :aur:`nodejs-gitbook` 。
这让发行版的打包非常困难。

在漫长的寻找中地我形成了自己的挑选标准：

自由，开源
    我不信任商业软件、共享软件：商业软件会倒闭，会改变定价，而共享软件随时面临
    不再更新的窘境

少做多余的事（低复杂度）
    是指这个项目除了做「记录」本身，为了它的目标，它还多做了哪些事情。
    多做的事情可能有帐号体系，权限控制，甚至 APP 等，复杂度大意味着项目：

    - 实现和维护的难度会上升
    - 自身的维护成本也会上升
    - 迁移难度会上升：可能使用了非标准的协议（标准协议无法满足需求）

    打个不恰当的比喻，最简单的「网盘」只要 WebDAV Server + Client 即可，rclone
    可以是 WebDAV server，任意的浏览器都能当 WebDAV Client。
    更复杂的系统 OwnCloud、NextCloud 则实现了五花八门的功能，当然他们也对 end user
    更友好。

    少做多余的事情意味着项目组的目标更一致，维持运转所需资源能少，垮掉的可能性
    更小。就算垮了，fork 一个项目也比 fork 十个项目愉快地多。

长寿
    软件基金会往往比三五人形成的组织的更长寿，必要的时候他们可以雇人来开发。
    而个人就完全是兴趣使然

    当然自由软件的优点也在此，如果项目组垮掉，只要项目本身足够重要，总有有人能
    站出来 fork 或者继续维护的，再不行就自己上。

使用纯文本
    就编辑体验的一环来说，富文本往往绑定一个复杂的，羸弱（想想论坛编辑器）或者
    难以预料的（想想 MS Word）的编辑器，这当然不能怪他们，富文本编辑真是是太难了。

    纯文本给我一种踏实感：

    - 不会产生冗余代码 -- 你写什么它就是什么
    - 不限制编辑器 -- 我可以继续用 (Neo)Vim
    - 容易自动化地修改 -- sed 也是编辑器呀

让别人做多余的事（可扩展）
    这里的可扩展不止是工具本身提供了扩展机制，而是 **工具在设计上留下了别人来填补的位置** 。
    可能说得有点绕，比如在这个项目里，我们选用 HTML 来表示富文本，但自己却不开发编辑器如何？
    让用户去用别人写的编辑器。这在商业上当然不是一个好的策略（所以我们不用商业
    软件 ``:)`` ），就算不是商业软件，这么做其实也降低了用户的粘性（但不考虑这
    个的开源软件可不少啊 ``:)`` ）

    但对我来说呢？我看到项目组因此节省了资源，我获得了自由更换编辑器的权利，
    对于我的整个笔记系统而言，我将 **复杂度分摊到了不同的项目身上** ，在未来
    某一个项目跑路的时候，我只需要寻找它那一部分的替代品就好了。

2017 年我用 :doc:`Sphinx 管理我的笔记 </blog/use-sphinx-and-rst-to-manage-your-notes>` ，
reStructuredText 很接近我心中理想的 markup language 的样子，结果刚建起一个框架便开始荒废。
从那时到现在已经过去了四年，我记录下了些什么呢？

    **「什么都没有」**

2020 年，3、4 月的时候我尝试用 Golang 从零开始写一个笔记软件，后来发现无论是设计和工作量都
不是我能够胜任的，最后只留下一个零零落落的仓库。

5 月，我建立了 :ghrepo:`SilverRainZ/bullet` 仓库准备再试试 Sphinx，
之后学画需要记 :doc:`大量的笔记 </notes/zxsys/index>`，将他们电子化也是一个强大的驱动力。

9 月的时候生病，居然也因祸得福，捡到了几个月的疗养时间。
在家的时候里我好好学习了一下 Sphinx 和 Docutils，思考各种类型的文档要如何组织，
尝试使用社区提供的 :github:`各种扩展 <sphinx-contrib>`来增强文档的功能，
可惜其中不少扩展已经年久失修。再后来自己也建立了一个一人组织 :github:`sphinx-notes` ，
用来存放自己写的扩展，顺便回馈社区。

随着对 Sphinx+reStructuredText 实践的增多和一些扩展的完成，我的笔记终于慢慢成形了。

- 按体裁对内容进行分类，分为 博客、笔记、随记、手册、收藏等几类，
  避免了不知道记在哪里的困境 。

- 用 :ghrepo:`sphinx-notes/lilypond` 来保存 :doc:`谱子 </collections/scores/index>`
- 用 :ghrepo:`sphinx-notes/any` 来结构化地记录 :doc:`友链 </about/friends> 、
  :doc:`习作 <../collections/art-works/index>` 和 `doc:`读书笔记 </notes/books/index>`
  等
- 用 :ghrepo:`executablebooks/sphinx-panels` 为首页分栏，顺便还享用了它内置的
  :fa:`font-awesome` 支持

博客是最难办的一件事情，不用插件就不像博客，
写个插件工作量又巨大，好在这件事情已经有人做了，并且做得非常舒服，完全符合我的想象：
sunpy 社区写了一个叫 `ablog <https://ablog.readthedocs.io>`_ 的扩展，归类、
标签、归档、RSS 应有尽有，开发也非常活跃。

很棒的一点是 Sphinx 的 sidebar 并不是全局的，可以用 glob pattern 让不同的页面用不同的
sidebar，ABlog 引入的博客侧边栏并不会影响现有的其他的文档。对于特别的不需要侧边栏的页面，
比如 :doc:`简历 </about/resume>` ，可以定义一个空白的侧边栏。

.. code-block:: python

    html_sidebars = {
        # Match all blog pages
        'blog/*': ['about.html', 'postcard.html', 'recentposts.html',
                   'tagcloud.html', 'categories.html', 'archives.html'],
        # Match all pages but excluding blog
        '*[!blog]*': ['about.html', 'navigation.html', 'relations.html',
                      'searchbox.html', 'donate.html'],
        # Clean all sidebar for resume page
        'about/resume': ['empty.html'],
    }

比较遗憾的是，正在使用的 sphinx_rtd_theme 并不听 Sphinx 的 sidebar 配置，
因此还是换到了默认的 Alabaster。

迁移
====

Jekyll
------

之前在 Jekyll 的文章并没有很大的价值，但本着不做 breaking change 的原则，
还是迁移过去了：

使用 m2r 将 markdown 转为 rst，用 awk 将 Jekyll 的 metadata

最重要的，新的博客地址是 https://silverrainz.me/blog/ , tech.silverrainz.me 之后会
redirect 到新地址。

Read The Docs
-------------

近半年发生了非常大的事情，死去又活来，居然也因祸得福，捡到了几个月的疗养时间。
在这段时间里我慢慢把自己理想中的笔记系统架设起来。

.. [#] 和 :friend:`VOID001` 的 `对话节选 <https://void-shana.moe/linux/zh-taking-notes-with-vim.html#comment-530>`_

--------------------------------------------------------------------------------

.. isso::

