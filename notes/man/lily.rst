========
LilyPond
========

.. highlight:: lilypond

.. hint:: 页面上的预览由 :pypi:`sphinxnotes-lilypond` 生成

.. contents::
   :local:

文件结构 [#]_
=============

可能出现在顶层的表达式如下：

Output definition,
   例如 `\paper`, `\midi`, and `\layout`，重复的定义会被合并，若冲突后者优先

Direct scheme expression
   类似 `#(set-default-paper-size "a7" 'landscape)`

   .. note:: 这里的 scheme 是指 :enwiki:`Scheme_(programming_language)`

`\header`
   定义谱面的头部，包含标题、作曲家等信息

`\score`
   包含单个 Music Expression [music-expr]_ ，所有顶层的 `\score`，会被隐式地包含在 `\book` 里

`\book`
   用来实现同一份 :file:`*.ly` 文件输出多份谱子

`\bookpart`
   似乎是用来占位以保证谱子不跨页的

Music Expression
   会被隐式地包含在 `\score` 里

Markup text
   TODO

Variable
   任意自定义的变量

记谱法
======

单个音符升降半音 [#]_
---------------------

:升: 音名 + `is`，如 `:lily:`{ cis' }`` ➡️  :lily:`{ cis' }`
:降: 音名 + `es`

和弦
----

.. term:: _

用 `<>` 括住音名，后跟时值，如 `:lily:`{ <c' e' g'>2  }``  ➡️  :lily:`{ <c' e' g'>2 }`

TODO: `ChoreNames` staff

.. seealso:: :term:`和弦模式`

和弦模式
~~~~~~~~

.. term:: _

使用 `\\chordmode` 可以进入 和弦模式__ ，可以只书写和弦符号，如：

`:lily:\`\\chordmode { c1 }`` ➡️  :lily:`\chordmode{ c1 }`

:`c`: 是现代和弦的代号
:`1`: 是时值，同音符模式，有时可省略

常见的代号见 `十分鐘以內，一次搞懂所有的現代和弦代號！`__ ，在和弦模式中，在 `:`
补充大三和弦以外的其他记号:

.. list-table::
   :align: center
   :widths: auto

   * - `c1`
     -  大三和弦
     - :lily:`\chordmode{ c1 }`
   * - `c1:m`
     -  小三和弦
     - :lily:`\chordmode{ c1:m }`
   * - `c1:dim`
     -  减三和弦
     - :lily:`\chordmode{ c1:dim }`
   * - `c1:aug`
     -  增三和弦
     - :lily:`\chordmode{ c1:aug }`
   * - `c1:maj7`
     -  大七和弦
     - :lily:`\chordmode{ c1:maj7 }`
   * - `c1:m7`
     -  小七和弦
     - :lily:`\chordmode{ c1:m7 }`
   * - `c1:7`
     -  属七和弦
     - :lily:`\chordmode{ c1:7 }`
   * - `c1:dim7`
     -  减七和弦
     - :lily:`\chordmode{ c1:dim7 }`

.. note::

   ``\chordmode`` 始终使用绝对音高，即 ``\relative`` 不起作用。
   另，和弦模式里的音高比普通的音符模式高一个八度。

__ https://lilypond.org/doc/v2.23/Documentation/notation/displaying-chords
__ https://wiki.nicechord.com/index.php/%E5%8D%81%E5%88%86%E9%90%98%E4%BB%A5%E5%85%A7%EF%BC%8C%E4%B8%80%E6%AC%A1%E6%90%9E%E6%87%82%E6%89%80%E6%9C%89%E7%9A%84%E7%8F%BE%E4%BB%A3%E5%92%8C%E5%BC%A6%E4%BB%A3%E8%99%9F%EF%BC%81

反复记号
--------

http://lilypond.org/doc/v2.19/Documentation/notation/long-repeats

六线谱
------

五线谱六线谱混排
~~~~~~~~~~~~~~~~

`\symbols` 是个 music expression [music-expr]_ ::

   \score {
     <<
       \new Staff {
         \clef "G_8"
         \symbols
       }
       \new TabStaff {
         \tabFullNotation
         \symbols
       }
     >>
  }

显示和弦指板图
--------------

对于常见的和弦，通过引入 :file:`predefined-guitar-fretboards.ly` 和使用 ChoreMode
可以直接在显示 一些常见和弦的指板图__ ，和弦记法参见 :term:`和弦模式`。

.. lily::

   \version "2.20.0"
   \include "predefined-guitar-fretboards.ly"

   chordsline = \chordmode { c1 c:7 f:maj7 }

   \score {
      <<
      \new ChordNames { \chordsline }
      \new FretBoards { \chordsline }
      >>

      \layout {}
   }

当然，同一个和弦在吉他指板上有不同的按法，如果你需要的按法和预定义的不同，有两种解决方式：

`Automatic fret diagrams`__
   指定和弦的组成音，LilyPond 会根据上下文帮你推测当前 :term:`调弦` 下的指板图。

   例如 D7 和弦的常见按法是： :lily:`\include "predefined-guitar-fretboards.ly" \new FretBoards{ \chordmode { d1:7 }}`，
   但也可以用 C7 的指法下移两品：:lily:`\new FretBoards{ <d fis c' d'> }`。

`\storePredefinedDiagram`__
   也可以用 `storePredefinedDiagram` 命令自定义每一根弦的指法和音高，
   目前用不上。有兴趣可以点链接自行阅读。

__ https://lilypond.org/doc/Documentation/notation/predefined-fretboard-diagrams
__ https://lilypond.org/doc/Documentation/notation/common-notation-for-fretted-strings#automatic-fret-diagrams
__ https://music.stackexchange.com/a/123077

鼓谱
----

https://pyonpyon.today/p/2021-07-write-drum-score-with-lilypond-on-arch/#%E9%AC%BC%E9%9F%B3ghost-note

指定调号
--------

以 G 大调为例，在任意一个 expression block 中：`\\key g \\major`。

每行四小节
----------

每四个小节后面加个 `\break`。

节奏
----

拍子
~~~~

4/4 拍::

   \time 4/4

时值
~~~~

::

   \tempo "Allegro" 4 = 150

附点
~~~~

:附点: 在时值数后加一个点：`a8.`
:双附点: 加俩点了

输出
====

指定输出文件名称
----------------

在 `\score` block 显式地指定 `\book`， 再指定 `\bookOutputSuffix` 即可 [#]_ ::

   \book {
     \bookOutputSuffix "alice"
     \score { … }

MIDI
----

输出 MIDI 文件
~~~~~~~~~~~~~~

::

   \score {
      % ...
     \midi { }
   }

指定乐器
~~~~~~~~

设置 Staff 的 `midiInstrument` [#]_ 属性为乐器的名称 [#]_ ::

    \new Staff \with {midiInstrument = "acoustic guitar (nylon)"} {
      % ...
    }


Frescobaldi MIDI Playback
~~~~~~~~~~~~~~~~~~~~~~~~~

:archpkg:`frescobaldi` 是一个 LilyPond 的可视化编辑器。
需要额外安装 :archpkg:`portmidi` 提供 MIDI 接口支持。

还需要一个软件的 MIDI 合成器以及合适的 SoundFont，这里分别使用 :archpkg:`fluidsynth`
和 :archpkg:`soundfont-fluid`。

设置默认 Soundfont，后面会用上：

.. code:: console

   # ln -s /usr/share/soundfonts{FluidR3_GM,default}.sf2

FluidSynth 需要和特定声音系统交互，默认是 ALSA。

:ALSA: 会独占声卡（2023 年没人用裸用 ALSA 了吧）
:PluseAudio: 可以正常工作
:PipeWire: 驱动有问题，播放的声音像是慢放了许多倍

我是 PipeWire 用户，安装 :archpkg:`pipewire-pulse` 兼容层即可。

编辑 :file:`/etc/conf.d/fluidsynth`，其实就是命令行参数：

.. code:: cfg

   # Mandatory parameters (uncomment and edit)
   SOUND_FONT=/usr/share/soundfonts/default.sf2

   # Additional optional parameters (may be useful, see 'man fluidsynth' for further info)
   OTHER_OPTS='--audio-driver pulseaudio'

运行 `systemctl --user restart fluidsynth.service` 启动 FluidSynth Server。

可通过 `aconnect`（由 :archpkg:`alas-utils` 提供）来检查 MIDI 端口是否启动：

.. code:: console

  $ aconnect --output
  client 14: 'Midi Through' [type=kernel]
      0 'Midi Through Port-0'
  client 128: 'FLUID Synth (22710)' [type=user,pid=22710]
      0 'Synth input port (22710:0)'

那么 FluidSynth 的 MIDI 端口就是 `128:0`，可以使用 `aplaymidi` （由 :archpkg:`alas-utils` 提供）
播放：

.. code:: console

   $ aplaymidi --port 128:0 music.midi

在 Frescobaldi 的界面上，在 `Edit → Preferences → MIDI Settings → MIDI Port`
（即 `编辑 → 首选项 → MIDI 设置 →  MIDI 端口 →  播放器输出`）
将其设置为 "Synth inpurt port"。

配套工具
========

- 可视化编辑器：

  - Qt `Frescobaldi <https://www.frescobaldi.org/uguide#help_preferences_midi>`_
  - 在线 `Hacklily <https://www.hacklily.org/>`_

- Sphinx 插件：`sphinxnotes-lilypond <https://sphinx.silverrainz.me/lilypond/>`_

.. rubric:: 脚注

.. [#] :lilydoc:`notation/file-structure`
.. [#] :lilydoc:`music-glossary/pitch-names`
.. [music-expr] :lilydoc:`learning/music-expressions-explained`
.. [#] https://lilypond.org/doc/v2.22/Documentation/notation/output-file-names
.. [#] :lilydoc:`notation/using-midi-instruments`
.. [#] :lilydoc:`notation/midi-instruments`
