% https://lists.gnu.org/archive/html/lilypond-user/2023-03/msg00001.html

\version "2.24.0"

#(define (romanNumeralChordEngraver cx)
   (let ((tonic #{ c #}))
     (make-engraver
       ((initialize engraver)
        (ly:context-set-property! cx 'chordRootNamer
        (lambda
          (pitch capitalized)
          (let
            ((degree (1+ (ly:pitch-notename (ly:pitch-diff pitch tonic))))
             (style (if capitalized 'roman-lower 'roman-upper)))
            (number-format style degree)))))
       (listeners
         ((key-change-event engraver event)
          (set! tonic (ly:event-property event 'tonic)))))))

\layout {
  \context {
    \ChordNames
    \consists #romanNumeralChordEngraver
  }
}

\score {
  <<
    \chords {
      \set chordNameLowercaseMinor = ##t
      \set chordChanges = ##t
      c1 d:m e:dim f:aug g:maj7 a:m7 b:7 c:dim7
    }
  >>
}
