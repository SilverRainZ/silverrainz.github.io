:isso-id: /collections/devices/instruments

====
乐器
====

.. default-role:: dev

吉他
====

Ibanez EWP14
------------

.. dev:: _
   :id: ewp14
   :type: guitar
   :web: https://www.ibanez.com/usa/products/detail/ewp14_2y_08.html
   :startat: 2023

调弦
   A, D, G, C, E, A

琴弦
   尽量用软的，目前 EJ15 感觉不错。

Martinez MSCC-14RS
------------------

.. dev:: _
   :id: mscc-14rs
   :type: guitar
   :web: https://martinezguitars.cn/item/111
   :startat: 2021

拾音器
   型号：Fishman Presys Blend，说明书__

   __ https://www.washburn.com/wp-content/uploads/2018/08/Fishman-presys_blend_user_guide.pdf

Chillman ERA
------------

.. dev:: _
   :id: chillman
   :type: guitar
   :startat: 2024-11

最近很火的无头小琴，半空心。

- 很轻很小，3kg 左右，相当便携
- 可以用古典姿势持琴
- 琴头可以夹调音表，不过太厚了实际不容易夹上
- 不容易跑音，好几天调一次也没问题，调音也不麻烦
- 扇品很好适应，就…和直品没啥区别
- 尾钉不在琴尾的中心而在上方，一些背带可能会有点短
- 需要一个专用的琴架，目前网上 99 且没有平替

退役
----

.. dev:: Yamaha FG730
   :id: fg730
   :type: guitar
   :endat: 2020

.. dev:: Tagima TG530
   :id: tg530
   :type: guitar
   :startat: 2024-02
   :endat: 2024-08

周边设备
========

Yamaha THR5a
------------

.. dev:: _
   :id: thr5a
   :type: amplifier
   :web: https://ca.yamaha.com/en/products/musical_instruments/guitars_basses/amps_accessories/thr/index.html
   :man: https://tw.yamaha.com/files/download/other_assets/1/331521/THR_ZV05630_R1_zh_web.pdf
   :startat: 2023

规格参数：S24_3LE, 44100Hz, 4 channel

作为放大器
~~~~~~~~~~

木吉他
   将 ``MIC TYPE`` 扭到非 ``EG GLN`` 选项，此时 ``BLEND/GAIN`` 旋钮的 ``BLEND`` 生效，
   用于麦克风模拟（``MIC``）和输入信号（``DIRECT``）之间的混合程度，选 ``DIRECT`` 以
   尽量还原输入。

   :CONDENSER: 电容式麦克风设置给原声吉他提供丰富的中音
   :DYNAMIC: 动态麦克风设置给原声吉他提供紧凑音调（我目前用电容麦，选这个比较好 |?|）

电吉他
   虽然是木吉他音响，但还是提供了电吉他的功放：将 ``MIC TYPE`` 扭到 ``EG GLN`` 即可。
   此时 ``BLEND/GAIN`` 旋钮的 ``GAIN`` 生效，用于调节增益（进入效果器之前的信号放大）

   :EG GLN: 此设置专为电吉他设计，提供清晰、丰富、干净的音调，具有美国组合
            放大器的音色和12英寸音箱箱体的特色声音

作为声卡
~~~~~~~~

Tha Editor
   AUR 居然有 wine 的 :aur:`thr-editor`，可以正常运行，不过没办法连上音响。

Linux 声卡驱动
   :del:`可喜可贺，在我的 Arch Linux 上开箱即用`。
   似乎要安装 :archpkg:`alsa-firmware`。
   
USB 输出不经过效果器链
   在 Ardour 听录制的内容时，感觉输出信号大小不受 ``GAIN`` 和 ``MASTER`` 影响，
   也不会带上效果.

   .. figure:: /_images/2024-07-12_225925.png

      看起来 USB 的信号有可能不会经过放大和效果，以声卡的用途来说应该算合理？

      但另一个 USB 和括号里的 L、R、DI 1 2 是什么意思？

   我现在把监听耳机插在 PHONES 上，是经过效果链的，感觉起不到监听的效果，
   我应该把耳机插在电脑上么？

录人声
   动圈麦需要搭配话放，目前是 :dev:`sm58` + :dev:`mic200`

录电吉他
   现在电平太低：

   - |x| 已知调节 GAIN 对录音没有用
   - |x| 串上了 :dev:`mg300`，电平高了起来，但声音质量很差
   - |_| 考虑用话放 :dev:`mic200`，但电源坏了，再等等

Nux MG300
---------

.. dev:: _
   :id: mg300
   :type: pedal
   :web: https://www.nuxaudio.com/mg-300.html
   :man: https://nux.cherubtechnology.com//enclosure/sources/KaMsorxJzHMrJVfr/NUX_MG300_UserManual.pdf

QuickTone
   配套了很好用的软件，可惜 Linux 没福分

声卡
   2024.05，在 Arch Linux, kernel 6.8.8, pipewire 1.0.5 上录音不可用。

   https://blog.nostatic.org/2021/01/nux-mg-300-guitar-processor-under-linux.html

舒尔 SM58
---------

.. dev:: _
   :id: sm58
   :type: mic
   :startat: 2024-05

铁三角 M20X
-----------

.. dev:: _
   :id: ath-m20x
   :startat: 2024-06
   :price: 329CNY

百灵达 MIC200
-------------

.. dev:: _
   :id: mic200
   :startat: 2024-06
   :man: https://mediadl.musictribe.com/media/sys_master/hba/h89/8849972363294.pdf
   :price: 180CNY

闲鱼二手收的，比拼多多的杂牌 Rodyweli 好多了。底噪很小，声音确实可以用温暖形容。

几个要注意的：

- 录人声的时候可以把 ``LOW CUT`` 打开以去除低频噪音（人声高频居多）
- 尽管提供了 6.3TS 口和卡农两个输入，但两个输入端不能被同时使用
  （实测可以，但说不能用我们就不用吧）

`【教程篇】低成本！高回报！提升音质！你为什么需要一个话放！百灵达电子管话放mic500usb录音，直播都适合的录音设备！_哔哩哔哩_bilibili <https://www.bilibili.com/video/BV16Z4y187MQ/>`_
