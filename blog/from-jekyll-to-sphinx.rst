=================
博客迁移到 Sphinx
=================

.. post:: 2020-12-26
   :tags: Python, Sphinx, 变更
   :author: LA
   :language: zh_CN

.. hint:: 这是一篇迁移自 Jekyll 的文章，如有格式问题，可到 :ghrepo:`SilverRainZ/bullet` 反馈

.. note:: 因此标题是指「博客从 Jekyll 迁移到 Sphinx」

近半年发生了非常大的事情，死去又活来，居然也因祸得福，捡到了几个月的疗养时间。
在这段时间里我慢慢把自己理想中的 PIM 系统架设起来。

2017 年我用 :doc:`Sphinx 管理我的笔记 </blog/use-sphinx-and-rst-to-manage-your-notes>`，
结果建完便开始荒废，那时候英语非常差，即使把 Sphinx 文档读下来也不明所以，用不好应该也是理所当然吧。

5 月的时候，我已经建好了 SilverRainZ/bullet 仓库准备再试试 Sphinx，
之后学画需要记大量的笔记，将他们电子化也是一个强大的驱动力。

于是在偷闲的这段时间里我好好学习了一下 Sphinx 和 Docutils，思考各种信息要如何组织，
试用社区提供的 `各种扩展 <https://github.com/sphinx-contrib>`_ ，其中不少年久失修，
也就写了一些 `扩展 <https://github.com/sphinx-notes>`_ 来满足自己的需求，顺便回馈社区。

个人主页、笔记、画、随记，甚至谱子也都被我慢慢搬进了 Sphinx。
博客是最难办的一件事情，不用插件就不像博客，写个插件工作量又巨大，
好在这件事情已经有人做了，并且做得非常舒服，完全符合我的想象。

sunpy 社区写了一个叫 `ablog <https://ablog.readthedocs.io>`_ 的 Sphinx 扩展，
归类、标签、归档、RSS 应有尽有，开发也非常活跃。

很棒的一点是 Sphinx 的 sidebar 并不是全局的，可以用 glob pattern 让不同的页面用不同的
sidebar，ablog 引入的博客侧边栏并不会影响其他的文档。但遗憾的是，正在使用的 sphinx_rtd_theme 并不听 Sphinx 的 sidebar 配置，因此还是换到了 Alabaster。

文章没有用，本着不做 breaking change 的原则，还是迁移过去了，所以有了这篇没有人看的通知。

最重要的，新的博客地址是 https://silverrainz.me/blog/ , tech.silverrainz.me 之后会 redirect
到新地址。

--------------------------------------------------------------------------------

.. isso::
