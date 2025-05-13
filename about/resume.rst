======
张盛宇
======

.. centered:: job@silverrainz.me | (+86)176******** | `silverrainz.me`__

__ https://silverrainz.me

从业经历
========

:字节跳动:              基础库研发工程师，2021 ~ 2024
:长亭科技:              系统研发工程师，2017 ~ 2020
:长亭科技:              实习研发工程师，2016
:Google Summer of Code: GNU Hurd developer，2016

教育经历
========

:造型实验室:   古典素描、当代艺术创作，2024 ~ 2025
:造型实验室:   古典素描，2020 ~ 2021
:华南农业大学: 软件工程，2013 ~ 2017

专业技能
========

基础技能
   :编程语言:  熟练使用 C、Golang、Python，Rust，能阅读和调试 i386/x86_64 汇编
   :开发工具:  熟练使用 Shell、Git、(Neo)Vim、Makefile、SystemD、Docker
   :线上运维:  熟练使用各大 Linux 发行版，能进行简单的维护和监控
   :文书处理:  重视文档建设，能熟练阅读、编写英文技术文档，熟悉 Sphinx、Office 等文档工具
   :社区建设:  熟悉开源社区工作流程，拥有较丰富的中小型项目立项、发布、推广、维护经验

细分领域
   :操作系统: 了解操作系统内核基础知识，有小型操作系统内核开发经验
   :分布式流处理: 熟悉流处理基础知识，主导开发过轻量级的流处理框架并投产
   :性能优化: 熟悉 Golang 程序性能的基准测试和优化手段
   :Linux Desktop: 能熟练使用 GTK 框架开发原生 Linux 桌面应用程序

项目经历
========

Go 性能平台 - 字节跳动 / 协作开发 / 2022 ~ 2024
   服务内部数万微服务的一站式性能优化平台，基于线上采样火焰图的火焰图衍生出各种功能。

   我的工作：

   :代码性能分析:    主导开发；动态采样的火焰图 + AST/SSA 级别的静态分析，
                     能诊断出一个服务中有哪些可以优化的代码片段，
                     估算其在生产环境中的开销，并给出改写建议
   :服务稳定性观测:  主导开发；针对内部 Go Runtime 的上线各阶段进行稳定性检测
   :离线计算:        参与开发；数万微服务线上采集的火焰图的拆分、存储、计算和重组

Go 泛型基础库 - 字节跳动 / 主导开发 / 2022 ~ 2023
   基于泛型的工具型 Golang 基础库。

   设计良好，功能、文档齐全，测试完善，在内部广受好评。在 Go 1.18+ 的内部服务中广泛使用（70%+）。

github.com/bytedance/gopkg - 字节跳动 / 协作开发 / 2021
   字节开源的 Golang 高性能基础库。

   我的工作：新增了一个和 redis zset 行为相同的数据结构，在 Tiktok 部分业务中使用。

github.com/sphinx-notes - 开源项目 / 独立开发 / 2020 ~ now
   用 Python 编写的系列 Sphinx 插件和周边工具。

   包括：GitHub Action、命令行 Fuzzy Finder、LilyPond 乐谱支持、构建加速、类 Obsidian Dataview 的结构化数据定义等。

分布式流处理框架 - 长亭科技 / 主导开发 / 2018 ~ 2020
   一个轻量的分布式实时流处理框架，可以方便地嵌入各种 Golang 程序中。
   参考了 Flink 和 TiDB，根据客户的场景做了针对性的优化。

   - 支持集群化部署；支持服务发现；支持动态伸缩
   - 支持滑动、滚动时间窗口；支持超大滑动时间窗口
   - 支持 Streaming SQL；支持 JSON path；实验性支持 JOIN 和子查询

github.com/SrainApp/srain - 开源项目 / 独立开发 / 2016.01 ~ now
   使用 C 语言 + GTK 框架开发的现代化 IRC 聊天客户端。

   支持 Linux/BSD/macOS/Windows 多系统；全键盘操作；针对 IRC 的若干缺陷做了改良：支持图片预览、支持 Bridge Bot 优化显示。

github.com/SilverRainZ/OS67 - 开源项目 / 独立开发 / 2014.10 ~ 2015.10
   使用 C 语言开发的 Unix-like 玩具操作系统内核，参考了 OSASK、Orange's 和 MIT6.628。

   支持虚拟内存管理、Minix 文件系统、基于 fork/exec 的多线程、用户级系统调用、支持 Shell 和简单的管道。

开源活动
========

Arch Linux
  - 2016 年至今，为 Arch Linux CN Repository 维护软件包 100 余个，提交数量排名 #12
  - 编写并维护 Arch User Repository 软件包 20 余个，其中包括 Jekyll、GTK4 等尚未被官方收录的流行软件

The Go Language
   为 Golang 提交过 7+ commits。

Sphinx Documentation Generator
   为 Sphinx 提交过 6+ commits。

   SphinxNotes 其下的项目被 Microsoft、PHP、Haskell 等知名公司和组织使用。

IRC
   IRC 客户端 Srain 被 Debian、Ubuntu、Fedora 等 10+ Linux 发行版收录。

   为流行客户端 HexChat、Issi 均贡献过代码。

其他
   - 在 GitHub 上获得 1300+ 星标（SilverRainZ 800+、SrainApp 300+、SphinxNotes 100+）
   - 为中科大 Linux 用户协会（USTCLUG）设计社团 LOGO
   - 维护 PNMixer 的中文翻译

专利
====

:CN109889530B: Web 应用防火墙系统及计算机存储介质
:CN111158683A: 一种 Web 应用防火墙自定义扩展功能的方法、装置、系统及电子设备
:CN110334117A: 一种实时数据处理方法及装置
