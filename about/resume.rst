:orphan:
:nosearch:
:Last Update: 2021-05-28

======
张盛宇
======

.. centered::
   :fa:`envelope` :email:`job@silverrainz.me` | :fa:`phone` (+86)176******** | :fa:`rss` `silverrainz.me`_

.. _silverrainz.me: https://silverrainz.me

:fa:`briefcase` 从业经历
========================

:字节跳动:  基础库研发工程师，2021 年 ～ 2024 年
:长亭科技:  系统研发工程师，2017 年 ～ 2020 年
:长亭科技:  实习研发工程师，2016 年
:Google Summer of Code: GNU Hurd developer，2016 年

:fa:`graduation-cap` 教育背景
=============================

:造型实验室:      古典素描、当代艺术创作，2024 年 ～ 2025 年
:造型实验室:      古典素描，2020 年 ～ 2021 年
:华南农业大学:    软件工程，2013 年 ～ 2017 年

:fa:`search` 关注领域
=====================

分布式系统 | 流处理系统 | 自由桌面软件 | 操作系统内核 | 开发效率工具

:fa:`cogs` 专业技能
===================

语言
    | 熟练使用 C、Golang、Python
    | 有 x86 汇编、Java、C++、Lua、Rust、Pascal、Ruby 的小型项目编写经验
    | 对 Scheme、Haskell 有一定了解

工具
    | 熟悉现代 Linux 发行版（尤其是 Arch Linux）的操作，了解其工作原理
    | 熟悉 Makefile、Meson 构建系统，有 AutoTools、CMake、Bazel 的使用经验
    | 熟悉以 Git 作为 CVS 的协作开发流程
    | 熟练使用 Sphinx 文档生成工具，熟悉 Sphinx 扩展开发
    | 对 C/C++ 程序的逆向分析有一定了解，能使用 OllyDBG、IDA 等工具

其他
    | 熟悉 GLib/GTK 函数库
    | 熟悉开源社区工作流程
    | 拥有中小型项目长期维护经验
    | 能适应阅读、编写英文技术文档

:fa:`code` 项目经历
===================

