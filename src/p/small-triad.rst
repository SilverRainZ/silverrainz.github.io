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
         c d:m e:m f g a:m g
      }

      \score {
        <<
         \new FretBoards \the-triads
         \new ChordNames \the-triads
        >>
      }

中把位
   .. lily::

      \version "2.24.0"

      \include "small-triads.ly"
      \mediumPositionTriads

      the-triads = \chordmode {
         c d:m e:m f g a:m g
      }

      \score {
        <<
         \new FretBoards \the-triads
         \new ChordNames \the-triads
        >>
      }

高把位
   .. todo:: 高把位
