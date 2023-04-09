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
  \key d \major
  \time 4/4
  \tempo "Andante" 4 = 80

  r1

  \repeat volta 2 {
    <d fis a>1
    <g b d'>2 <d fis a>
    <d fis a>1
    <a, cis e g>1

    <d fis a>1
    <g b d'>2 <d fis a>
    <d fis a>1
    <a, cis e g>1

    <g, b, d>1
    <a, cis e g>2 <d fis a>
    <g b d'>2 <d fis a>
    <a, cis e g>1

    <d fis a>1
    <g b d'>2 <d fis a>
    <a, cis e g>1
    <d fis a>1
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