The OS67 Kernel [#]_
--------------------

:时间: 2014 年 10 月 -- 2015 年 10 月
:类型: 个人开源项目
:角色: 作者、维护者
:技术栈: C、汇编、操作系统

类 Unix 的玩具操作系统内核，基本上是 MIT 6.628 的劣化版，功能如下：

- 基础设备（VGA、PS/2 键盘、IDE 磁盘）的驱动
- 栈式物理内存管理和虚拟内存映射
- Minix v1 文件系统
- 基于 fork/exec 实现的多进程
- 常见的系统调用实现共 20 个
- 类 UNIX 的文件描述符实现 IO 重定向
- 简单的管道

Srain IRC Client [#]_
---------------------

:时间: 2016 年 1 月 -- 至今
:类型: 个人开源项目
:角色: 作者、维护者
:技术栈: C、GTK、Linux Desktop

IRC 是一种古老的，基于文本的聊天协议，在开源社区中广泛使用。
Srain 尝试为古老的 IRC 协议套上了「现代」的外壳

- 基于 C 语言和 GLib/GTK 函数库开发，支持 Linux/BSD/macOS/Windows 多平台
- 支持 :rfc:`1459` 和 :rfc:`2812` ，支持部分 IRCv3 特性
- 提供了完整的命令系统，支持用键盘完成绝大部分操作
- 支持预览公开图床的图片
- 支持优化显示来自其他 IM 的消息 [#]_
- 支持插件系统

XATTR Support for GNU/Hurd [#]_
-------------------------------

:时间: 2016 年 5 月 -- 2016 年 9 月
:类型: 社区开源项目
:技术栈: C、Hurd、文件系统
:角色: 实习开发者

这是 2016 年的谷歌编程之夏（Google Summber of Code）的其中一个 proposal，
为 GNU/Hurd 的 ext2 文件系统增加扩展文件属性（Extended File Attribute）的特性。
我作为 GSoC Student 顺利地完成了该项目，相关的代码 [#]_ 已并入上游。

这篇文章 [#]_ 详述了我所做的工作。

高性能流量转发服务器 SN*****r
-----------------------------

:时间: 2016 年
:类型: 商业项目
:技术栈: C、Linux、高并发
:角色: 实习开发者

该项目采用了类似 Nginx 的 Master/Slave/Monitor 多进程模型和类似的 Nginx 的模块组织方式。

我作为实习生在其中负责了一些统计功能的开发。后基于 :manpage:`MQ_OVERVIEW(7)`
开发了一个进程间消息队列模块，并在此基础上实现了 so library 的 hot reloading。

分布式结构化日志统计平台 Ma**o
------------------------------

:时间: 2017 年 -- 2020 年
:类型: 商业项目
:技术栈: Golang、高吞吐、分布式
:角色: 开发者、维护者

该项目是 Golang 在公司产品中的第一次尝试，从依赖管理、依赖选型、代码组织、
文档维护都经过了多次的试错和修正，成为公司内部 Golang 项目的首选模板。

该项目依托于 Golang 的 Frist-Class Coroutine 支持，实现了高吞吐的日志处理。
大部分代码为业务逻辑，不便展开。

Lua 插件平台 L*g
----------------

:时间: 2017 年 -- 2020 年
:类型: 商业项目
:技术栈: Golang、Lua
:角色: 早期开发者、维护者

社区没有一个好用的 LuaJIT go binding，唯一能用的 :ghrepo:`aarzilli/golua`
的作者对 Lua 缺乏足够的了解，为了避免受限于开源库，也为了更好的和公司产品集成，
我们发起了这个项目。

本质上这依然是一个 LuaJIT 的 go binding，但有如下特性：

- 提供了更多的操作 Lua stack 和数据的 helper
- 允许细粒度地控制 Lua 标准库的加载
- 支持用 Go 实现 Lua module
- 深度集成了 Lua coroutine 和 Goroutine ，最大化利用了 CPU 时间

分布式实时流处理框架 P****er
----------------------------

:时间: 2018 年 -- 2020 年
:类型: 商业项目
:技术栈: Golang, 分布式、流处理、SQL、编译器前端
:角色: 作者、维护者

一个轻量（< 30,000 loc）的，非侵入式的分布式实时流处理框架，
不少设计思路源自 Flink 和 TiDB，但因使用场景不同又有所区别。

- 文档覆盖率 100%
- 完全非侵入式的设计，纯 Golang 实现，不依赖外部服务
- 完全模块化的实现，各模块之间层次清晰，组织良好
- 在多个层次（数据类型、表达式、SQL Scalar 函数、聚合函数、窗口函数、算子）上均保持了扩展性
- 支持服务发现，支持动态增删节点，允许任意节点下线、支持脑裂自动恢复（有数据丢失）
- 支持滑动、滚动时间窗口，支持超大滑动时间窗口
- 支持类似 Flink Streaming SQL 的 SQL 语法，支持 JSON 类型，实验性支持 JOIN 和子查询
- 支持任务管理，支持调试用途的任务可视化

Sphinx Notes [#]_
-----------------

:时间: 2020 年 5 月 -- 至今
:类型: 个人开源项目
:技术栈: Python、restructuredText、Sphinx、LilyPond、Jinja2、NLP
:角色: 作者、维护者

Sphinx 被我来建立我的个人信息管理系统（Personal Information Management System），
因此为了满足我的需求，我建立了 Sphinx Notes 组织并编写了如下项目：

sphinxnotes-pages [#]_
  构建 Sphinx 文档并 push 到 gitpages 的 GitHub Action

sphinxnotes-lilypond [#]_
  开源音乐打谱软件 LilyPond 的 Sphinx 扩展，允许用户在文档中使用 LilyPond 编写
  乐谱

sphinxnotes-any [#]_
  一个用以描述 *任何* 对象的 Sphinx Domain，可以认为该插件允许用户通过
  写文档的方式构建简单的数据库

sphinxnotes-strike [#]_
  restructuredText 标准中不包含删除线（Strikethrough）的语法，插件提供了该支持

sphinxnotes-snippet [#]_
  非侵入式的文档片段管理工具，通过一些简单的策略对判断建立索引，允许用户通过
  fzf/fzy/skim 等filter 快速筛选出想要的信息

sphinxnotes-isso [#]_
    开源评论系统 Isso 的 Sphinx 扩展

:fa:`users` 开源活动
====================

Linux 相关
----------

Arch Linux 中国社区 [#]_
  2016 年至今，作为活跃成员，一直为中国社区软件仓库维护软件包 100 余个，
  提交数量排名 #14（截至 2021-02-18） [#]_

Arch Linux User Repository
  AUR 是 Arch Linux 用户驱动的软件仓库，是官方仓库的重要补充。 作为活跃用户，
  在 AUR 维护软件包 20 余个 [#]_ 。其中包括尚未被官方收录的流行软件，例如：
  jekyll, vim-fcitx, ccls, gtk4 等。

IRC 相关
--------

Srain IRC Client
  作为作者和维护者，从 2016 年至 2021 年，一直持续开发和维护项目，
  截至 2021-02-25，五年间：

  - 新增代码 153,355 行，删除代码 117,419 行，当前仓库代码约 20,000 loc
  - 发布了 23 个版本
  - 建立了 163 个 Issue
  - 合并了来自 19 个社区开发者的 144 个 Pull Request
  - 被 AUR、AOSC、DragonFly BSD、Fedora、FreeBSD、Flatpak、Guix、
    Gentoo overlay GURU、OpenBSD、OpenMandriva、openSUSE、NetBSD、Void Linux
    共计被 13 个 \*nix 发行版的软件仓库收录

Bug fixes
  - 为著名 IRC 客户端 Hexchat 修复 Bug [#]_
  - 为著名 IRC 客户端 irssi 修复 Bug [#]_

Golang 相关
-----------

The Go Language
  - 修复标准库 `text/scanner` 中一处 BUG [#]_
  - 修复 `go vet` 中一处错误的逃逸分析 [#]_
  - 补充 `go build` 时一个缺失的 linker flag [#]_

fasthttp
  为 HTTP 库 fasthttp 修复 BUG [#]_

Read The Docs
    Read The Docs 社区有计划使用 Sphinx Autodoc 来生成静态的 Golang 库文档
    （而非动态的 GoDoc），我为其实现了一部分功能 [#]_ 。

其他
----

- 维护 PNMixer [#]_ 的中文翻译
- 为书籍 :book:`Haskell 趣学指南` 全书校正代码格式 [#]_
- 为开源游戏 DDNet 修复 BUG [#]_
- 为中国科学技术大学 Linux 用户协会（USTCLUG）设计社团 LOGO [#]_
- 为知名 C/C++ Language Server 项目 ccls 设计 LOGO [#]_

:fa:`info` 其他
===============

文章
----

- 《我如何用Sphinx 建立笔记系统》系列文章 [#]_
- 《Srain - Modern IRC Client written in GTK》 [#]_
- 《编写便于打包的 Makefile》 [#]_
- 《2015 华山杯 CTF Reverse 300》 [#]_
- 《用户态进程的简单实现及调度(一)》 [#]_
- 《Minix v1 文件系统的实现》 [#]_

专利
----

- Web 应用防火墙系统及计算机存储介质 [#]_
- 一种 Web 应用防火墙自定义扩展功能的方法、装置、系统及电子设备 [#]_
- 一种实时数据处理方法及装置 [#]_

:fa:`external-link-alt` 脚注
============================

.. [#] https://github.com/SilverRainZ/OS67
.. [#] https://srain.silverrainz.me
.. [#] https://srain.silverrainz.me/faq.html#what-is-relay-message-transform
.. [#] https://summerofcode.withgoogle.com/archive/2016/projects/5786848613892096
.. [#] https://git.sceen.net/hurd/hurd.git/commit/?id=6ebebc80de3dfc7ada3a69d609f00088c2143be3
.. [#] https://silverrainz.gitee.io//blog/gsoc-2016-sum-up.html#id12
.. [#] https://github.com/sphinx-notes
.. [#] https://github.com/sphinx-notes/pages
.. [#] https://github.com/sphinx-notes/lilypond
.. [#] https://github.com/sphinx-notes/any
.. [#] https://github.com/sphinx-notes/strike
.. [#] https://github.com/sphinx-notes/snippet
.. [#] https://github.com/sphinx-notes/isso
.. [#] https://www.archlinuxcn.org
.. [#] https://github.com/archlinuxcn/repo/graphs/contributors
.. [#] https://aur.archlinux.org/packages/?K=SilverRainZ&SeB=m
.. [#] https://github.com/hexchat/hexchat/pull/1969
.. [#] https://github.com/irssi/irssi/pull/742
.. [#] https://go-review.googlesource.com/#/c/go/+/112037
.. [#] https://go-review.googlesource.com/c/tools/+/175617
.. [#] https://go-review.googlesource.com/c/go/+/210657
.. [#] https://github.com/valyala/fasthttp/pull/713
.. [#] | https://github.com/readthedocs/sphinx-autoapi/pull/176
       | https://github.com/readthedocs/godocjson/pull/13
       | https://github.com/readthedocs/godocjson/pull/12
.. [#] https://github.com/nicklan/pnmixer
.. [#] https://github.com/MnO2/learnyouahaskell-zh/pull/60
.. [#] https://github.com/ddnet/ddnet/pull/1390
.. [#] https://lug.ustc.edu.cn/news/2018/09/lug-logo-collect-result/
.. [#] https://github.com/MaskRay/ccls/issues/628
.. [#] https://silverrainz.gitee.io/blog/category/%E6%88%91%E5%A6%82%E4%BD%95%E7%94%A8-sphinx-%E5%BB%BA%E7%AB%8B%E7%AC%94%E8%AE%B0%E7%B3%BB%E7%BB%9F.html
.. [#] https://srain.silverrainz.me/introducing-srain.html
.. [#] https://silverrainz.gitee.io/blog/practical-makefile-for-packaging.html
.. [#] https://silverrainz.gitee.io/blog/2015-huashangctf-re300.html
.. [#] https://silverrainz.gitee.io/blog/process-scheduler-1.html
.. [#] https://silverrainz.gitee.io/blog/minix-v1-file-system.html
.. [#] CN109889530B
.. [#] CN111158683A
.. [#] CN110334117A
