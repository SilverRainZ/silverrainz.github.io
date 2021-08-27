========================================
 GSoC 2016 小记 - 误打误撞三个月
========================================

.. post:: 2016-09-29
   :tags: GSoC
   :author: LA
   :language: zh_CN
   :category: GSoc 2016

.. hint:: 这是一篇迁移自 Jekyll 的文章，如有格式问题，可到 :ghrepo:`SilverRainZ/bullet` 反馈

这是一篇拖了一个月的流水帐……

谷歌编程之夏（Google Summer of Code/GSoC）是 Google 举办的年度编程活动，
征集学生为开源社区编写代码，时间持续三个月，成功完成项目的学生可以得到 Google 
$5500 的报酬，同时开源社区也能得到 $500 的赞助。


.. image:: /_images/gsoc-2016-proj.png
   :alt: GSoC 2013 Project

我有幸参加了 2016 年的 Google Summoer of Code，为 GNU/Hurd 项目工作并完成预期目标，
在此记录。

.. contents::

从写 Proposal 到放弃
--------------------

三月初的时候在 #archlinux-cn 听 :friend:`quininer` 说今年 Tox
社区要参加 GSoC 并开始招人的事情， :del:`当然也提及了 Tox 去年闹出的一桩事：`
`Current situation of Tox #1379 <https://github.com/irungentoo/toxcore/issues/1379>`_
这时候我才知道 GSoC 的存在。简单在网上搜索了一下，正好大三下学期也基本没课了，
便萌生了要试试的想法。

参与的学生需要在 `Google Summer of Code <http://summerofcode.withgoogle.com/>`_ 上注册，
并寻找你心仪的 organization，并在网站上针对 organization 的某个项目提交提案（Proposal），
这些组织一般都是著名的开源社区，比如 GNU、Linux Fundation、GNOME、KDE、Wine、Apache 等等。
Proposal 用来告诉社区你为什么认为自己能胜任这个项目，将如何做这个项目，以及你的时间安排等，
有些社区会提供一些 proposal 模板，告知你一些必须回答的问题。 一个学生可以提交至多五份提案。

于是开始挑 organization，因为我比较熟悉的语言就只有 C，写过 toy kernel 和 GTK 程序，
因此最后敲定了两个组织： GNU 和 GNOME，前者有 Hurd 内核项目，后者用 GTK 框架写程序，
大概能算是我比较擅长的部分吧。

接着开始在网上找资料写 proposal，上了一下 #hurd 频道打了一下招呼，然后就没有然后了…… 
看到其他人写的 proposal 和网上的描述，开始觉得 GSoC 以我的能力是参加不了的，
于是一字未写，在心里默默跟自己说放弃好了。

到了 3 月 23 号，那天早上不知道为什么突然来了劲儿，决定只报一个项目：
GNU/Hurd 的 `Implement xattr Support <https://www.gnu.org/software/hurd/community/gsoc/project_ideas/xattr.html>`_\ 。
在当天早上把 proposal 写好并马上提交了最终版…… 然后给学生证拍了张照片作为入学证明上传。

3 月 29 号，被邮件告知「Your GSoC 2016 Proof of Enrollment form was rejected because:
not english/missing translation.」，仅仅拍学生证不够，还需要加上写英文说明，
当时我的想法是，反正 proposal 也过不了，于是没搭理邮件。

4 月 7 号，在我没有采取任何行动的情况下，Google 又发邮件说 Proof of Enrollment
已经通过验证了…… :-| 大概是找了华人员工来审核的吧，当时心理暗想 Google
的工作人员真的好负责啊……

再往后，每天跟着舍友去图书馆，写还当时未成型的 `Srain <https://github.com/SilverRainZ/srain>`_\ ，
其间有 GNU 的成员在我的 proposal 上留言评论……我也没去回复，
渐渐把这件事忘记了。

Welcome to GSoC 2016!
---------------------

4 月 23 号，刚起床看到有封邮件，

..

   GSoC 2016: Congratulations, your proposal with GNU Project has been accepted!


觉得有点激动又难以置信，还特意发了篇\ :doc:`博客 </blog/gsoc-2016>`\ 得瑟了一下。

接下来就根据邮件的要求：


* 看\ `学生须知 <https://developers.google.com/open-source/gsoc/help/accepted-students>`_\ ，
* 上传税务表（Tax form），国外的学生只需要下载
  `Foreign Certification Form <https://developers.google.com/open-source/gsoc/help/images/foreign-certification.pdf>`_
  打印出来签名扫描上传便好
* 注册 Payoneer 帐号设置收款账户 :-D 
* 完善个人信息

做完以上事情后，GSoC 就可以正式开始了，从 4 月 23 号到 5 月 22 号是 Community
Bonding Period，用来和社区成员交流，配置开发环境，熟悉工作流程等。

焦虑的 Community Bonding
------------------------

