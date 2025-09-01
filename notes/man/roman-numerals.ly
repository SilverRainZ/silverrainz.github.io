\version "2.24.0"

#(define (romanNumeralChordEngraver cx)
   (let ((tonic #{ c #}))
     (make-engraver
       ((initialize engraver)
        (set!
          (ly:context-property cx 'chordRootNamer)
          (lambda
            (pitch capitalized)
            (let
              ((degree (1+ (ly:pitch-notename (ly:pitch-diff pitch tonic)))))
              (number-format 'roman-upper degree)))))
       (listeners
         ((key-change-event engraver event)
          (set!tonic (ly:event-property event 'tonic)))))))

\layout {
  \context {
    \ChordNames
    \consists #romanNumeralChordEngraver
  }
}

\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t \chordmode {
        c1 d:m e:m f g:7 a:m b:7
      }
    }
  >>
}

