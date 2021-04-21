

========================================
 从多说迁移到 Isso
========================================

.. post:: 2017-06-10
   :tags: Isso, 多说
   :author: LA
   :language: zh_CN


前阵子多说 `对外宣布 <http://dev.duoshuo.com/threads/58d1169ae293b89a20c57241>`_
它将在 2017 年 6 月 1 日停止服务。截至 6 月 9 日，评论框已经无法使用，甚至我的
评论管理后台的域名也已经停止解析了。

这其实是意料之中的事情，缺乏盈利途径的多说长久以来一直处于缺乏维护的状态，
三头两头挂一次，这次终于撑不下去了。总之还是感谢这一两年来多说它提供的方便又免费
的评论服务。即使是这么一个没人看的小博客，评论功能也是不可缺少的，感谢归感谢，
我还是得找个下家 :-) 。

.. contents::

为什么是 Isso
-------------

我所见的各种静态博客用得最多的还是 Disqus，曾经我也是 Disqus 的用户，但是 Disqus
存在着一些问题：


* :del:`被墙，这当然不是 Disqus 本身的问题，这甚至不算是个问题`
* 评论无法彻底被删除，我曾经在 #archlinux-cn 讨论过这个问题，有人说既然你把数据
  公开地 post 到网上来了，就别想着它能够被删除，因为任何人都可以将他备份起来。
  我不敢苟同，数据是公开的没错，但作为这个评论系统的管理员，我应当有权利让这些
  数据从我「管辖」的范围内删除，而 Disqus 并没有给我这样的权利。更重要的是，看着
  这样删不掉的数据真的是太不爽了
* 非 Disqus 用户无法方便地评论，甚至会诱导你注册帐号

经过这次多说的关闭，我还是倾向于寻找一个开源的，能自己架设的评论系统。
`biergaizi <https://tomli.blog>`_ 在微博推荐了
Disqus 的开源替代：\ `Isso <https://posativ.org/isso/>`_\ ，Isso 在 Github 上有 2k+
的 stars，开发虽然看起来不活跃但也不至于死掉，官网的 Demo 看起来不错，
AUR 里面还有有现成的包能用，于是就决定是你了，Isso！

我的博客托管在 Github 上，源码存放于：
`https://github.com/SilverRainZ/tech <https://github.com/SilverRainZ/tech>`_\ ，
Isso 则将部署在一台跑着 Arch Linux 的小破 vps 上。 **以下的操作均针对该代码仓库
以及 vps 上的 Arch 环境。**

架设服务
--------

首先从 AUR 安装安装 Isso：

.. code-block::

   $ yaourt -S isso


其依赖 python-misaka-v1 和 python-html5lib-9x07 也是 AUR 包，yaourt 也会帮
我们安装上。AUR 虽好，但在安装的时候最好还是检查一下 PKGBUILD 和 .install 文件，
以避免来自收到来自一些混乱邪恶的打包者的恶意（比如前阵子就有人在 Pypi 和 Gem
投了恶意包 Orz）。

:del:`考虑把 Isso 收养到 archlinuxcn 源里，这个以后再说吧……`

安装完成后，打开 ``/etc/isso.conf`` 文件，文件对各个配置项都有详细的解释，
需要重点关注的配置如下：

.. code-block:: ini

   # Isso configuration file
   [general]
   # 数据库地址，默认值是在 /tmp 里，无法持久化
   dbpath = /var/lib/isso/comments.db
   # 使用 Isso 的网站地址，从不在这个列表里的地址发出的评论会被忽略
   host =
       http://tech.silverrainz.me/
       https://tech.silverrainz.me/
   ...

   # 日志
   log-file = /var/isso.log

   [server]
   # 监听端口
   listen = http://localhost:8080
   ...

   [guard]
   # 开启 SPAM 保护
   enabled = true
   # 每分钟内最多五个新评论
   ratelimit = 5
   # 评论不需要填写邮箱
   require-email = false
   ...

