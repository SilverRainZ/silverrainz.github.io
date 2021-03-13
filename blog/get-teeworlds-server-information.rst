========================================
 获取 teeworlds 服务器信息
========================================

.. post:: 2016-02-12
   :tags: Teeworlds
   :author: LA
   :language: zh

前阵子凤凰卷给 ArchliunxCN 社区开了个 teeworlds 游戏服务器
（什么是 `teeworlds <https://zh.wikipedia.org/wiki/Teeworlds>`_\ ？），
然而大家总是凑不到一块玩，于是就琢磨能不能做个查询游戏信息的 IRC bot，
有人进服务器是给个提示，bot 不难做，倒是对如何获取游戏信息没什么思路。

一开始智商下线地想要在每个客户端套一个脚本，然后由脚本向 bot 报告自己的信息……
于是搞出来这么个东西：\ `teebot-nogood <https://github.com/SilverRainZ/teebot-nogood>`_\ ，
但是在每个人的客户端上都运行这个脚本一点都不现实，
最后我在 teeworlds 的论坛找到了\ `这个帖子 <https://www.teeworlds.com/forum/viewtopic.php?id=7737>`_\ 。

帖子里给出了几个 PHP 脚本，可以用来扫描 teeworlds 的 master 服务器信息和单个游戏服务器信息，
分别适用与 0.5 和 0.6 版本的服务端。我不懂 PHP，还好代码很简单，对于单个游戏服务信息的获取，
只要向服务器发送字节串 ``\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x67\x69\x65\x33\x05``\ ，
服务器就会返回返回包含游戏的数据，我对照着\ `其中的一个脚本 <http://pastebin.com/W0qjxzvr>`_
写了个 Python 版本：

.. code-block:: python

   #!/usr/bin/env python3
   import socket

   server = '121.199.73.170'
   port = 8303
   sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
   sock.connect((server, port))
   sock.settimeout(5)

   sock.send(b'\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x67\x69\x65\x33\x05')
   data, _ = sock.recvfrom(2048)
   info = data.split(b'\x00')
   info[0] = b'NULL'
   info = [x.decode('utf-8') for x in info]

   print('[teeserver]', 'recv data:', info)
   version = info[1]
   name = info[2]
   map_name = info[3]
   mode = info[4]
   cur_player_num = int(info[8])
   max_player_num = int(info[9])
   players = []

   for i in range(0, cur_player_num):
       base = i*5
       player = {
               'name':     info[base+10],
               'clan':     info[base+11],
               'region':   region_map[info[base+12]],
               'score':    info[base+13],
               'stat':     ['spectator', 'player'][int(info[base+14])],
               }
       players.append(player)

从上面的代码就可以看出数据的形式了，没有什么好说的地方，仅仅是想用中文记录下来，
或许以后有人会需要吧。

上面的代码被我整合进了 `SilverRainZ/teebot <https://github.com/SilverRainZ/teebot>`_ 里，
如果你在 #archlinux-cn 频道的话，输入 ``.tee`` 就能知道现在社区的游戏服务器里有几个人啦。

--------------------------------------------------------------------------------

.. isso::
