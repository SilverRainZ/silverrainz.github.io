\version "2.18.0"
#(set-global-staff-size 20)

% un-comment the next line to remove Lilypond tagline:
% \header { tagline="" }

\pointAndClickOff

\paper {
  print-all-headers = ##t %% allow per-score headers

  % un-comment the next line for A5:
  % #(set-default-paper-size "a5" )

  % un-comment the next line for no page numbers:
  % print-page-number = ##f

  % un-comment the next 3 lines for a binding edge:
  % two-sided = ##t
  % inner-margin = 20\mm
  % outer-margin = 10\mm

  % un-comment the next line for a more space-saving header layout:
  % scoreTitleMarkup = \markup { \center-column { \fill-line { \magnify #1.5 { \bold { \fromproperty #'header:dedication } } \magnify #1.5 { \bold { \fromproperty #'header:title } } \fromproperty #'header:composer } \fill-line { \fromproperty #'header:instrument \fromproperty #'header:subtitle \smaller{\fromproperty #'header:subsubtitle } } } }
}

\score {
<< \override Score.BarNumber #'break-visibility = #center-visible
\override Score.BarNumber #'Y-offset = -1
\set Score.barNumberVisibility = #(every-nth-bar-number-visible 5)

%% === BEGIN JIANPU STAFF ===
    \new RhythmicStaff \with {
    \consists "Accidental_engraver" 
   %% Limit space between Jianpu and corresponding-Western staff
   \override VerticalAxisGroup.staff-staff-spacing = #'((minimum-distance . 7) (basic-distance . 7) (stretchability . 0))

    %% Get rid of the stave but not the barlines:
    \override StaffSymbol #'line-count = #0 %% tested in 2.15.40, 2.16.2, 2.18.0, 2.18.2, 2.20.0 and 2.22.2
    \override BarLine #'bar-extent = #'(-2 . 2) %% LilyPond 2.18: please make barlines as high as the time signature even though we're on a RhythmicStaff (2.16 and 2.15 don't need this although its presence doesn't hurt; Issue 3685 seems to indicate they'll fix it post-2.18)
    }
    { \new Voice="W" {

    \override Beam #'transparent = ##f % (needed for LilyPond 2.18 or the above switch will also hide beams)
    \override Stem #'direction = #DOWN
    \override Tie #'staff-position = #2.5
    \tupletUp

    \override Stem #'length-fraction = #0
    \override Beam #'beam-thickness = #0.1
    \override Beam #'length-fraction = #0.5
    \override Voice.Rest #'style = #'neomensural % this size tends to line up better (we'll override the appearance anyway)
    \override Accidental #'font-size = #-4
    \override TupletBracket #'bracket-visibility = ##t
\set Voice.chordChanges = ##t %% 2.19 bug workaround

    \override Staff.TimeSignature #'style = #'numbered
    \override Staff.Stem #'transparent = ##t
     \tempo 4=130 \mark \markup{1=D} \time 4/4 #(define (note-five grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "5")))))))
  \applyOutput #'Voice #note-five g''4^.
#(define (note-three grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "3")))))))
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e''8[^.
#(define (note-four grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "4")))))))
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f''8]^.
  \applyOutput #'Voice #note-five g''4^. \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f''8]^.
| %{ bar 2: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
#(define (note-six grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "6")))))))
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
#(define (note-seven grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "7")))))))
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8]
#(define (note-one grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "1")))))))
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8[^.
#(define (note-two grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "2")))))))
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d''8]^.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f''8]^.
| %{ bar 3: %}
  \applyOutput #'Voice #note-three e''4^.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d''8]^.
  \applyOutput #'Voice #note-three e''4^. \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f'8]
| %{ bar 4: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8]^.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8]^.
| %{ bar 5: %}
  \applyOutput #'Voice #note-six a'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8]
  \applyOutput #'Voice #note-six a'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f'8]
| %{ bar 6: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8]^.
| %{ bar 7: %}
  \applyOutput #'Voice #note-six a'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8]
  \applyOutput #'Voice #note-one c''4^. \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
| %{ bar 8: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8]^.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8]^.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8]^.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8]
| %{ bar 9: %}
  \applyOutput #'Voice #note-five g''4^.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f''8]^.
  \applyOutput #'Voice #note-five g''4^. \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f''8]^.
| %{ bar 10: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d''8]^.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f''8]^.
| %{ bar 11: %}
  \applyOutput #'Voice #note-three e''4^.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d''8]^.
  \applyOutput #'Voice #note-three e''4^. \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f'8]
