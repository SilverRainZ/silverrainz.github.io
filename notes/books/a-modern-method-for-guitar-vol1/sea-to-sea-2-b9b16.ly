\version "2.20.0"

symbols =  {
  \time 4/4
  \tempo 4 = 50

  \drums { hh4 hh hh hh }

  % 8
  c'4 g a f
  g4 e f d
  e4 c e g
  c4 b a g \break
  
  % 12
  e4 d2 e4
  b4 g2 b4
  c'4 g a f
  e4 g c2 \break
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
