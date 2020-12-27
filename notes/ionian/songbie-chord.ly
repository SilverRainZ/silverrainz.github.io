\version "2.20.0"
\header {
  title = "送别，伴奏"
  composer = "John P. Ordway"
}

symbols = {
  \time 4/4
  \tempo "Andante" 4 = 80

  r1

  \repeat volta 2 {
    <a cis' e'>1
    <d' fis' a'>2 <a cis' e'>
    <a cis' e'>1
    <e gis b d'>1

    <a cis' e'>1
    <d' fis' a'>2 <a cis' e'>
    <a cis' e'>1
    <e gis b d'>1

    <d fis a>1
    <e gis b d'>2 <a cis' e'>
    <d' fis' a'>2 <a cis' e'>
    <e gis b d'>1

    <a cis' e'>1
    <d' fis' a'>2 <a cis' e'>
    <e gis b d'>1
    <a cis' e'>1
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