更详细的配置参考： `Server Configuration <https://posativ.org/isso/docs/configuration/server/>`_

填写配置之后执行 ``systemctl start isso.service`` 就能启动 Isso 了。但注意配置文件
里监听的是本地地址的端口，这里将用 nginx 反向代理将连接转发给 Isso。

nginx 配置如下（参考 `Running Isso <https://posativ.org/isso/docs/quickstart/#running-isso>`_\ ）：

.. code-block:: nginx

   server {
       listen [::]:80;
       server_name comments.silverrainz.me;

       location / {
           proxy_pass http://localhost:8080;
           proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
           proxy_set_header Host $host;
           proxy_set_header X-Forwarded-Proto $scheme;
       }
   }

其中 ``comments.silverrainz.me`` 是指向 vps 的域名，你需要在域名所使用的 DNS
服务器提供者那里修改 A 记录。

邮件通知
^^^^^^^^

// TODO

还不会配 SMTP，先搁着。

客户端
------

只要在网页中插入如下代码即可插入评论框：

.. code-block:: html

   <script data-isso="//comments.silverrainz.me/"
           src="//comments.silverrainz.me/js/embed.min.js"></script>

   <section id="isso-thread"></section>

Jekyll's Way
^^^^^^^^^^^^

对于 Jekyll 博客，比较好的做法是 ``_includes`` 目录下在建立 ``comments`` 文件用来
存放评论框代码：

.. code-block:: html

   <link rel="stylesheet" href="{{ site.baseurl }}/assets/comments.css">

   <script data-isso="//comments.silverrainz.me/"
           src="//comments.silverrainz.me/js/embed.min.js"></script>

   <section id="isso-thread"
            data-title="{{ page.title }}"
            data-isso-id="{{ page.id }}"></section>

其中 ``data-isso-id`` 和 ``data-title``  用来指定文章的唯一标识符和标题。
为每个文章指定标识符便于以后的各种迁移。``{{ page.id }}``
和  ``{{ page.title }}``
是 Jekyll 提供的模板，用于获取本页面的 ID 和标题。
title 和 id 可以在文件的 yaml 头中设置，但 Jekyll 会为 ``_posts`` 中的文章自动生成 ID，
对于 ``_post/2017-06-10-switch-from-duoshuo-to-isso.md``\ ，
其 ID 是 ``/2017/06/10/switch-from-duoshuo-to-isso``\ 。

然后在页面模板 ``_layouts/page.html`` 里面引用 ``comments`` 文件：
``{% include comments %}``
就可以在每个使用了 page 模板的网页上显示评论框了。

详情请参见：\ `Commit: Replace duoshuo with isso <https://github.com/SilverRainZ/tech/commit/91fba1ed944ddc48d10df6dd21fceae5a0860b74>`_

HTTPS
-----

