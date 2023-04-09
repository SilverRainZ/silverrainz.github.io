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
  \time 2/4
  \tempo 4 = 70

  d8 e fis g
  a4 fis8 d
  d'4 b8 g
  a8 a fis4

  d8 e fis g
  a8 fis e d
  e4 fis
  e4 a

  d8 e fis g
  a4 fis8 d
  d'4 b8 g
  a4 fis

  d8 e fis g
  a8 fis e d
  e4 fis
  d4 d

  d'4 b8 g
  a8 a d4
  d'4 b8 g
  a4 fis4

  d8 e fis g
  a8 fis e d
  e4 fis
  d4 d
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
