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
  \key c \major
  \time 4/4
  \tempo "Andante" 4 = 80

  r1

  \repeat volta 2 {
    <c e g>1
    <f a c'>2 <c e g>
    <c e g>1
    <g, b, d f>1

    <c e g>1
    <f a c'>2 <c e g>
    <c e g>1
    <g, b, d f>1

    <f, a, c>1
    <g, b, d f>2 <c e g>
    <f a c'>2 <c e g>
    <g, b, d f>1

    <c e g>1
    <f a c'>2 <c e g>
    <g, b, d f>1
    <c e g>1
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
