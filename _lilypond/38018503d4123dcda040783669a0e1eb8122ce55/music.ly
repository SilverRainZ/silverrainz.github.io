\version "2.20.0"

symbols =  {
  \time 4/4
  \tempo 4 = 70

  c4 d c2
  c4 cis c2

  cis4 dis cis2
  cis4 d cis2

  d4 e d2
  d4 dis d2

  dis4 eis dis2
  dis4 e dis2

  e4 fis e2
  e4 f e2

  f4 g f2
  f4 fis f2

  fis4 gis fis2
  fis4 g fis2

  g4 a g2
  g4 gis g2

  gis4 ais gis2
  gis4 a gis2

  a4 b a2
  a4 ais a2

  ais4 bis ais2
  ais4 b ais2

  b4 cis' b2
  b4 c b2
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
