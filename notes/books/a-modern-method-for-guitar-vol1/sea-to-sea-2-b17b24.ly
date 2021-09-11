\version "2.20.0"

symbols =  {
  \time 4/4
  \tempo 4 = 50

  \drums { hh4 hh hh hh }
 
  % 16
  <c' a>2 <c' a>
  <b g>2  <b g>
  <a f>2  <a f>
  <g e>1 \break
  
  % 20
  f4 a2 f4
  e4 g2 e4
  d4 f a c'
  b4 g g g \break
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
