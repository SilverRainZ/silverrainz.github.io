\version "2.20.0"
\include "predefined-guitar-fretboards.ly"

chordsline = \chordmode { c1 c:7 f:maj7 }

\score {
   <<
   \new ChordNames { \chordsline }
   \new FretBoards { \chordsline }
   >>

   \layout {}
}