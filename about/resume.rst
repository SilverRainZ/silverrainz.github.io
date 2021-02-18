.. rst-class:: center-title

======
张盛宇
======

.. centered::
   :fa:`envelope` :email:`job@silverrainz.me` |
   :fa:`phone` (+86)176******** |
   :fa:`rss` `silverrainz.me`_

.. _silverrainz.me: https://silverrainz.me

:fa:`graduation-cap` 教育背景
=============================

- **华南农业大学**\ ，软件工程，2013 年 9 月 - 2017 年 5 月
- **造型实验室**\ ，古典素描，2020 年 6 月 - 2021 年 6 月

:fa:`briefcase` 从业经历
========================

:fa:`code` 项目经历
===================

The OS67 Kernel [#]_
--------------------

:时间: 2014 年 10 月 -- 2015 年 10 月
:类型: 个人开源项目
:技术栈: C、汇编、操作系统

类 Unix 的玩具操作系统内核，基本上是 MIT 6.628\ [#]_ 的劣化版，功能如下：

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
:技术栈: C、GTK、Linux Desktop

现代化的 IRC 客户端, IRC 是一种古老的，基于文本的聊天协议，在开源社区中广泛使用。
Srain 致力于让 IRC 用户拥有更好的聊天体验：

- 实现了 RFC 1459，实现了 IRC 客户端的基本功能
- 美观的界面，可自定义皮肤
- 支持从 URL 预览图片（IRC 协议不支持发送图片，只能发送图片的 URL）
- 改善转发机器人（Relaybot）消息的显示效果

  TODO

XATTR Support for GNU/Hurd [#]_
-------------------------------

:时间: 2016 年 5 月 -- 2016 年 9 月
:类型: 社区开源项目
:技术栈: C、Hurd、文件系统

这是 2016 年的谷歌编程之夏（Google Summber of Code）的其中一个 proposal，
为 GNU/Hurd 的 ext2 文件系统增加扩展文件属性（Extended File Attribute）的特性。
我作为 GSoC Student 顺利地完成了该项目，相关的代码 [#]_ 已并入上游。

IRC Bot Framework [#]_
----------------------

:时间: 2016 年 5 月 -- 至今
:类型: 个人开源项目
:技术栈: Python

基于 ``Tornado.IOLoop`` 实现的简洁，热更新的 IRC 机器人框架。后部分迁移到 asyncio。

TODO:

- snserver
- mario
- plumber
- sphinx
- golang

更多：https://github.com/SilverRainZ?tab=repositories

:fa:`cogs` 技能
===============

- 熟练使用 C
- 熟悉 GLib/GTK 函数库
- 熟悉操作系统原理
- 熟悉 Linux 下的 C 语言编程，了解 Linux 下的通用软件打包规范及原理
- 能够使用 汇编、Bash、Python、Java、Rust 等编程语言
- 对 Scheme、Haskell 稍有了解
- 对 C/C++ 程序的逆向分析有所了解，能使用 OllyDBG、IDA 等工具
- 英语 CET-4，能适应阅读英文技术文献

:fa:`users` 开源活动
====================

Arch Linux 社区
---------------

Arch Linux 中国社区 [#]_
    2016 年至今，作为活跃成员，一直为中国社区软件仓库维护软件包 100 余个，
    提交数量排名 #14（截至 2021-02-18） [#]_

Arch Linux User Repository
    AUR 是 Arch Linux 用户驱动的软件仓库，是官方仓库的重要补充。 作为活跃用户，
    在 AUR 维护软件包 20 余个 [#]_ 。历史上亦维护过常用但尚未被官方收录的软件，
    例如： jekyll, vim-fcitx, ccls, gtk4 等。

Internet Relay Chat
--------------------
Srain IRC Client
    维护
    - 为著名 IRC 客户端 Hexchat 修复 Bug}
  {https://github.com/hexchat/hexchat/pull/1969}{

Sphinx Documentation and Extension
    Sphinx Notes


The Go Language
---------------

在工作之余为 Go 的编译器周边工具

fasthttp
    为知名 HTTP 库 fasthttp 修复 BUG

Linux Desktop
  https://git.reviewboard.kde.org/r/127323/ 为 KDE 社区的 breeze-gtk 项目修复 Bug

文档和翻译
    - 为 PNMixer 贡献中文翻译 [#]_
    - 为开源书籍 :book:`Haskell 趣学指南` 全书校正代码格式 [#]_

:fa:`info` 其他
===============

:fa:`external-link-alt` 脚注
============================

.. [#] https://github.com/SilverRainZ/OS67
.. [#] https://pdos.csail.mit.edu/6.828/2020/xv6.html
.. [#] https://srain.im
.. [#] https://summerofcode.withgoogle.com/archive/2016/projects/5786848613892096
.. [#] https://git.sceen.net/hurd/hurd.git/commit/?id=6ebebc80de3dfc7ada3a69d609f00088c2143be3
.. [#] - https://github.com/SilverRainZ/labots
       - https://github.com/SilverRainZ/bots
.. [#] https://github.com/nicklan/pnmixer/commits?author=SilverRainZ
.. [#] https://github.com/MnO2/learnyouahaskell-zh
.. [#] https://www.archlinuxcn.org
.. [#] https://github.com/archlinuxcn/repo/graphs/contributors
.. [#] https://aur.archlinux.org/packages/?K=SilverRainZ&SeB=m


