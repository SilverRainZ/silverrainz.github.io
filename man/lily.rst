========
LilyPond
========

.. highlight:: lilypond

.. hint:: 页面上的预览由 :pypi:`sphinxnotes-lilypond` 生成

.. contents::
   :local:

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

`\symbols` 是个 music expression [#]_ ::

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

输出
====

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

.. [#] :lilydoc:`music-glossary/pitch-names`
.. [#] :lilydoc:`learning/music-expressions-explained`
.. [#] :lilydoc:`notation/using-midi-instruments`
.. [#] :lilydoc:`notation/midi-instruments`
