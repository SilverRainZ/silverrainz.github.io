\paper {

scoreTitleMarkup = ##f

bookTitleMarkup = ##f

evenHeaderMarkup = ##f

oddHeaderMarkup = ##f

evenFooterMarkup = ##f

oddFooterMarkup = ##f
}
\version "2.20.0"
\header {
  title = "Minuet in G"

tagline = ##f
}

snippetA = {
  g4 c8 d e f
  g4 c c
  a4 f8 g a b
  c'4 c c
}

symbols = {
  \time  3/4
  \tempo 4 = 100
  \key   c \major

  % 1-4
  \snippetA
  \break

  % 5-8
  f4 g8 f e d
  e4 f8 e d c
  b,4 c8 d e c
  e4 d2
  \break

  % 9-12
  \snippetA
  \break

  % 13-16
  f4 g8 f e d
  e4 f8 e d4
  d4 e8 d c b,
  c2.
  \break

  % 17-20
  e'4 c'8 d' e' c'
  d'4 g8 a b g
  c'4 a8 b c' g
  fis4 e8 fis d4
  \break

  % 21-24
  d8 e fis g a b
  c'4 b a
  b4 d fis
  g2.
  \break

  % 25-28
  % FIXME: d'2. ...
  g4 c8 b, c4
  % FIXME: e'2. ...
  a4 c8 b, c4
  g4 f e
  d8 c b, c d4
  \break

  % 29-32
  g,8 a, b, c d e
  f4 e d
  e8 g c4 b,
  c2.

  \bar "|."
}

\score {
  <<
    \new Staff \with {midiInstrument = "acoustic guitar (nylon)"} {
      \clef "G_8"
      \symbols
    }
  >>

  \midi { }
  \layout { }
}
