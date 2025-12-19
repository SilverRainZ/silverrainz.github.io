==========
小型三和弦
==========

.. term:: _

   用 1 2 3 三根高音弦上构建三和弦或其转位，构建旋律线，辅助理解指板。

低把位
   .. lily::

      \version "2.24.0"

      \include "small-triads.ly"
      \lowPositionTriads 

      the-triads = \chordmode {
         c d:m e:m f g a:m
      }

      \score {
        <<
         \new FretBoards \the-triads
         \new Voice = "chords" \the-triads
         \new ChordNames \the-triads
         \new Lyrics \lyricsto "chords" {
            \override LyricText.font-size = #-1
            "1 3 5" "2 4 6" "7 3 5" "1 4 6" "7 2 5" "1 3 6"
         }
        >>
      }

中把位
   .. lily::

      \version "2.24.0"

      \include "small-triads.ly"
      \mediumPositionTriads

      the-triads = \chordmode {
         c d:m e:m f g a:m
      }

      \score {
        <<
         \new FretBoards \the-triads
         \new Voice = "chords" \the-triads
         \new ChordNames \the-triads
         \new Lyrics \lyricsto "chords" {
            \override LyricText.font-size = #-1
            "3 5 1" "4 6 2" "3 5 7" "4 6 1" "2 5 7" "3 6 1"
         }
        >>
      }

高把位
   .. todo:: 高把位
