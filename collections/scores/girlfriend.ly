\version "2.20.0"
\header {
  title = "girlfriend"
  composer = "古川本舖"
  arranger = "SilverRainZ"
  copyright = "SilverRainZ"
}

symbols =  {
  \time 4/4
  \tempo 4 = 80

  c8 d e e      e4 d8 e8~
  e4 d8 e       a,4 d8 e
  d4 c8 c8      c4 d8 e 
  g4

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
