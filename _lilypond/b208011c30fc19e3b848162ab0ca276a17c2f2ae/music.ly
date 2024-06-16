 \version "2.20.0"
 \header {
   title = "Mi Fa's Song"
   copyright = "SilverRainZ"
 }

 symbols =  {
   \time 4/4
   \tempo  "Allegro" 4 = 75

    %1
    e'4. f'8 e'4. f'8
    e'4 f'8 e'4. e8 d'
    c'8 d' f'4 e'4
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

