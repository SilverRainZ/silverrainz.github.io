\header { tagline = ##f }\paper {

scoreTitleMarkup = ##f

bookTitleMarkup = ##f

evenHeaderMarkup = ##f

oddHeaderMarkup = ##f

evenFooterMarkup = ##f

oddFooterMarkup = ##f
}
\version "2.20.0"

symbols =  {
  \time 4/4
  \tempo 4 = 70

  b,4 b, b, b,
 
  b,4 cis dis e
  fis4 gis ais b

  b4 ais gis fis
  e4 dis cis b,

  b,4 b, b, b,

  b,4 cis b,2
  b,4 dis b,2
  b,4 e b,2
  b,4 fis b,2
  b,4 gis b,2
  b,4 ais b,2
  b,4 b b,2
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
