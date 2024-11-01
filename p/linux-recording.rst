:isso-id: /notes/music-making/linux-recording

===================
在 Linux 环境下录音
===================

.. highlight:: console

.. jour:: _
   :date: 2024-05-03


通过运行 GNU/Linux 的个人电脑录制乐器和人声。
环境：Arch Linux, kernel 6.8.8, pipewire 1.0.5，所以才需要写这么篇文章…
目前的拓扑是这样的：

   吉他/麦克风 →  :sup:`6.5mm TS` →  效果器 →  :sup:`6.5mm TS` → 
   声卡 →  :sup:`USB` →  电脑 →  DAW

设备
====

独立声卡
--------

之前一直不理解为什么录音需要声卡？主板上不是有声卡么？不是麦克风连电脑不就好了吗？

1. 需要有音频接口：即使完全不考虑音质，我们也需要一个让电脑能够接收音频信号的接口，
   我的电脑有 3.5mm TRRS 的输入接口（能插有通话功能的耳机）。
   吉他及其周边输出用的是 6.5mm 的 TS 口 [#]_，相对专业的麦克风用的则是卡农口，
   规格不一、用途不同。而独立声卡这些都会提供，再通过 USB 将数据传给电脑。

2. 需要及格的音频处理能力：（据说）板载声卡 :del:`采样率低`，抗干扰能力弱，
   得到的声音质量差。但对比参数：就采样率而言没啥区别，其他有区别但我看不懂：

   .. literalinclude:: thr5a.txt
      :caption: `arecord --list-device` + `arecord --dump-hw-params -D hw:<CARD_NUM>`
      :diff: onboard.txt

实际上，我的 :dev:`thr5a` 和 :dev:`mg300` 都自带了声卡，内核也能正常识别，但
后者录音的时候总是捕捉不到，怀疑和 这里__ 遇到了同样的问题，折腾不动，
故使用 thr5a 录音。

.. code-block:: console
   :caption: 需要 :archpkg:`wireplumber`
   :emphasize-lines: 17,18

   $ wpctl status
   …

   Audio
    ├─ Devices:
    │     …
    │     101. NUX MG-300 AUDIO                    [alsa]
    │     148. THR5A                               [alsa]
    │  
    ├─ Sinks:
    │  *  …
    │     122. NUX MG-300 AUDIO Analog Stereo      [vol: 0.40]
    │     166. THR5A Analog Stereo                 [vol: 0.40]
    │  
    ├─ Sources:
    │     …
    │  *   97. THR5A Analog Surround 4.0           [vol: 1.00]
    │     127. NUX MG-300 AUDIO Analog Stereo      [vol: 1.00]
    │  

   …

__ https://blog.nostatic.org/2021/01/nux-mg-300-guitar-processor-under-linux.html

录制
====

The Unix way: 直接录制
----------------------

GUI
   对于最简单的录制音频场景，可以考虑用 :archpkg:`gnome-sound-recorder`。

ALSA
   需要 :archpkg:`alsa-utils`::

      $ arecord --list-device
      **** List of CAPTURE Hardware Devices ****
      …
      card 1: THR5A [THR5A], device 0: USB Audio [USB Audio]
        Subdevices: 1/1
        Subdevice #0: subdevice #0

   设备号是 `HW:<CARD>,<DEV>`，也就是 `hw:1,0`，开始录音::

      $ arecord -f S24_3LE -r 44100 -D hw:1,0 -c 4 test.wav
      Recording WAVE 'test.wav' : Signed 24 bit Little Endian in 3bytes, Rate 44100 Hz, Channels 4
      ^C
      Aborted by signal 中断...

   播放::

      $ aplay test.wav
      Playing WAVE 'test.wav' : Signed 24 bit Little Endian in 3bytes, Rate 44100 Hz, Channels 4

Pipewire
   Target ID 从 `wpctl status` 获取::

      $ pw-record --target 121 test.wav
      ^C

The Pro way: Digital Audio Workstation (DAW)
--------------------------------------------

实际上，正经一点的录制工作都不会像上面一样用命令行工具或者简陋的 GUI，
而是使用集成化的 DAW 软件，随便找了个视频扫盲一下：

.. youtube:: UqOTEqAE9D8

当然在 Linux 上，DAW 软件选择比较有限 [#]_ [#]_：

:Reaper: 跨三平台（wine on Linux），使用简单，但是收费
:Ardour: 老牌开源，一直在更新，看起来不错
:LMMS: 新潮漂亮，但看起来完全是给电子音乐用的，不支持录制功能
:Presonus Studio One: 商业软件但免费，原生 Wayland 和 Pipewire 支持，但 arch 没包

简单试用了下选择了 Ardour，有 中文教程__，对于本文来说，看 录制音频__ 一节即可。

__ https://wiki.ubuntu.org.cn/Ardour%E5%AE%8C%E5%85%A8%E6%95%99%E7%A8%8B
__ https://wiki.ubuntu.org.cn/Ardour4_%E5%88%9D%E5%AD%A6%E8%80%85%E6%95%99%E7%A8%8B_02_%E5%BC%80%E5%A7%8B%E5%85%A5%E9%97%A8#.E5.BD.95.E5.88.B6.E9.9F.B3.E9.A2.91

更多内容参看 :doc:`/notes//man/ardour`。

参考
====

.. [#] `你真的了解“吉他线”吗？ | 街声 - StreetVoice <https://dashi.streetvoice.cn/article/20221226/001/>`_
.. [#] :archwiki:`List_of_applications/Multimedia#Digital_audio_workstations`
.. [#] https://alternativeto.net/software/cubase/?platform=linux