对于启用了 HTTPS 的博客来说，部署还没有结束：在 HTTPS 页面（博客）中引用的
HTTP 脚本 (http://comments.silverrainz.me/js/embed.min.js) 被认为是危险的
Mixed Content，现代浏览器会拒绝加载它们，因此评论框并不能显示出来。

还好我们有 Let's Encrypt，给 Isso 上 HTTPS 并不是难事。

只要验证了你对域名的所有权，Let's Encrypt 就为你签发证书，整个签发过程通过
certbot 完成，certbot 位于 [Community] 源中。验证所有权可以通过让
Let's Encrypt 访问你的网站上的随机验证文件完成，如果你使用 nginx 的话，更简单的
方式是安装软件包 certbot-nginx，指定 certbot 使用 nginx 验证方式即可。

.. code-block::

   # pacman -S certbot certbot-nginx


运行 certbot 申请证书需要各种参数，参数也可以写在配置文件中，方便续签证书使用，
假设配置文件地址为 ``/etc/letsencrypt/cli.ini``\ ：

.. code-block:: ini

   rsa-key-size = 4096
   domains = comments.silverrainz.me
   email = <e-mail address>
   authenticator = nginx

其中 ``domains`` 是一个用逗号分隔的域名列表，可以让一个证书能用在多个域名上。
``authenticator = nginx`` 需要你安装 certbot-nginx。

certbot 的更多用法见：\ `User Guide <https://certbot.eff.org/docs/using.html>`_

执行以下命令申请证书：

.. code-block::

   # certbot -c /etc/letsencrypt/cli.ini certonly


接着按 certbot 的输出提示操作即可，当你看到类似信息的时候，说明证书已经申请成功了：

.. code-block::

   IMPORTANT NOTES:
    - Congratulations! Your certificate and chain have been saved at /etc/letsencrypt/live/comments.silverrainz.me/fullchain.pem.
    - ...

获得证书后，修改 nginx 中 ``comments.silverrainz.me`` 的 server blcok：

.. code-block:: nginx

   server {
       listen 443 ssl http2;
       listen [::]:443 ssl http2;

       ssl_certificate /etc/letsencrypt/live/comments.silverrainz.me/fullchain.pem;
       ssl_certificate_key /etc/letsencrypt/live/comments.silverrainz.me/privkey.pem;
       ssl_trusted_certificate /etc/letsencrypt/live/comments.silverrainz.me/chain.pem;
       ssl_session_timeout 1d;
       ssl_session_cache shared:SSL:50m;
       ssl_session_tickets off;
       ssl_prefer_server_ciphers on;
       add_header Strict-Transport-Security max-age=15768000;
       ssl_stapling on;
       ssl_stapling_verify on;

       server_name comments.silverrainz.me;

       location / {
           proxy_pass http://localhost:8080;
           proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
           proxy_set_header Host $host;
           proxy_set_header X-Forwarded-Proto $scheme;
       }
   }

至此，应当可以通过 HTTPS 访问 Isso 的脚本了。

样式
----

Isso 的评论框默认样式是配合亮色背景工作的，我用 CSS 稍稍做了一下调整，保存在
``assets/comments.css`` 中：

.. code-block:: css

   #isso-thread {
       padding:8px;
       margin: 8px;
   }

   #isso-thread .isso-postbox {
       color: #333;
   }

   #isso-thread .auth-section .input-wrapper {
       margin-right: 4px;
   }

   #isso-thread .auth-section .post-action input {
       border-style: none;
       padding: 5px 20px;
       color: #DDD;
       background: rgba(255, 255, 255, 0.2);
   }

   #isso-thread .post-action input:hover {
       color: #FFF;
       background: rgba(255, 255, 255, 0.4);
   }

   #isso-thread .isso-comment a:hover {
       color: #FFF !important;
   }

   #isso-thread .isso-comment .isso-comment-header .author {
       color: #DDD;
       font-size: larger;
   }

数据迁移
--------

完成部署和简单的美化后，接下来就该把旧数据迁移过来了。

在多说宣布关闭的时候我就从后台导出了我的所有评论数据，数据文件的格式是 JSON，
而 Isso 仅支持 Disqus 和 Wordpress 的 WXR 文件。本着不重复造轮子的原则，我找到了
这个脚本：\ `duoshuo-migrator <https://github.com/JamesPan/duoshuo-migrator>`_\ ，
注意脚本依赖 python2 和 python2-lxml。

假设多说数据文件名为 ``duoshuo.json``\ ：

.. code-block::

   $ wget https://raw.githubusercontent.com/JamesPan/duoshuo-migrator/master/duoshuo-migrator.py
   $ python2 duoshuo-migrator.py -i duoshuo.json -o wp.xml


然后导入 Isso 数据库：

.. code-block::

   # isso -c /etc/isso.conf import wp.xml


