======
Ardour
======

:URL: https://ardour.org/
:教程: `Ardour完全教程 - Ubuntu中文 <https://wiki.ubuntu.org.cn/Ardour%E5%AE%8C%E5%85%A8%E6%95%99%E7%A8%8B>`_

Ardour 是开源的专业数字音频工作站，按理说在非计算机的专业领域，开源软件表现往往不尽人意（正例是 GIMP、LibreOffice，反例是 :doc:`krita`、Blender）。Ardour 虽然界面简陋，且时有崩溃，但功能强大，开发活跃，且有着相当健康的财政状况：

.. figure:: /_images/火狐截图_2024-07-18T15-25-36.345Z.png

   Ardour 超额完成了他们在 2024.07 的募捐计划

Audio System
============

PipeWire
   PluseAudio 之后的，唉，新一代音频系统，配套程序还不是很成熟，但我在用了 。

   截至 2024-07，尚不支持：`Pipewire 1.0 - Is it time now? - Community / Ideas for Ardour - Ardour <https://discourse.ardour.org/t/pipewire-1-0-is-it-time-now/109287>`_
   
ALSA
   Kernel 级别接口，稳定可用，相比 Jack 无需配置开箱即用。但会独占音频设备，导致一系列问题：

   - |p1| 输入/输出（声卡/监听）无法和其他程序共享
   - |p0| 在没有耳放的情况下，监听只能通过 Fader 调节音量，完全不够用
   - |p2| 不能同时使用多个声卡

Jack
   为专业音频处理设计的音频系统规范。Pipewire 也实现了 Jack 协议，因此无需额外安装其他 Jack 实现。

   Audio Connection 
      使用 Jack 需要先学习 `Audio Connection Route`_ 是如何工作的。然后才能解决各种问题：

      输入没声音
         纵轴 Hardware 里找声卡的 ``capture_F[LR]``，连接到横轴 Busses 的 ``Master in``

      监听没声音
         纵轴 Busses ``Monitor out`` → 横轴 Hardware 监听设备的 ``playback_F[LR]``

      节拍器没声音
         纵轴 Ardour Misc ``Click out`` → 横轴 Hardware 监听设备的 ``playback_F[LR]``


   .. _Audio Connection Route: https://wiki.ubuntu.org.cn/Ardour4_%E5%88%9D%E5%AD%A6%E8%80%85%E6%95%99%E7%A8%8B_02_%E5%BC%80%E5%A7%8B%E5%85%A5%E9%97%A8#.E7.90.86.E8.A7.A3.E8.B7.AF.E7.94.B1



输入电平/音量
   亮绿色区间为宜（-18dB~-10dB）。

   目前观察看来，``吉他 →  效果器 →  声卡 →  DAW`` 经效果器会显著减少录入的电平/音量 |?|。
   对于木吉他，效果器是没必要的，去掉了。

录音听起来难听怎么办？ |todo|
