\version "2.20.0"

symbols =  {
  \time 2/4
  \tempo 4 = 70

  c8 d e f
  g4 e8 c
  c'4 a8 f
  g8 g e4

  c8 d e f
  g8 e d c
  d4 e
  d4 g

  c8 d e f
  g4 e8 c
  c'4 a8 f
  g4 e

  c8 d e f
  g8 e d c
  d4 e
  c4 c

  c'4 a8 f
  g8 g c4
  c'4 a8 f
  g4 e4

  c8 d e f
  g8 e d c
  d4 e
  c4 c
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
