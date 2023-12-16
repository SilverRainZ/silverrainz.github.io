\version "2.20.0"
\header {
  title = "One, Two, Tree, Four"
  subtitle = "(二重奏)"
  composer = "A Mordern Method for Guitar"

}

snippetA =  {
  <e g c'>2 <e g c'>
  <f g d'>2 <f g d'>2
  <g c' e'>2 <g c' e'>
  <a c' f'>1
}

snippetB =  {
  <g b g'>2 <g b f'>
  <f a>2 <f g b>
  <f a c'>2 <f g d'>
}

symbolsGuitarA =  {
  \time 4/4
  \tempo 4 = 75

  \drums { hh4 hh hh hh }

  % 1
  \snippetA \break

  % 4
  \snippetB
  <e g c'>4 g a b  \break

  % 8
  \snippetA \break

  % 12
  \snippetB
  <e g c'>4 g f e \break

  % 16
  d4 d2 e4
  f4 f2 g4
  a4 g2 f4
  e4 b a g \break

  % 20
  <f a>2 <g b>
  <a c'>2 d'4 e'
  <a c' f'>2 <f a>
  <f g d'>2 <f g b> \break

  % 24
  \snippetA \break

  % 28
  \snippetB
  <e g c'>1 \break

  \bar "|."
}

symbolsGuitarB =  {
  r1

  % 1
  c4 e2 g4
  c'4 b2 a4
  a4 g2 c4
  d4 f a c'

  % 4
  e'4 d'2 a4
  c'4 b2 f'4
  a4 g2 f4
  e1

  % 8
  c4 e2 g4
  c'4 b2 a4
  a4 g2 c4
  d4 f a c'

  % 12
  e'4 d'2 a4
  c'4 b2 f4
  a4 g2 b4
  c'1

  % 16
  <f a>2 <g b>
  <a c'>2 d'4 e'
  <b f'>2 <b g'>  % TODO: 指法
  <c' e'>1

  % 20
  d4 d2 e4
  f4 f2 g4
  a4 d'2 c'4
  b4 g f d

  % 24
  c4 e2 g4
  c'4 b2 a4
  a4 g2 c4
  d4 f a c'

  % 28
  e'4 d'2 a4
  c'4 b2 f4
  a4 g2 b4
  c'4 g c2
}

\score {
  <<
    \new Staff \with {midiInstrument = "acoustic guitar (nylon)"} {
      \clef "G_8"
      \symbolsGuitarA
    }
    \new Staff \with {midiInstrument = "acoustic guitar (nylon)"} {
      \clef "G_8"
      \symbolsGuitarB
    }
  >>
  \midi { }
  \layout { }
}
