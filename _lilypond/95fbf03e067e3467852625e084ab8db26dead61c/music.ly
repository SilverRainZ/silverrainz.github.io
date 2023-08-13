\version "2.20.0"
\header {
  title = "girlfriend"
  composer = "古川本舖"
  arranger = "SilverRainZ"
  copyright = "SilverRainZ"
}

symbols =  {
  \time 4/4
  \tempo 4 = 70

  % 1-4
  c8 d e e      e4 d8 e8~
  e4 d8 e       a,4 d8 e
  d4 c8 c4      c4 d8 e4 
  g4. e8 d c d4
  \break

  % 5-8
  d8 c c d4. e8
  c4 b,8 c2 e8
  f g4 d d f4
  e e8 d c d4 e8
  \break

  c4 b,8 c2

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
