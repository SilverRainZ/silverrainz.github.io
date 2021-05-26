

========================================
 OverTheWire Bandit
========================================

.. post:: 2015-07-26
   :tags: CTF
   :author: LA
   :language: zh_CN

.. hint:: 这是一篇迁移自 Jekyll 的文章，如有格式问题，可到 :ghrepo:`SilverRainZ/bullet` 反馈

题目地址: `OverTheWire: Bandit <http://overthewire.org/wargames/bandit/>`_.

考的都是些 Linux 下的基本操作, 虽然说是基本操作, 不过那些命令都没用过,
所以做了这些题依然觉得受益匪浅. 其中还有有几道题很有意思...
:del:`有意思的意思是我不会做`.

WeChall 计分板
--------------

OverTheWire 使用 Wechall 的计分板来计分,
具体参见 `WeChall Scoreborad <http://overthewire.org/about/wechall.html>`_

因为题目都在远程的 ssh 主机上, 所以你需要让远程主机知道你是谁.
在你的 `.bashrc` 里加上两个环境变量:

.. code-block:: bash

   export WECHALLUSER="你在 WeChall 的用户名"
   export WECHALLTOKEN="你在 WeChall 的 WarToken"

WarToken 可以在 WeChall 网站的
`Account -> WarBoxes -> Your current WarToken <http://www.wechall.net/warboxes>`_
获得.

在 `~/.ssh/config` 中添加:

.. code-block::

   Host *.labs.overthewire.org
   SendEnv WECHALLTOKEN
   SendEnv WECHALLUSER

在 ssh 连接的时候就会把你的帐号信息发送给远程主机.

在登入一个新的关卡后, 执行 `wechall` 便可获得该关卡的分数.

题目
----

bandit17
^^^^^^^^

   The password for the next level can be retrieved by submitting the password of the current level to a port on localhost in the range 31000 to 32000. First find out which of these ports have a server listening on them. Then find out which of those speak SSL and which don’t. There is only 1 server that will give the next credentials, the others will simply send back to you whatever you send to it.


要从 31000-32000 之间的端口中找出有开放的并且只是 SSL 连接的端口,
往该端口发送上一关的密码就会返回下一关的密码.

找出所有有应答的端口:

.. code-block:: bash

   nc -v -w 2 localhost 31000-32000 2>/tmp.tmpxxx/log
   cat /tmp.tmpxxx/log | grep Succ

`-v` 用来给出连接的详细信息, `-w 2` 指定 timeout,
不知道为什么 `-v` 的信息是直接输出到 `stderr` 的.
`tmp/tmp.xxx` 使用 `mktemp -d` 产生的临时目录.

最后有应答的只有五个端口, 挨个挨个试.

.. code-block:: bash

   openssl s_client -connect localhost:31xxx -ssl3 -quiet

发现是 31790 端口, 返回一个 RSA 私钥, 所以:

.. code-block:: bash

   openssl s_client -connect localhost:31790 -ssl3 -quiet > bandit17.private
   chmod 0600 bandit17.private
   ssh -i bandit17.key bandit17@bandit.labs.overthewire.org
   cat /etc/bandit_pass/bandit17

::

   key: xLYVMN9WE5zQ5vHacb0sZEVqbrp7nBTn


bandit21
^^^^^^^^


   There is a setuid binary in the homedirectory that does the following: it makes a connection to localhost on the port you specify as a commandline argument. It then reads a line of text from the connection and compares it to the password in the previous level (bandit20). If the password is correct, it will transmit the password for the next level (bandit21).

   .. note:: To beat this level, you need to login twice: once to run the setuid command, and once to start a network daemon to which the setuid will connect.

   .. note:: Try connecting to your own network daemon to see if it works as you think


`bandit20` 的家目录下提供了一个程序 `suconnect`\ , 会从你指定的端口读取 `bandit20` 的密码,
如果正确的话返回本关卡的密码.

.. code-block:: bash

   echo GbKksEFF4yrVs6il55v6gwY5aVje5f0j | nc -l -p 1234 & ./suconnect 1234

这里主要是 `&` 的用法, 使两个命令同时执行::

   key: gE269g2h3mw3pwgrj0Ha9Uoqen1c9DGr


bandit24
^^^^^^^^


   A program is running automatically at regular intervals from cron, the time-based job scheduler. Look in /etc/cron.d/ for the configuration and see what command is being executed.

   .. note:: This level requires you to create your own first shell-script. This is a very big step and you should be proud of yourself when you beat this level!
   .. note:: Keep in mind that your shell script is removed once executed, so you may want to keep a copy around…


这题我觉得有点意思.

cron 是一个定时执行工具, 任务可以通过命令 `crontab` 设定,
配置储存在 `/etc/cron.d` 中, 每分钟 cron 会被触发一次,
到该目录检测是否有任务要执行: `cat /etc/cron.d/cronjob_bandit24`

.. code-block:: bash

   * * * * * bandit24 /usr/bin/cronjob_bandit24.sh &> /dev/null

所以说 `/usr/bin/cronjob_bandit24.sh` 会每分钟执行一次, 看看这个脚本的内容是什么:

.. code-block:: bash

   #!/bin/bash

   myname=$(whoami)

   cd /var/spool/$myname
   echo "Executing and deleting all scripts in /var/spool/$myname:"
   for i in * .*;
   do
       if [ "$i" != "." -a "$i" != ".." ];
       then
           echo "Handling $i"
           timeout -s 9 60 "./$i"
           rm -f "./$i"
       fi
   done

