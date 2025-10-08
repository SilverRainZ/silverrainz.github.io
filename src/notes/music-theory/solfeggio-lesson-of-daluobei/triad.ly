\version "2.20.0"

symbols =  {
  \time 4/4
  \tempo 4 = 100

  c2 e g <c e g> 
  c ees g <c ees g> 

  d fis a <d fis a> 
  d f a <d f a>
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