导入后到对应页面发现之前的评论并没有出现 :-(，使用以下命令将数据库的内容导出来看看

.. code-block::

   $ echo -e '"page: URI","page: title","ID","mode","created on","modified on","author: name","author: email","author: website","author: IP","likes","dislikes","voters","text"\n'"$(sqlite3 /var/lib/isso/comments.db -csv 'SELECT threads.uri, threads.title, comments.id, comments.mode, datetime(comments.created, "unixepoch", "localtime"), datetime(comments.modified, "unixepoch", "localtime"), comments.author, comments.email, comments.website, comments.remote_addr, comments.likes, comments.dislikes, comments.voters,comments.text FROM comments INNER JOIN threads ON comments.tid=threads.id')" > export.csv


这是导出来的 about 页面的一条评论：

.. code-block::

   ...
   "page: URI","page: title","ID","mode","created on","modified on","author: name","author: email","author: website","author: IP","likes","dislikes","voters","text"
   /about.html,"关于",4,1,"2015-11-10 22:28:27",,"Forrest Chang",*************@gmail.com,http://forrestchang.github.io/,***.**.***.*,0,0,"","在知乎上看到，博主今年大二吗？"
   ...

而 ``wp.xml`` 中对应的部分是：

.. code-block::

   ...
       <item>
         <title>关于</title>
         <link>http://lastavenger.github.io/about.html</link>
         <content:encoded><![CDATA[]]></content:encoded>
         <dsq:thread_identifier>5f3988f7e293c4ef57003c774e2a71aa</dsq:thread_identifier>
         <dsq:thread_identifier>5f3988f7e293c4ef57003c774e2a71aa</dsq:thread_identifier>
         <wp:post_date_gmt></wp:post_date_gmt>
         <wp:comment_status>open</wp:comment_status>
         <wp:comment>
           <dsq:remote>
             <dsq:id></dsq:id>
             <dsq:avatar></dsq:avatar>
           </dsq:remote>
           <wp:comment_id>6215529386569892609</wp:comment_id>
           <wp:comment_author>Forrest Chang</wp:comment_author>
           <wp:comment_author_email>*************@gmail.com</wp:comment_author_email>
           <wp:comment_author_url>http://forrestchang.github.io/</wp:comment_author_url>
           <wp:comment_author_IP>***.**.***.***</wp:comment_author_IP>
           <wp:comment_date_gmt>2015-11-10 22:28:27</wp:comment_date_gmt>
           <wp:comment_content><![CDATA[在知乎上看到，博主今年大二吗？]]></wp:comment_content>
           <wp:comment_approved>1</wp:comment_approved>
           <wp:comment_parent>0</wp:comment_parent>
         </wp:comment>

         ...

       </item>
   ...

在多说中我使用 Jekyll 提供的 ``{{ page.id }}`` 来标识文章，
我在 about 页面设置的 id 是 ``/about``\ ，因此在 about 页面的评论框代码会请求获取
``/about`` 页面中的评论，而数据库中的 URI 却是 ``/about.html``\ 。

从多说评论数据转换而来的 ``wp.xml`` 中并没有保留之前的文章 ID (Thread ID)，Isso 应该是
直接从域名里把 URI 取出来当作文章 ID 的：
``<link>http://lastavenger.github.io/about.html</link>`` => ``/about.html``\ 。

于是尝试用 vim 把链接里面的 ``.html`` 去掉：\ ``:%s/.html<\/link>/<\/link>/``\ ，重新导入，
评论就乖乖地出现了。

安全
----

// TODO

Isso 的安全性尚未考证，毫无安全技能点的我也只能先搁着了 :-(。

不足
----

当然 Isso 的缺点也是很多的……


* 没有管理界面，要管理评论只能手动操作数据库
* 交互并不好：从不在白名单的地址（\ ``/etc/isso.conf`` 的 ``hosts`` 列表）发出评论，
  评论框是没反应的；如果你的评论 字数不足/邮件地址格式不对/网址不对，点评论按钮也不会
  有任何反馈
* 以后遇到了再补……

--------------------------------------------------------------------------------

.. isso::
