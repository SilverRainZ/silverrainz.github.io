\version "2.20.0"

symbols =  {
  \time 4/4
  \tempo 4 = 70

  \drums { hh4 hh hh hh }
 
  c4 d e f
  g4 a b c'

  c'4 b a g
  f4 e d c

  \drums { hh4 hh hh hh }

  c4 d c2
  c4 e c2
  c4 f c2
  c4 g c2
  c4 a c2
  c4 b c2
  c4 c' c2
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
