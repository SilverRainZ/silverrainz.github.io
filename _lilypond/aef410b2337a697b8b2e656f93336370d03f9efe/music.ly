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
  \key e \major
  \time 4/4
  \tempo "Andante" 4 = 80

  r1

  \repeat volta 2 {
    <e gis b>1
    <a cis' e'>2 <e gis b>
    <e gis b>1
    <b, dis fis a>1

    <e gis b>1
    <a cis' e'>2 <e gis b>
    <e gis b>1
    <b, dis fis a>1

    <a, cis e>1
    <b, dis fis a>2 <e gis b>
    <a cis' e'>2 <e gis b>
    <b, dis fis a>1

    <e gis b>1
    <a cis' e'>2 <e gis b>
    <b, dis fis a>1
    <e gis b>1
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