| %{ bar 12: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8]^.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8]^.
| %{ bar 13: %}
  \applyOutput #'Voice #note-six a'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8]
  \applyOutput #'Voice #note-six a'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f'8]
| %{ bar 14: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8]^.
| %{ bar 15: %}
  \applyOutput #'Voice #note-six a'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8]
  \applyOutput #'Voice #note-one c''4^. \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8]^.
| %{ bar 16: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8]^.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e''8]^.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g''8]^.
| %{ bar 17: %}
  \applyOutput #'Voice #note-five g''4^.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f''8]^.
  \applyOutput #'Voice #note-five g''4^. \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f''8]^.
| %{ bar 18: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d''8]^.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f''8]^.
| %{ bar 19: %}
  \applyOutput #'Voice #note-three e''4^.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d''8]^.
  \applyOutput #'Voice #note-three e''4^. \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f'8]
| %{ bar 20: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8]^.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8]^.
| %{ bar 21: %}
  \applyOutput #'Voice #note-six a'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8]
  \applyOutput #'Voice #note-six a'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f'8]
| %{ bar 22: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-four f'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8]^.
| %{ bar 23: %}
  \applyOutput #'Voice #note-six a'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8]
  \applyOutput #'Voice #note-one c''4^. \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
| %{ bar 24: %} \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8]^.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8]^.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8]^.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8]
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0 | %{ bar 25: %}
  \applyOutput #'Voice #note-one c''4^.
 ~ \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0 #(define (note-dashone grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "–")))))))
  \applyOutput #'Voice #note-dashone c''4
 ~ \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-dashone c''4
 ~   \applyOutput #'Voice #note-dashone c''4 \bar "|." } }
% === END JIANPU STAFF ===


