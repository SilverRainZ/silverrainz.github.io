==============
大萝北的视唱课
==============

:date: 2021-09-21

.. hint:: 买课联系 大萝北の扒谱教室_
   
   .. _大萝北の扒谱教室: https://space.bilibili.com/32468150

.. contents:: 目录
   :local:

课程
====

音阶
----

找出几个适合自己音域（唱得舒服）的调。自我感觉是在 A2 :lily:`{a}` 到 D4 :lily:`{d''}` 这样子。

.. tab-set::

   .. tab-item:: A 调

      .. lilyinclude:: ./scale.ly
         :noheader:
         :nofooter:
         :noedge:
         :audio:
         :transpose: c a,

   .. tab-item:: B 调

      .. lilyinclude:: ./scale.ly
         :noheader:
         :nofooter:
         :noedge:
         :audio:
         :transpose: c b,

   .. tab-item:: C 调

      .. lilyinclude:: ./scale.ly
         :noheader:
         :nofooter:
         :noedge:
         :audio:

   .. tab-item:: D 调

      .. lilyinclude:: ./scale.ly
         :noheader:
         :nofooter:
         :noedge:
         :audio:
         :transpose: c d

小红帽
------

.. tab-set::

   .. tab-item:: C 调

      .. lilyinclude:: ./little-red-riding-hood.ly
         :noheader:
         :nofooter:
         :noedge:
         :audio:

   .. tab-item:: D 调

      .. lilyinclude:: ./little-red-riding-hood.ly
         :noheader:
         :nofooter:
         :noedge:
         :audio:
         :transpose: c d

   .. tab-item:: A 调

      .. lilyinclude:: ./little-red-riding-hood.ly
         :noheader:
         :nofooter:
         :noedge:
         :audio:
         :transpose: c a

大小三和弦
----------

:ref:`alice` 把 :lily:`{ c' e' g'}` 刻进我的灵魂里了。

小三还是不准。

.. lilyinclude:: ./triad.ly
   :noheader:
   :nofooter:
   :noedge:
   :audio:
   :loop:

大二度小二度
------------

大二已经耳熟能详，把一个音微妙地不唱准就是小二度 😂 。

.. lilyinclude:: ./major2-minor2.ly
   :noheader:
   :nofooter:
   :noedge:
   :audio:
   :loop:

旋律听辨 I
----------

第一天听比较沮丧，什么都没听出来。但有两个简单结论：

1. 上下行音程要都要练，之前一直忽视了下行的练习
2. 主音在首调里非常重要，旋律是围绕主音的

第二天反复把课程看了几遍，有点听出来了。

一套初阶听辨方法（旋律从主音开始，跨度最大为三度）：

1. 听一遍，跟着哼唱
2. 以主音为参照点，在纸上画出旋律的起伏

   .. image:: /_images/webwxgetmsgimg(1).jpg
      :width: 40%

3. 分辨跨度

   1. 步紧旋律：非常紧凑，二度
   2. 小跨度旋律：稍微有些距离，三度

自主练习
========

G 大调小步舞曲 高声部 
---------------------

从 `Bach - Minuet in G BWV Ahn. 114 <https://www.8notes.com/scores/2944.asp>`_ 提出来的。

原调 G Major，先换成 C Major 方便练习吧。

.. warning::

   :archpkg:`extra/fluidsynth` 2.2.3-1 的尼龙吉他音源在高音区 :lily:`{ g' }` 附近的时值似乎不太对，转调后规避了这个问题，先记一下。

.. lilyinclude:: ./minuet-in-g.ly
   :noheader:
   :nofooter:
   :noedge:
   :audio:
   :transpose: g c

答疑
====

2021-10-27
----------

:谷月轩: Hello，大萝北老师[破涕为笑]。我最近在龟速地上您的视唱课，然后最近有一些疑问跟您请教下：

         1. 能感受到自己唱音名确实是越来越准了，但哼歌的时候还是认不出来自己哼的哪几个音，甚至上下行也会认错，但如果有琴在手里，又几乎马上就能把旋律摸索出来，要到什么时候才能不借助琴就挺准呢？
         2. 如何逐步摆脱音名？总感觉脱离音名就容易唱不准，尤其是跨度大的时候。同样，感觉不从 do 开始唱就不太准，比如唱大三，do - mi ，fa - la 都是，但后面就会不那么准一些。既然如此，比起通过音名记忆音高，直接把小二度到纯八度的感觉记下不是更直接吗？

:大萝北: 听自己哼唱的时候可以先自己判断一下，再用琴对照一下，看看是哪里容易判断错？是主音，还是音程呢
:大萝北: 可以记音程感觉，音名就是辅助记音程感觉的。用音名来唱音程只是为了说更好的找到音程，熟练之后就用拟声词来唱就好
:谷月轩: 刚下班，不好意思[苦涩]。
:谷月轩: 听到一段旋律还要听出来主音是吗，我完全没这个概念…
:谷月轩: 嗯嗯，这个明白了。
:大萝北: 嗯嗯 首调首先要确定主音才能确定旋律哇～
:谷月轩: 听到一段旋律，我假设它第一个音是 C，听出每个音之间的音高关系，不是也能得到一段旋律嘛？虽然和原来的旋律整体音高不一样。
:大萝北: 这样子就会有变化音，而且整体思路也不是首调方法了～
:谷月轩: 变化音是什么呀？
:谷月轩: 但也不是固定调？我不太懂，我感觉有一些基本的概念搞错了[破涕为笑]
:大萝北: 比如你旋律是345 543，你假设第一个是C的话，那么第二个就会变成bD了，就会多出来变化音
:大萝北: 这个方法应该更偏向于固定调的思路
:谷月轩: 所以，先找出主音，就容易根据其他音相对主音的听感确定它的音高咩？
:大萝北: 对的对的
:谷月轩: 比如刚才的 345 543，首调的人并不是听到 3 小二度 大二度 纯一度 大二度 小二度，而是听到了 三级 四级 五级 五级 四级 三级？
:大萝北: 嗯嗯是的
:谷月轩: [苦涩]我居然搞错了这么久。
:谷月轩: 懂了懂了，谢谢老师。

