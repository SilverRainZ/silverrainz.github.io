:Last Update: 2021-02-25

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

**华南农业大学**
    软件工程，2013 年 9 月 - 2017 年 5 月

**造型实验室**
    古典素描，2020 年 6 月 - 2021 年 6 月

:fa:`briefcase` 从业经历
========================

**自由软件基金会 & 谷歌**
    GSoC Student、GNU Hurd 开发者，2016 年

**北京长亭科技有限公司**
    实习研发工程师，2016 年

**北京长亭科技有限公司**
    研发工程师，2017 年 -- 2020 年

:fa:`code` 项目经历
===================

The OS67 Kernel [#]_
--------------------

:时间: 2014 年 10 月 -- 2015 年 10 月
:类型: 个人开源项目
:角色: 作者、维护者
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
:角色: 作者、维护者
:技术栈: C、GTK、Linux Desktop

现代化的跨平台 IRC 客户端, 基于 GTK 和 GLib 开发。

IRC 是一种古老的，基于文本的聊天协议，在开源社区中广泛使用。
Srain 于致力于让 IRC 用户拥有更好的聊天体验。

XATTR Support for GNU/Hurd [#]_
-------------------------------

:时间: 2016 年 5 月 -- 2016 年 9 月
:类型: 社区开源项目
:技术栈: C、Hurd、文件系统
:角色: 实习开发者

这是 2016 年的谷歌编程之夏（Google Summber of Code）的其中一个 proposal，
为 GNU/Hurd 的 ext2 文件系统增加扩展文件属性（Extended File Attribute）的特性。
我作为 GSoC Student 顺利地完成了该项目，相关的代码 [#]_ 已并入上游。

高性能流量转发服务器 SN*****r
-----------------------------

:时间: 2016 年
:类型: 商业项目
:技术栈: C、Linux、Netwoking
:角色: 实习开发者

结构化日志统计平台 Ma**o
------------------------

:时间: 2017 年 -- 2020 年
:类型: 商业项目
:技术栈: Golang、Concurrency
:角色: 开发者、维护者

Lua 插件平台 L*g
-----------------

:时间: 2017 年 -- 2020 年
:类型: 商业项目
:技术栈: Golang、Lua
:角色: 开发者、维护者

实时流处理框架 P****er
----------------------

:时间: 2018 年 -- 2020 年
:类型: 商业项目
:技术栈: Golang, SQL、Concurrency、Streaming Processing
:角色: 作者、维护者

Sphinx Notes [#]_
-----------------

:时间: 2020 年 5 月 -- 至今
:类型: 个人开源项目
:技术栈: Python、restructuredText、Linux、LilyPond、Jinja2
:角色: 作者、维护者

其他项目
--------

**LABots** [#]_ 
    基于 Tornado 实现的简洁，热更新的 IRC 机器人框架

TODO

:fa:`cogs` 技能
===============

**语言**
    | 熟练使用 C、Golang、Python
    | 有 x86 汇编、Java、C++、Lua、Rust、Pascal、Ruby 的小型项目编写经验
    | 对 Scheme、Haskell 有一定了解

**框架**
    | 熟悉 Linux 下的 C 编程，熟悉 GLib/GTK 函数库
    | 有 Flask、Tornado 库的使用经验
    | 对 C/C++ 程序的逆向分析有一定了解，能使用 OllyDBG、IDA 等工具

**工具**
    | 熟悉 Makefile、Meson 构建系统，有 AutoTools、CMake、Bazel 的使用经验
    | 熟悉以 Git 作为 CVS 的协作开发流程
    | 熟练使用 Sphinx 文档生成工具，熟悉 Sphinx 扩展开发

**其他**
    | 熟悉开源社区工作流程
    | 拥有中小型项目长期维护经验
    | 能适应阅读、编写英文技术文档

:fa:`users` 开源活动
====================

Linux 相关
----------

**Arch Linux 中国社区** [#]_
    2016 年至今，作为活跃成员，一直为中国社区软件仓库维护软件包 100 余个，
    提交数量排名 #14（截至 2021-02-18） [#]_

**Arch Linux User Repository**
    AUR 是 Arch Linux 用户驱动的软件仓库，是官方仓库的重要补充。 作为活跃用户，
    在 AUR 维护软件包 20 余个 [#]_ 。历史上亦维护过常用但尚未被官方收录的软件，
    例如：jekyll, vim-fcitx, ccls, gtk4 等。

IRC 相关
--------

**Srain IRC Client**
    作为作者和维护者，从 2016 年至 2021 年，一直持续开发和维护项目， 
    截至 2021-02-25，五年间：

    - 新增代码 153,355 行，删除代码 117,419 行，当前仓库代码约 20,000 loc
    - 发布了 23 个版本
    - 建立了 163 个 Issue
    - 合并了来自 19 个社区开发者的 144 个 Pull Request
    - 被 AUR、AOSC、DragonFly BSD、Fedora、FreeBSD、Flatpak、Guix、
      Gentoo overlay GURU、OpenBSD、OpenMandriva、openSUSE、NetBSD、Void Linux 
      共计被 13 个 \*nix 发行版的软件仓库收录

**Bug fixes**
    - 为著名 IRC 客户端 Hexchat 修复 Bug [#]_
    - 为著名 IRC 客户端 irssi 修复 Bug [#]_

Golang 相关
-----------

**The Go Language**
    - 修复标准库 ``text/scanner`` 中一处 BUG [#]_
    - 修复 ``go vet`` 中一处错误的逃逸分析 [#]_
    - 补充 ``go build`` 时一个缺失的 linker flag [#]_

**fasthttp**
    为 HTTP 库 fasthttp 修复 BUG [#]_

**Read The Docs**
    Read The Docs 社区有计划使用 Sphinx 来生成静态的 Golang 接口文档
    （而非动态的 GoDoc），用于生成文档的配套工具还处在非常早期的阶段，
    我根据自己的需要做了一些改进 [#]_ 。

其他
----

- 维护 PNMixer [#]_ 的中文翻译
- 为书籍 :book:`Haskell 趣学指南` 全书校正代码格式 [#]_
- 为开源游戏 DDNet 修复 BUG [#]_

:fa:`info` 其他
===============

专利
----

- Web 应用防火墙系统及计算机存储介质 [#]_
- 一种 Web 应用防火墙自定义扩展功能的方法、装置、系统及电子设备 [#]_
- 一种实时数据处理方法及装置 [#]_

:fa:`external-link-alt` 脚注
============================

.. [#] https://github.com/SilverRainZ/OS67
.. [#] https://pdos.csail.mit.edu/6.828/2020/xv6.html
.. [#] https://srain.im
.. [#] https://summerofcode.withgoogle.com/archive/2016/projects/5786848613892096
.. [#] https://git.sceen.net/hurd/hurd.git/commit/?id=6ebebc80de3dfc7ada3a69d609f00088c2143be3
.. [#] https://github.com/sphinx-notes
.. [#] | LABots https://github.com/SilverRainZ/labots
       | 基于 LABots 实现的机器人 https://github.com/SilverRainZ/bots
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
.. [#] CN109889530B
.. [#] CN111158683A
.. [#] CN110334117A
