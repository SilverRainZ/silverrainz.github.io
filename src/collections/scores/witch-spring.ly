\version "2.24.0"
\header {
  title = "《魔女之泉 1》开场音乐"
  composer = "Kiwi Walks"
  arranger = "SilverRainZ"
}

symbols =  {
  \time 4/4
  \tempo  "Allegretto" 4 = 110

  % 1
  c'4 c' c' c'8 b8
  c'4 g' c' c'8 b8
  c'4 g' (ais') c''8 b'8
  c''2 r2 \break

  %14
  e'4 g c'2
  a8 c'8 c'8 d'8 c'2

  e'4 g' c'2
  c'4 d'8 e'8 c'4 g \break

  e'4 g c'2
  a8 c'8 c'8 d'8 e'4 c'

  g4 f e f8 g8

  \bar "|."
}

\score {
  <<
    \new Staff \with {midiInstrument = "acoustic guitar (nylon)"} {
      \clef "G_8"
      \symbols
    }
    % \new TabStaff {
    %   \tabFullNotation
    %   \symbols
    % }
  >>

  \midi { }
  \layout { }
}
