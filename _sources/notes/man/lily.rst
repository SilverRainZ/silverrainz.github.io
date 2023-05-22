========
LilyPond
========

:Online Editor: https://www.hacklily.org/

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

:升: 音名 + `is`，如 `:lily:`{ cis' }`` -> :lily:`{ cis' }`
:降: 音名 + `es`

双音/和弦
---------

用 `<>` 括住音名，后跟时值，如 `:lily:`{ <c' e' g'>2  }``  -> :lily:`{ <c' e' g'>2 }`

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

鼓谱
----

https://pyonpyon.today/p/2021-07-write-drum-score-with-lilypond-on-arch/#%E9%AC%BC%E9%9F%B3ghost-note

指定调式
----------

以 G 大调为例，在任意一个 expression block 中：`\key g \major`。

每行四小节
----------

每四个小节后面加个 `\break`。

节奏
----

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

.. rubric:: 脚注

.. [#] :lilydoc:`notation/file-structure`
.. [#] :lilydoc:`music-glossary/pitch-names`
.. [music-expr] :lilydoc:`learning/music-expressions-explained`
.. [#] https://lilypond.org/doc/v2.22/Documentation/notation/output-file-names
.. [#] :lilydoc:`notation/using-midi-instruments`
.. [#] :lilydoc:`notation/midi-instruments`
