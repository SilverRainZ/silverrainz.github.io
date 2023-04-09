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

  a,4 a, a, a,
 
  a,4 b, cis d
  e4 fis gis a

  a4 gis fis e
  d4 cis b, a,

  a,4 a, a, a,

  a,4 b, a,2
  a,4 cis a,2
  a,4 d a,2
  a,4 e a,2
  a,4 fis a,2
  a,4 gis a,2
  a,4 a a,2
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
