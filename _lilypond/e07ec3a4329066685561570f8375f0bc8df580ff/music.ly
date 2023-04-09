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
  \key f \major
  \time 4/4
  \tempo "Andante" 4 = 80

  r1

  \repeat volta 2 {
    <f a c'>1
    <bes d' f'>2 <f a c'>
    <f a c'>1
    <c e g bes>1

    <f a c'>1
    <bes d' f'>2 <f a c'>
    <f a c'>1
    <c e g bes>1

    <bes, d f>1
    <c e g bes>2 <f a c'>
    <bes d' f'>2 <f a c'>
    <c e g bes>1

    <f a c'>1
    <bes d' f'>2 <f a c'>
    <c e g bes>1
    <f a c'>1
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
