\version "2.20.0"
\header {
  title = "Sea to Sea"
  subtitle = "(二重奏)"
  composer = "A Mordern Method for Guitar"
}

symbolsGuitarA =  {
  \time 4/4
  \tempo 4 = 75

  r1

  % 1
  <e g c'>2 <f a c'>
  <e g c'>2 <f g b>
  <e g c'>1
  <c e g>1

  % 4
  <c f a>2 <c f a>
  <d g b>2 <f g b>
  <f g c'>1
  <e g c'>1

  % 8
  <e g c'>2 <f a c'>
  <e g c'>2 <f g b>
  <e g c'>1
  <c e g>1

  % 12
  <c f a>2 <c f a>
  <d g b>2 <f g b>
  <f g c'>1
  <e g c'>4 b a g

  % 16
  f4 a2 f4
  e4 g2 e4
  d4 f a b
  c'4 b a g

  % 20
  <a c'>2 <a c'>
  <g b>2  <g b>
  <f a>1
  <b g>2 <f g b>

  % 24
  <e g c'>2 <f a c'>
  <e g c'>2 <f g b>
  <e g c'>1
  <c e g>1

  % 28
  <c f a>2 <c f a>
  <d g b>2 <f g b>
  <f g c'>1
  <e g c'>1

  \bar "|."
}

symbolsGuitarB =  {
  \time 4/4
  \tempo 4 = 75

  \drums { hh4 hh hh hh }

  % 1
  c'4 g a f
  g4 e f d
  e4 c e g 
  c'4 b a g \break
  
  % 4
  e4 d2 e4
  b4 g2 b4
  c'4 g a f
  e4 g c g \break
  
  % 8
  c'4 g a f
  g4 e f d
  e4 c e g
  c4 b a g \break
  
  % 12
  e4 d2 e4
  b4 g2 b4
  c'4 g a f
  e4 g c2 \break
  
  % 16
  <c' a>2 <c' a>
  <b g>2  <b g>
  <a f>2  <a f>
  <g e>1 \break
  
  % 20
  f4 a2 f4
  e4 g2 e4
  d4 f a c'
  b4 g g g \break
  
  % 24
  c'4 g a f
  g4 e f d
  e4 c e g
  c'4 b a g \break
  
  % 28
  f4 d2 f4
  b4 g2 b4
  c'4 g a f
  e4 g c2 \bar "|."
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
