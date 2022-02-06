====
本站
====

署名-相同方式共享
=================

本站内容均在 |cc-badge| 署名-相同方式共享（CC BY-SA）协议下发布，完整协议请见：
:download:`/LICENSE` 。

.. |cc-badge| image:: https://licensebuttons.net/l/by-sa/4.0/88x31.png
   :target: http://creativecommons.org/licenses/by-sa/4.0/
   :height: 1.5em

Sphinx + Sphinx Notes
=====================

本站由 Sphinx |sphinx-badge| + Sphinx Notes |sphinx-notes-badge| 强力驱动。

.. |sphinx-badge| image:: /_images/sphinx.png
   :target: https://www.sphinx-doc.org
   :height: 4em

.. |sphinx-notes-badge| image:: /_static/logo.png
   :target: https://github.com/sphinx-notes/
   :height: 4em

变更记录
========

2022-02
   换了个新主题 :pypi:`sphinx-book-theme`，侧边栏支持固定，兼容 ABlog，移动端体验好多了。
   主题自带 local-toc 支持，因此文档里的 `.. contents::` 指令没用了，写了个扩展 :pypi:`sphinxnotes-mock` 来屏蔽它。

2021-03
  - 扩展 :pypi:`sphinxnotes-isso` 投入使用，用了阿哥的腾讯云机器，重新启用 Isso 评论
  - 扩展 :pypi:`sphinxnotes.snippet` 投入使用

2021-02
   为方便国内访问，建立 Gitee 镜像，地址为： https://silverrainz.gitee.io

2020-12
    - 将博客迁移到 Sphinx + ABlog，详见 :doc:`/blog/migrate-to-sphinx`
    - 扩展 :pypi:`sphinxnotes.any` 投入使用

2020-04
    评论框维护成本高且各有限制，弃用之，交流请发邮件。

2017-06
    多说停止服务，评论系统切换到 Isso，之前的评论数据已迁移。参见文章：
    :doc:`/blog/switch-from-duoshuo-to-isso`

2017-04
    借助 CloudFlare 缓存了 silverrainz.me 和 tech.silverrainz.me，同时启用了 HTTPS。

2017-03
    将个人笔记 notes.silverrainz.me 从 Gitbook 迁移到 Sphinx，
    托管于 Read The Docs，参见文章： 用 Sphinx + reStructuredText 构建笔记系统。

2017-01
    域名变更为 silverrainz.me，博客地址亦变更为 tech.silverrainz.me，
    域名 lastavengers.me 将于 2017 年 8 月失效。

2016-08
    Markdown 引擎从 Rdiscount 切换到 Kramdown，
    启用了域名 lastavengers.me 作为个人主页，博客地址变更为 tech.lastavengers.me
    移除了 Project 页

2015-11 ~ 2016-01
    博客升级，增加了 Project，About 页面，支持点击浏览大图，加入了 font-awesome。

2015-03
    使用 Jekyll 搭建新博客， 托管在 Github 上。

2014-01
    注册 博客园_ 。

.. _博客园: https://www.cnblogs.com/lastavengers/
