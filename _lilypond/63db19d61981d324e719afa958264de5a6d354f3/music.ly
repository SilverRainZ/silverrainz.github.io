\paper {

scoreTitleMarkup = ##f

bookTitleMarkup = ##f

evenHeaderMarkup = ##f

oddHeaderMarkup = ##f

evenFooterMarkup = ##f

oddFooterMarkup = ##f
}
\version "2.20.0"
\header {
  title = "送别，伴奏"
  composer = "John P. Ordway"

tagline = ##f
}

symbols = {
  \key b \major
  \time 4/4
  \tempo "Andante" 4 = 80

  r1

  \repeat volta 2 {
    <b dis' fis'>1
    <e' gis' b'>2 <b dis' fis'>
    <b dis' fis'>1
    <fis ais cis' e'>1

    <b dis' fis'>1
    <e' gis' b'>2 <b dis' fis'>
    <b dis' fis'>1
    <fis ais cis' e'>1

    <e gis b>1
    <fis ais cis' e'>2 <b dis' fis'>
    <e' gis' b'>2 <b dis' fis'>
    <fis ais cis' e'>1

    <b dis' fis'>1
    <e' gis' b'>2 <b dis' fis'>
    <fis ais cis' e'>1
    <b dis' fis'>1
  }
}

\score {
  <<
    \new Staff {
      \clef "G_8"
      \symbols
    }
  >>
  \layout { }
  \midi { }
}
