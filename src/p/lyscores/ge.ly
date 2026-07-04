%%%% 罗大佑《歌》 两声部（旋律 + 和声）
%%%% 来源乐谱：音伴·吉他课堂（简谱 1=D, 4/4, 78bpm）
%%%% 作词：徐志摩  作曲：罗大佑
%%%%
%%%% 记谱说明：
%%%%   - 内部旋律/和声以首调 C 书写，外层用 \transpose c d 移到实际调号 D 大调。
%%%%   - 和声声部使用 \chordmode，配合 roman-numerals.ly 将和弦符号显示为级数。

\version "2.24.0"

\include "roman-numerals.ly"

common = {
  \key c \major
  \time 4/4
  \tempo 4=78
}

%% 前奏 / 间奏 / 尾奏 共用旋律（简谱 4 5 4 3 2 1 7. 6 …）
interlude = \fixed c' {
  f8 g f e d c \acciaccatura{b, c} b,8 a,8
  \acciaccatura{g,} b,8 g \acciaccatura{b,} a, f \acciaccatura{a,} g, e f, d
  c2 r4
}

melody = \fixed c' {
  \common
  \set melismaBusyProperties = #'()

  %1 前奏（简谱 1. 2 3 5 | 4 5 4 3 2 1 7. 6 | 7 5. 6 4 5. 3 4 2 | 1 - 0）
  c4. d8 e4 g4
  \interlude
  r8 g,

  %5 我死去的时候亲爱你别为我唱悲伤的歌
  \acciaccatura{d} e8 e e e e4 g
  f8. (g16 f8 e) d4 r8 g,
  \acciaccatura{c} d8 d d d d4 c8. d16
  e2 r4 r8 g,

  %9 坟上不必安插蔷薇也无需浓荫的柏树让
  \acciaccatura{d} e8 e e e e4 g
  f8. (g16 f8 e) d4 r8 g,
  \acciaccatura{c} d4 d8. r16 c8 b, a,16 b,8.
  c2 r4 r8 c8

  %13
  \repeat volta 2 {
    \acciaccatura{g} a4 (a8) g8 f4 a8 r8
    g8 (a) g (f) e4 g8 r
    f8. (g16 f8) e8 d4 b,8 (b,)
    c8 c d4 e r8 c

    %17
    \acciaccatura{g} a4 (a8) g8 f4 a8 r8
    g8 (a) g (f) e4 (g8 r16 g)
    fis8 (e) fis g a4 d8 r8
    \acciaccatura{a} b4 (b8.) a16 g4 (f)

    %21
    \time 2/4
    r4 r8 e
    \time 4/4
    e4 e8 e e4 g8 g
    f8. (g16 f8) e8 d4 r8 g,
    \acciaccatura{c} d8 d d d d d c (d)

    %25
    e2 r4 r8 g,
    \acciaccatura{d} e4 e8. r16 r8 e e \acciaccatura{f} g
    f8 (g) f e d4 r8 g,
    \acciaccatura{c} d4 d8. r16 c8 b, a, (b,)

    \alternative {
      \volta 1 {
        %29
        c4. d8 e4 g4
        \interlude
        r8 c,
      }

      \volta 2 {
        %33
        c2 r4 r8 g,
        \acciaccatura{d} e4 e8. r16 r8 e e \acciaccatura{f} g
        f8 (g) f e d4 r8 g,
        \acciaccatura{c} d4 d8. r16 c8 b, a, (b,)

        %37
        c2 r4 r8 g,
        \acciaccatura{d} e4 e8. r16 r8 e e \acciaccatura{f} g
        f8 (g) f e d4 r8 g,
        \acciaccatura{c} d4 d8. r16 c8 b, a, (b,)

        %41
        c4. d8 e4 g4
        \interlude
        r4
      }
    }
  }
}

%% 和弦 → 级数映射（1=D 大调）：
%%   D=I(c)  G=IV(f)  Em=ii(d:m)  A=V(g)
%%   #Fm=iii(e:m)  Bm=vi(a:m)  E=II(d)  A7=V7(g:7)  D7=I7(c:7)
harmony = \chordmode {
  \common

  %1
  c1
  f2 d:m
  g1
  c1

  %5
  c2 e:m
  d2:m g
  d2:m g
  c1

  %9
  c2 e:m
  d2:m g
  d2:m g
  c2 c:7

  %13
  \repeat volta 2 {
    f1
    e2:m a:m
    d2:m g
    c2 c:7

    %17
    f1
    e2:m a:m
    d1
    g1:7

    %21
    \time 2/4
    r2
    \time 4/4
    c2 e:m
    d2:m g
    d2:m g

    %25
    c1
    c2 e:m
    d2:m g
    d2:m g

    \alternative {
      \volta 1 {
        %29
        c2 f
        d1:m
        g1
        c2 c:7
      }

      \volta 2 {
        %33
        c1
        c2 e:m
        d2:m g
        d2:m g

        %37
        c1
        e1:m
        d2:m g
        g1

        %41
        c2 f
        d1:m
        g1
        c1
      }
    }
  }
}

%% 歌词（逐音符对位；_ 表示该音符为上一字的延音）
lyricIntro = \lyricmode {
  %% 跳过前奏 m1-4 的器乐音符（4 + 16 = 20 个非装饰音）
  \repeat unfold 20 { \skip 1 }
  当
  我 死 去 的 时 候
  亲 _ _ 爱 你 别
  为 我 唱 悲 伤 的 歌
  _ 我
  坟 上 不 必 安 插
  蔷 _ _ 薇 也 无
  需 _ 浓 荫 的 柏
  树 让
}

lyricVerseOne = \lyricmode {
  盖 _ 着 我 的
  青 _ 青 的 草 _
  淋 _ 着 雨 也
  沾 着 露 珠 假
  如 _ 你 愿 意
  请 记 着 我 _ _
  要 是 你 甘 心 _
  忘 _ 了 我 _
  在
  悠 久 的 坟 墓 中
  迷 _ 惘 _ _ 阳
  光 不 升 起 也 不 消 _
  翳 我
  我 也 许 也 许
  还 记 得 你 _ 我
  也 许 把 你 忘 _
}

lyricVerseTwo = \lyricmode {
  再 _ 见 不 到
  地 _ 面 的 青 荫
  觉 _ 不 到 雨
  露 的 甜 蜜 我
  再 _ 听 不 到
  夜 莺 的 歌 喉 在
  黑 _ _ 夜 里 _
  倾 诉 悲 啼 _
  在
  悠 久 的 坟 墓 中
  迷 _ 惘 _ _ 阳
  光 不 升 起 也 不 消 _
  翳 我
  我 也 许 也 许
  还 记 得 你 _ 我
  也 许 把 你 忘 _
  记 我
  我 也 许 也 许
  还 记 得 你 _ 我
  也 许 把 你 忘 _
  记 我
  我 也 许 也 许
  还 记 得 你 _ 我
  也 许 把 你 忘 _
}

\score {
  \transpose c d <<
    \new ChordNames {
      \set chordChanges = ##t
      \harmony
    }
    \new Staff {
      \new Voice = "mel" { \melody }
    }
    \new Lyrics \lyricsto "mel" {
      \lyricIntro
      <<
        { \lyricVerseOne }
        \new Lyrics {
          \set associatedVoice = "mel"
          \lyricVerseTwo
        }
      >>
    }
  >>
  \layout {}
  \midi {}
}