%% === BEGIN 5-LINE STAFF ===
    \new Staff {
    \override Score.SystemStartBar.collapse-height = #11 % (needed on 2.22)
    \new Voice="X" {
    #(set-accidental-style 'modern-cautionary)
    \override Staff.TimeSignature #'style = #'numbered
    \set Voice.chordChanges = ##f % for 2.19.82 bug workaround
 \tempo 4=130 \transpose c d { \key c \major  \time 4/4 g''4 e''8 f''8 g''4 e''8 f''8 | %{ bar 2: %} g''8 g'8 a'8 b'8 c''8 d''8 e''8 f''8 | %{ bar 3: %} e''4 c''8 d''8 e''4 e'8 f'8 | %{ bar 4: %} g'8 a'8 g'8 f'8 g'8 c''8 b'8 c''8 | %{ bar 5: %} a'4 c''8 b'8 a'4 g'8 f'8 | %{ bar 6: %} g'8 f'8 e'8 f'8 g'8 a'8 b'8 c''8 | %{ bar 7: %} a'4 c''8 b'8 c''4 b'8 a'8 | %{ bar 8: %} b'8 c''8 d''8 c''8 b'8 c''8 a'8 b'8 | %{ bar 9: %} g''4 e''8 f''8 g''4 e''8 f''8 | %{ bar 10: %} g''8 g'8 a'8 b'8 c''8 d''8 e''8 f''8 | %{ bar 11: %} e''4 c''8 d''8 e''4 e'8 f'8 | %{ bar 12: %} g'8 a'8 g'8 f'8 g'8 c''8 b'8 c''8 | %{ bar 13: %} a'4 c''8 b'8 a'4 g'8 f'8 | %{ bar 14: %} g'8 f'8 e'8 f'8 g'8 a'8 b'8 c''8 | %{ bar 15: %} a'4 c''8 b'8 c''4 b'8 c''8 | %{ bar 16: %} b'8 a'8 b'8 c''8 d''8 e''8 f''8 g''8 | %{ bar 17: %} g''4 e''8 f''8 g''4 e''8 f''8 | %{ bar 18: %} g''8 g'8 a'8 b'8 c''8 d''8 e''8 f''8 | %{ bar 19: %} e''4 c''8 d''8 e''4 e'8 f'8 | %{ bar 20: %} g'8 a'8 g'8 f'8 g'8 c''8 b'8 c''8 | %{ bar 21: %} a'4 c''8 b'8 a'4 g'8 f'8 | %{ bar 22: %} g'8 f'8 e'8 f'8 g'8 a'8 b'8 c''8 | %{ bar 23: %} a'4 c''8 b'8 c''4 b'8 a'8 | %{ bar 24: %} b'8 c''8 d''8 c''8 b'8 c''8 a'8 b'8 | %{ bar 25: %} c''1 } \bar "|." } }
% === END 5-LINE STAFF ===

>>
\header{
title="Canon in D Major 节选"
}
\layout{} }
\score {
\unfoldRepeats
<< 

% === BEGIN MIDI STAFF ===
    \new Staff { \new Voice="Y" { \tempo 4=130 \transpose c d { \key c \major  \time 4/4 g''4 e''8 f''8 g''4 e''8 f''8 | %{ bar 2: %} g''8 g'8 a'8 b'8 c''8 d''8 e''8 f''8 | %{ bar 3: %} e''4 c''8 d''8 e''4 e'8 f'8 | %{ bar 4: %} g'8 a'8 g'8 f'8 g'8 c''8 b'8 c''8 | %{ bar 5: %} a'4 c''8 b'8 a'4 g'8 f'8 | %{ bar 6: %} g'8 f'8 e'8 f'8 g'8 a'8 b'8 c''8 | %{ bar 7: %} a'4 c''8 b'8 c''4 b'8 a'8 | %{ bar 8: %} b'8 c''8 d''8 c''8 b'8 c''8 a'8 b'8 | %{ bar 9: %} g''4 e''8 f''8 g''4 e''8 f''8 | %{ bar 10: %} g''8 g'8 a'8 b'8 c''8 d''8 e''8 f''8 | %{ bar 11: %} e''4 c''8 d''8 e''4 e'8 f'8 | %{ bar 12: %} g'8 a'8 g'8 f'8 g'8 c''8 b'8 c''8 | %{ bar 13: %} a'4 c''8 b'8 a'4 g'8 f'8 | %{ bar 14: %} g'8 f'8 e'8 f'8 g'8 a'8 b'8 c''8 | %{ bar 15: %} a'4 c''8 b'8 c''4 b'8 c''8 | %{ bar 16: %} b'8 a'8 b'8 c''8 d''8 e''8 f''8 g''8 | %{ bar 17: %} g''4 e''8 f''8 g''4 e''8 f''8 | %{ bar 18: %} g''8 g'8 a'8 b'8 c''8 d''8 e''8 f''8 | %{ bar 19: %} e''4 c''8 d''8 e''4 e'8 f'8 | %{ bar 20: %} g'8 a'8 g'8 f'8 g'8 c''8 b'8 c''8 | %{ bar 21: %} a'4 c''8 b'8 a'4 g'8 f'8 | %{ bar 22: %} g'8 f'8 e'8 f'8 g'8 a'8 b'8 c''8 | %{ bar 23: %} a'4 c''8 b'8 c''4 b'8 a'8 | %{ bar 24: %} b'8 c''8 d''8 c''8 b'8 c''8 a'8 b'8 | %{ bar 25: %} c''1 } } }
% === END MIDI STAFF ===

>>
\header{
title="Canon in D Major 节选"
}
\midi { \context { \Score tempoWholesPerMinute = #(ly:make-moment 84 4)}} }
