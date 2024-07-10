====
乐器
====

吉他
====

Ibanez EWP14
------------

.. dev:: _
   :id: ewp14
   :type: guitar
   :web: https://www.ibanez.com/usa/products/detail/ewp14_2y_08.html
   :startat: 2023

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


Tagima TG530
============

.. dev:: _
   :id: tg530
   :type: guitar
   :startat: 2024

退役
----

.. dev:: Yamaha FG730
   :id: fg730
   :type: guitar
   :endat: 2020

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

Tha Editor
   AUR 居然有 wine 的 :aur:`thr-editor`，可以正常运行，不过没办法连上音响。

作为电吉他放大器
   虽然是木吉他音响，但还是提供了电吉他的功放：将 `MIC TYPE` 扭到 `EG GLN` 即可。
   此时 `BLEND/GAIN` 旋钮的 `GAIN` 生效，用于调节增益（进入效果器之前的信号放大）

   :EG GLN: 此设置专为电吉他设计，提供清晰、丰富、干净的音调，具有美国组合
            放大器的音色和12英寸音箱箱体的特色声音

作为声卡录制干声
   将 `MIC TYPE` 扭到非 `EG GLN` 选项，此时 `BLEND/GAIN` 旋钮的 `BLEND` 生效，
   用于麦克风模拟（`MIC`）和输入信号（`DIRECT`）之间的混合程度，选 `DIRECT` 以
   尽量还原输入。

   :CONDENSER: 电容式麦克风设置给原声吉他提供丰富的中音
   :DYNAMIC: 动态麦克风设置给原声吉他提供紧凑音调（我目前用电容麦，选这个比较好 |?|）

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

NoneType' object is not subscriptable
/home/la/documents/bullet/collections/devices/instruments.rst:1: ERROR: no such role: sup

p
---------

.. dev:: _
   :id: shure-sm58
   :type: mic
   :startat: 2024.05

铁三角 M20X
-----------

.. dev:: _
   :id: ath-m20x
   :startat: 2024.06
   :price: 329CNY

百灵达 MIC200
-------------

.. dev:: _
   :id: behringer-mic200
   :startat: 2024.06
   :man: https://mediadl.musictribe.com/media/sys_master/hba/h89/8849972363294.pdf
   :price: 180CNY

闲鱼二手收的，比拼多多的杂牌 Rodyweli 好多了。底噪很小，声音确实可以用温暖形容。

几个要注意的：

- 录人声的时候可以把 `LOW CUT` 打开以去除低频噪音（人声高频居多）
- 尽管提供了 6.3TS 口和卡农两个输入，但两个输入端不能被同时使用
  （实测可以，但说不能用我们就不用吧）

`【教程篇】低成本！高回报！提升音质！你为什么需要一个话放！百灵达电子管话放mic500usb录音，直播都适合的录音设备！_哔哩哔哩_bilibili <https://www.bilibili.com/video/BV16Z4y187MQ/>`_
