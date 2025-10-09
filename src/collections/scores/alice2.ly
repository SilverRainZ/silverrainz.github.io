\version "2.24.0"

symbols =  {
  \time 4/4
  \tempo  "Allegro" 4 = 150

  e8 d4 c4 c4.
  c4 g g2
  c2 d4 d
  c4 d e2
  \break

  e8 d4 c4 c4.
  c4 g g2
  c2 d4 f
  e4 c c2
  \break

  e8 d4 c4 c4.
  c4 g g2
  c2 d4 d
  c4 d e2
  \break

  c4 e g2
  g4 c' c'2
  c2 e
  d2 c

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
