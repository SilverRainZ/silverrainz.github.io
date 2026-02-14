========
关于本站
========

署名-相同方式共享
=================

本站内容均在 |cc-badge| 署名-相同方式共享（CC BY-SA）协议下发布，完整协议请见：
:download:`/_assets/LICENSE` 。

.. |cc-badge| image:: https://licensebuttons.net/l/by-sa/4.0/88x31.png
   :target: http://creativecommons.org/licenses/by-sa/4.0/
   :height: 1.5em

Sphinx + Sphinx Notes
=====================

本站由 Sphinx__ |sphinx-badge| + `Sphinx Notes`__ |sphinx-notes-badge| 强力驱动，
源码托管于 :ghrepo:`SilverRainZ/bullet`。

.. |sphinx-badge| image:: /_assets/sphinx.webp
   :target: https://www.sphinx-doc.org
   :height: 2em

.. |sphinx-notes-badge| image:: /_assets/sphinxnotes.webp
   :target: https://sphinx.silverrainz.me/
   :height: 2em

__ https://www.sphinx-doc.org
__ https://sphinx.silverrainz.me/

变更记录
========

.. container:: timeline

   .. card:: :octicon:`calendar` 2026-02
      :width: 50%
      :margin: 0 2 auto 0
      :class-card: surface

      得益于 :pypi:`sphinxnotes-render` 的完成，现在 :pypi:`sphinxnotes-any`
      支持 ``.. xxx+embed::`` 来嵌入一个对象了。

      以此为契机，更新了首页，分为：画廊、博客、笔记 三个大类。

      .. seealso:: `2025 TODOs`__ 终于完成了……

         __ https://github.com/SilverRainZ/silverrainz.github.io/issues/34

   .. card:: :octicon:`calendar` 2025-10
      :width: 50%
      :margin: 0 2 0 auto
      :class-card: surface

      换上了 :ghuser:`lepture` 的主题 `Shibuya <https://shibuya.lepture.com/>`_，看上去现代了很多。
      但不支持我现在用的 :pypi:`ABlog`，花了一些时间做了点适配工作：
      `sunpy/ablog#310 <https://github.com/sunpy/ablog/issues/310>`_

   .. card:: :octicon:`calendar` 2025-07
      :width: 50%
      :margin: 0 2 auto 0
      :class-card: surface

      所有二进制内容（图片、PDF、演示文稿）从仓库里移除（尚未 ``git filter-repo``），
      放到单独的私有仓库中。

      特别地，:doc:`画作 </collections/art-works/index>` 现在通过 latree
      （我的统一文件树）的 artwork 组件，指定 ID 便可获取。

   .. card:: :octicon:`calendar` 2025-06
      :width: 50%
      :margin: 0 2 0 auto
      :class-card: surface

      重写 `简历 </resume>`_，新增英文版本。
      因为需要 LaTeX build 所以拆分到单独仓库 :ghrepo:`SilverRainZ/resume`。

   .. card:: :octicon:`calendar` 2022-02
      :width: 50%
      :margin: 0 2 auto 0
      :class-card: surface

      换了个新主题 :pypi:`sphinx-book-theme`，侧边栏支持固定，兼容 ABlog，移动端体验好多了。
      主题自带 local-toc 支持，因此文档里的 `.. contents::` 指令没用了，写了个扩展 :pypi:`sphinxnotes-mock` 来屏蔽它。

   .. card:: :octicon:`calendar` 2021-03
      :width: 50%
      :margin: 0 2 0 auto
      :class-card: surface

      - 扩展 :pypi:`sphinxnotes-isso` 投入使用，用了阿哥的腾讯云机器，重新启用 Isso 评论
      - 扩展 :pypi:`sphinxnotes.snippet` 投入使用

   .. card:: :octicon:`calendar` 2021-02
      :width: 50%
      :margin: 0 2 auto 0
      :class-card: surface

      :del:`为方便国内访问，建立 Gitee 镜像，地址为： https://silverrainz.gitee.io`

      .. seealso:: Gitee Pages 因不可抗力潦草下线：`关于GiteePages无法启动和更新的看过来！ · Issue #I9L5FJ · 开源中国/Gitee Feedback - Gitee.com <https://gitee.com/oschina/git-osc/issues/I9L5FJ>`_

   .. card:: :octicon:`calendar` 2020-12
      :width: 50%
      :margin: 0 2 0 auto
      :class-card: surface

      - 将博客迁移到 Sphinx + ABlog，详见 :doc:`/blog/migrate-to-sphinx`
      - 扩展 :pypi:`sphinxnotes.any` 投入使用

   .. card:: :octicon:`calendar` 2020-04
      :width: 50%
      :margin: 0 2 auto 0
      :class-card: surface

      评论框维护成本高且各有限制，弃用之，交流请发邮件。

   .. card:: :octicon:`calendar` 2017-06
      :width: 50%
      :margin: 0 2 0 auto
      :class-card: surface

      多说停止服务，评论系统切换到 Isso，之前的评论数据已迁移。参见文章：:doc:`/blog/switch-from-duoshuo-to-isso`

   .. card:: :octicon:`calendar` 2017-04
      :width: 50%
      :margin: 0 2 auto 0
      :class-card: surface

      借助 CloudFlare 缓存了 silverrainz.me 和 tech.silverrainz.me，同时启用了 HTTPS。

   .. card:: :octicon:`calendar` 2017-03
      :width: 50%
      :margin: 0 2 0 auto
      :class-card: surface

      将个人笔记 notes.silverrainz.me 从 Gitbook 迁移到 Sphinx，
      托管于 Read The Docs，参见文章： 用 Sphinx + reStructuredText 构建笔记系统。

   .. card:: :octicon:`calendar` 2017-01
      :width: 50%
      :margin: 0 2 auto 0
      :class-card: surface

      域名变更为 silverrainz.me，博客地址亦变更为 tech.silverrainz.me，
      域名 lastavengers.me 将于 2017 年 8 月失效。

   .. card:: :octicon:`calendar` 2016-08
      :width: 50%
      :margin: 0 2 0 auto
      :class-card: surface

      - Markdown 引擎从 Rdiscount 切换到 Kramdown，
      - 启用了域名 lastavengers.me 作为个人主页，博客地址变更为 tech.lastavengers.me
      - 移除了 Project 页

   .. card:: :octicon:`calendar` 2015-11 ~ 2016-01
      :width: 50%
      :margin: 0 2 auto 0
      :class-card: surface

      博客升级，增加了 Project，About 页面，支持点击浏览大图，加入了 font-awesome。

   .. card:: :octicon:`calendar` 2015-03
      :width: 50%
      :margin: 0 2 0 auto
      :class-card: surface

      使用 Jekyll 搭建新博客，托管在 Github 上。

   .. card:: :octicon:`calendar` 2014-01
      :width: 50%
      :margin: 0 2 auto 0
      :class-card: surface

      注册 博客园_ 。

   .. _博客园: https://www.cnblogs.com/lastavengers/
