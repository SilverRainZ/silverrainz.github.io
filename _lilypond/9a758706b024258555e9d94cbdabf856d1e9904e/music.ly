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

  d4 d d d
 
  d4 e fis g
  a4 b cis' d'

  d'4 cis' b a
  g4 fis e d

  d4 d d d

  d4 e d2
  d4 fis d2
  d4 g d2
  d4 a d2
  d4 b d2
  d4 cis' d2
  d4 d' d2
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
