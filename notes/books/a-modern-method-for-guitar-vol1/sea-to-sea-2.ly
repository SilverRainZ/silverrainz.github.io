\version "2.20.0"
\header {
  title = "Sea to Sea, Guitar 2"
  composer = "A Mordern Method for Guitar"

}

symbols =  {
  \time 4/4
  \tempo 4 = 50

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
      \symbols
    }
  >>

  \midi { }
  \layout { }
}
