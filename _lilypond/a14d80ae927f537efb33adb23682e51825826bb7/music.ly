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

  a8 b cis' d'
  e'4 cis'8 a
  a'4 fis'8 d'
  e'8 e' cis'4

  a8 b cis' d'
  e'8 cis' b a
  b4 cis'
  b4 e'

  a8 b cis' d'
  e'4 cis'8 a
  a'4 fis'8 d'
  e'4 cis'

  a8 b cis' d'
  e'8 cis' b a
  b4 cis'
  a4 a

  a'4 fis'8 d'
  e'8 e' a4
  a'4 fis'8 d'
  e'4 cis'4

  a8 b cis' d'
  e'8 cis' b a
  b4 cis'
  a4 a
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