每次都执行 `/var/spool/bandit24` 下的所有可执行文件, 之后删除.
当然是以 `bandit24` 的身份执行这些操作.

所以我们可以构造一个脚本让他执行.

.. code-block:: bash

   #!/bin/sh
   cp /etc/bandit_pass/bandit24 /tmp/tmp.xxx/psw
   chmod 666 /tmp/tmp.xxx/

这个脚本把密码文件复制到临时目录并且更改他的权限(至少让所有人可读).

中间出了很多愚蠢的错误, 比如写错目录,搞错 `sh` 的路径什么的,
另外, 不能用重定向导出 `bandit24` 的密码, 因为没有权限(为什么没有权限我就不清楚了).

脚本写完后, `chmod +x`\ , 再把它复制到 `/var/spool/bandit24` 目录下, 记得备份,
每隔一分钟该目录就会被清空.

脚本执行后, 到 `/tmp/tmp.xxx` 里就可以看到存有 key 的文件了::

   key: UoMYTrfrBFHyQXmg6gzctqAwOmw1IohZ


bandit25
========

   A daemon is listening on port 30002 and will give you the password for bandit25 if given the password for bandit24 and a secret numeric 4-digit pincode. There is no way to retrieve the pincode except by going through all of the 10000 combinaties, called brute-forcing.


有一个守护进程在 `30002` 端口监听, 把 `bandit24` 的密码和一个四位数字组成的 pincode 传给它,
如果密码和 pincode 都正确的话会返回 `bandit25` 的密码.

所以自然是爆破了, 直接用 nc 链接该端口会提示::

   I am the pincode checker for user bandit25. Please enter the password for user bandit24 and the secret pincode on a single line, separated by a space.


所以按照格式来, 生成 10000 个 密码 + pincode 的序列传给该端口.

.. code-block:: bash

   for i in {0000..9999}; do echo "UoMYTrfrBFHyQXmg6gzctqAwOmw1IohZ $i" >> /tmp/pin; done
   cat /tmp/pin | nc localhost 30002 > /tmp/log
   cat /tmp/log | grep "Corr" -n1

其实答案就是最后一个端口::

   5670-Wrong! Please enter the correct pincode. Try again.
   5671:Correct!
   5672-The password of user bandit25 is uNG9O58gUE7snukf3bvZ0rxhtnjzSGzG


所以::

   key: uNG9O58gUE7snukf3bvZ0rxhtnjzSGzG


bandit26
========

   Logging in to bandit26 from bandit25 should be fairly easy… The shell for user bandit26 is not /bin/bash, but something else. Find out what it is, how it works and how to break out of it.


这是 26 个 level 里面最有意思的一道题的, 可惜我没能做出来...
参考的答案是这个:
`overthewire-bandit-level-26 <http://codebluedev.blogspot.com/2015/07/overthewire-bandit-level-26.html>`_

题干里说 `bandit26` 的 shell 并不是普通的 `/bin/bash`.

`bandit25` 的家目录下给出了 `bandit26` 的私钥,
登录上去只是打印出了 bandit26 的 ASCII Art 就退出了.

.. code-block::

     _                     _ _ _   ___   __  
    | |                   | (_) | |__ / /  
    | |__   __ _ _ __   __| |_| |_   ) / /_  
    | '_ / _` | '_ / _` | | __| / / '_ 
    | |_) | (_| | | | | (_| | | |_ / /| (_) |
    |_.__/ \__,_|_| |_|\__,_|_|\__|____\___/

执行 `cat /etc/passwd | grep bandit26` 得到::

   *bandit26*\ :x:11026:11026:bandit level 26:/home/\ *bandit26*\ :/usr/bin/showtext


(我到这里就卡住了)

发现 `showtext` 是一个 shell 脚本, 内容如下

.. code-block:: bash

   #!/bin/sh

   more ~/text.txt
   exit 0

即 ssh 连上去后执行默认 shell, 用 `more` 打印出了 ~/text.txt 之后就退出了, 如图:


.. image:: /_images/overthewire-bandit26-1.png


一连上就退出, 那我们怎么让它执行我们想要的命令呢? 直接用 ssh 的 `-t` + 命令 是不行的,
这个命令不会被解释, 因为 `bash` 没有执行.

正确答案是通过 `more`.

`more` 在要输出的内容行数多于终端行数的时候会停下来, 等待你翻页,
所以我们把当前的终端调小, 差不多四行, 再次 shh 上去, `more` 就停下来了. (好脑洞)


.. image:: /_images/overthewire-bandit26-2.png


在 `more` 里面按 v, 系统会调用默认的编辑器来编辑这个文件, 默认是 `vi`\ ,
有了 `vi`\ , 就相当于有了一个终端.

在命令模式执行 `:r /etc/bandit_pass/bandit26`\ , 密码的内容就会被读入.


.. image:: /_images/overthewire-bandit26-3.png


要打开 `sh` 的话, 可以:

.. code-block:: vim

   :set shell sh=/bin/sh
   :sh

这样就可以执行 `wechall` 拿分了::

   key: 5czgV9L3Xx8JPOyRbXh6lQbmIOWvPT6Z


--------------------------------------------------------------------------------

.. isso::
