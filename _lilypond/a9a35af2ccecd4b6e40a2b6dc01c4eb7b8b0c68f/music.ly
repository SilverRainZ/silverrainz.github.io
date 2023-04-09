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
  \key g \major
  \time 4/4
  \tempo "Andante" 4 = 80

  r1

  \repeat volta 2 {
    <g b d'>1
    <c' e' g'>2 <g b d'>
    <g b d'>1
    <d fis a c'>1

    <g b d'>1
    <c' e' g'>2 <g b d'>
    <g b d'>1
    <d fis a c'>1

    <c e g>1
    <d fis a c'>2 <g b d'>
    <c' e' g'>2 <g b d'>
    <d fis a c'>1

    <g b d'>1
    <c' e' g'>2 <g b d'>
    <d fis a c'>1
    <g b d'>1
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