Hurd 当前的开发者基本在欧洲，我的两位 mentor：
`Richard Braun <https://www.sceen.net/~rbraun/resume.pdf>`_ 和
:ghuser:`Justus Winter <https://github.com/teythoon>` 也是，
由于时区相差太大，一般在下午五点以后跟他们用 IRC 联系。

在同 mentor 们联系之后，我开始看 Hurd 的\ `文档 <https://www.gnu.org/software/hurd/index.html>`_\ ，
作为一个除了开发者之外几乎没人用的系统 :-( ……除了 Wiki 之外没有任何参考的资料，
甚至项目中的文档也是严重过期的。

我的项目是 `Implement xattr Support <https://www.gnu.org/software/hurd/community/gsoc/project_ideas/xattr.html>`_\ ：
在 Hurd 的 ext2 文件系统上（是的，Hurd 依然在用 1993 年发明的的文件系统 :-(）
上实现文件扩展属性（Extended file attributes/xattr），xattr 是一种文件系统的特性，
能为磁盘上的文件添加键值对（Key/Value pair），文件之于 xattr，类似进程之于环境变量。
并使用 xattr 来储存 Hurd 所需的元信息。

Hurd 并不是一个内核，而只是一套微内核守护进程，真正的内核是 GNU Mach，
大部分的功能都使用 translator 实现在用户态。

Translator 是一类程序，相当于一个 Server，translator 需要与一个文件绑定，
用户通过访问这个文件来实现对 Server 的请求，如下：

.. code::

   $ touch hello
   $ cat hello
   $ settrans hello /hurd/hello
   $ cat hello
   "Hello World!"
   $ settrans -g hello
   $ cat hello


Translator 分为 passive translator 和 active translator，passive translator
只是一个命令行，储存在磁盘中，当该文件首次被访问时执行，在我实现 xattr 之前，
passive translator 一直是简单地储存在一个临时申请的块中（这就是 Hurd 需要 xattr
的原因：用更通用的方式来储存 passive translator）。

ext2 文件系统的 translator 叫做 ext2fs，位于 `/hurd` 目录下，我的全部工作，就是
为 ext2fs 的代码添加 xattr 支持，因此，虽说是内核项目，但是全过程都在用户态下进行。

这些东西也都是后来才慢慢知道的，一开始我只是埋头看文档，Hurd is not Linux，
很多概念都和 Linux 差别极大……我本来的英文就很差，效率也不行，越看越乱，
每天都坐在电脑前配合着 Google 翻译看文档，一天八九个小时下来，
集中精神看的时间可能不到十分之一，Braun 每天都会询问我进度，我又支支吾吾说不出来。

有时候会遇到些看不懂的句子，问 mentor 们的时候又因为英文问题而交流不畅，那时候真恨不得
自己变成个外国人。

那时候我开始觉得到我可能胜任不了这份工作，GSoC 每年大概有近 10% 的学生无法完成任务（Fail），
我会是那 10 % 么？

这样焦虑的日子持续了一两个星期，终于有一天在讨论 Hurd 中 port 的概念时，Braun 说：

..

   "i think next years, we'll make sure students understand this before they get accepted,
   as part of the communit bonding period"


这个时候再不行动，被 fail 就是可预见的未来了，我已经没有心情和自制力去继续看文档了，
还是直接写代码吧。

..

   不过，看文档的这段时间虽然很痛苦，但是也不是没收获，我从中了解到了一些 micro kernel
   的概念，并且也不再像以前那样害怕英文文档了。


编程之夏
--------

大概从 5 月 18 号开始，我从无脑看文档转为写代码， 写代码比看文档愉快多了 ——
这大概也是我编程能力止步不前的原因吧，瞎写代码不看书。
mentor 们显然对我之前看文档表现出来的低下的效率和理解力很不满意，但依然对我的问题有问必答。

其实 Hurd 在  06 年的时候就有人提交过 xattr 的 patch：\ `GNU Savannah patch #5126 <https://savannah.gnu.org/patch/?5126>`_\ ，
当然那个 patch 很不完善（于是就这样搁置了 10 年吗 orz），到现在更是完全跑不起来了。

..

   所以其实项目的最小目标就是：把这个 patch 修好 —— 当然这是后话了，那时候我不知道项目原来这么简单……


于是我开始修 patch，参照 ext2fs 的其他代码，把旧函数用新函数替代，
把能看懂的地方看懂，加上注释，看不懂的地方标注出来，在接口代码上打洞，
方便从外部测试这些代码。

修完之后便参考 `The Second Extended File System <http://www.nongnu.org/ext2-doc/ext2.html#CONTRIB-EXTENDED-ATTRIBUTES>`_
和 `Linux Kernel <http://lxr.free-electrons.com/source/fs/ext2/xattr.c>`_ 的代码，
修正原来代码中的 Bug，补全缺失的 xattr 函数。

写代码比起看文档有实实在在的产出，也就有东西向 mentor 们汇报了，相比他们对我的评价也有所上升，
从 5 月 18 号到 7 月 4 号，我完成了大部分的功能并进行了调试，实现并导出了如下四个函数：

.. code::

   /* 列出节点的所有 key */
   error_t ext2_list_xattr (struct node *np, char *buffer, int *len);
   /* 获取节点指定 key 的值 */
   error_t ext2_get_xattr (struct node *np, const char *name, char *value, int *len);
   /* 设置节点指定 key 的值 */
   error_t ext2_set_xattr (struct node *np, const char *name, const char *value, int len, int flags);
   /* 删除储存 xattr 信息的块 */
   error_t ext2_free_xattr_block (struct node *np);


5 月 18 号到 6 月 28 号，这段时间每天都保持着 6-7 * 6 个小时的工作时长，
用这么长时间是为了弥补我的低下的工作效率…… 6 月 28 日后，由于脑残学院的规定，
我不得不离开宿舍到一个恶心的培训公司实训，并在那个公司度过了大量不愉快的时间，
详情不表。我从来没有这么讨厌过自己的学校，待我毕业后一定要上知乎狠狠撕一下这个愚蠢的实训制度。#FLAG

这段时间的代码都提交在 
`SilverRainZ/hurd at gsoc-2016-xattr <https://github.com/SilverRainZ/hurd/tree/gsoc-2016-xattr>`_ 上。

夏日的怠惰尾声
--------------

就如同上面所说的，只要修好这个 patch 并补全 xattr 的功能，项目就算完成了，
「GSoC 原来这么水啊……」，我开始产生了这种想法，一旦完成了最小目标，我就开始松懈，
在接下来的时间我更多地把精力放在了 Srain 的开发上。

对于 GSoC 那边，仅仅是整理了代码和 commit 并再次测试，两位 mentor 对我后期的怠惰倒是没什么意见，
虽然我本来可以做更多的…… 预期的目标是在实现 xattr 之后实现 libdiskfs
（文件系统 translator 库，类似 vfs）以及 libc 接口，并把 xattr 的一系列工具 port 过来：
这些最后都因为我的懒惰而没有动手。

这段时间我也不再天天挂在 IRC 上，而是每隔两三天上一次，mentor 们也没有向我询问进度，
反而是我一直在催他们 review 我的代码，征求他们的建议。他们似乎很忙，总体来看并没有积极地
reivew，这让我有点失望。但建议还是收到一些的，改了一些关于兼容旧 passive translation
的代码，apply 了几个 justus 的小 patch。

摸鱼的日子一天天过去，迎来了 final evaluations，根据 mentor 的指导写了 GNU style 的
changelog，把整理好的两个 patch 发给他们，并写了一封总结邮件
`[GSoC] Implement xattr Support Update <http://lists.gnu.org/archive/html/bug-hurd/2016-08/msg00075.html>`_
到 Hurd 的邮件列表。接着又到 GSoC 的网站上完成了 final evaluations。

8 月 30 号，收到了 GSoC 完成的通知，结束了这个不算完美的夏天。

----

总结
----

我之所以能被 accept，和我的选择是有密切关系的：


* 内核项目门槛稍高
* Hurd 是冷门（想也知道）项目，
* Implement xattr Support 是比较重要的项目
* 申请的学生里之前普遍没有参与过 Hurd 的开发

因此，和我竞争的学生大概只有 6、7 位，Hurd 最终 accept 了两位学生，除我之外，
另一位是 `Phant0mas <https://github.com/Phant0mas>`_\ ，去年的 GSoC 也为 Hurd
贡献了代码，我觉得如果申请的学生中存在本项目的开发者的话，其他人大概都没什么戏。
当时在选择 Hurd 的时候，其实也怀着「冷门项目大概没什么人报吧」这样的想法。

对于这次的 GSoC，我不满意，自己的参与度不够，一方面受制于自己的英语水平，
一方面自己依然没办法打败自己 —— 自制力太低，效率太低。导致我最终仅仅是名义上地完成了项目，
没有继续贡献社区，也没有交到什么朋友，甚至连自己的代码能不能 merge 到主线都说不准。

在这其间我收到了 Google 的三笔付款 `3234.86 + 14635.59 + 17959.75` 总计 35830.2 元，
一只圆珠笔，一本本子，一封 PDF 形式的电子证书，还有一件还在路上的 T-shirt，
物质收入颇丰。

相关链接
--------


* `GSoC 官网 <http://summerofcode.withgoogle.com/>`_
* `Hurd 官网 <https://www.gnu.org/software/hurd/hurd.html>`_
* `我的项目链接 <https://summerofcode.withgoogle.com/archive/2016/projects/5786848613892096>`_
* `Patch 和脚本 <https://github.com/SilverRainZ/gsoc-2016>`_
* `我的 Hurd fork <https://github.com/SilverRainZ/hurd>`_

--------------------------------------------------------------------------------

.. isso::
