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
     \tempo 4=60 \mark \markup{1=D\flat} \time 4/4 #(define (note-three grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "3")))))))
  \applyOutput #'Voice #note-three e'4.
#(define (note-five grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "5")))))))
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[]
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-five g'4
 ~ #(define (note-dashfive grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "–")))))))
  \applyOutput #'Voice #note-dashfive g'4
| %{ bar 2: %}
  \applyOutput #'Voice #note-three e'4.
#(define (note-two grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "2")))))))
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[]
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0 #(define (note-one grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "1")))))))
  \applyOutput #'Voice #note-one c'4
 ~ #(define (note-dashone grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "–")))))))
  \applyOutput #'Voice #note-dashone c'4
| %{ bar 3: %}
  \applyOutput #'Voice #note-two d'4.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[]
  \applyOutput #'Voice #note-five g'4. \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[]
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0 | %{ bar 4: %}
  \applyOutput #'Voice #note-two d'4
 ~ \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0 #(define (note-dashtwo grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "–")))))))
  \applyOutput #'Voice #note-dashtwo d'4
 ~ \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-dashtwo d'4
 ~   \applyOutput #'Voice #note-dashtwo d'4 | %{ bar 5: %}
  \applyOutput #'Voice #note-three e'4.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[]
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-five g'4
 ~   \applyOutput #'Voice #note-dashfive g'4 | %{ bar 6: %}
  \applyOutput #'Voice #note-three e'4.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[]
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-one c'4
 ~   \applyOutput #'Voice #note-dashone c'4 | %{ bar 7: %}
  \applyOutput #'Voice #note-two d'4.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[]
  \applyOutput #'Voice #note-two d'4. \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[]
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0 | %{ bar 8: %}
  \applyOutput #'Voice #note-one c'4
 ~ \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-dashone c'4
 ~ \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-dashone c'4
 ~   \applyOutput #'Voice #note-dashone c'4 #(define (note-six grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "6")))))))
| %{ bar 9: %}
  \applyOutput #'Voice #note-six a'4.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8[]^.
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-one c''4^.
 ~   \applyOutput #'Voice #note-dashone c''4 #(define (note-seven grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "7")))))))
| %{ bar 10: %}
  \applyOutput #'Voice #note-seven b'4
  \applyOutput #'Voice #note-five g'4 \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-six a'4
 ~ #(define (note-dashsix grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "–")))))))
  \applyOutput #'Voice #note-dashsix a'4
| %{ bar 11: %}
  \applyOutput #'Voice #note-six a'4
  \applyOutput #'Voice #note-one c''4^.   \applyOutput #'Voice #note-seven b'4   \applyOutput #'Voice #note-five g'4 \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0 | %{ bar 12: %}
  \applyOutput #'Voice #note-six a'4
 ~ \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-dashsix a'4
 ~ \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-dashsix a'4
 ~   \applyOutput #'Voice #note-dashsix a'4 | %{ bar 13: %}
  \applyOutput #'Voice #note-three e'4.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[]
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-five g'4
 ~   \applyOutput #'Voice #note-dashfive g'4 | %{ bar 14: %}
  \applyOutput #'Voice #note-three e'4.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[]
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-one c'4
 ~   \applyOutput #'Voice #note-dashone c'4 | %{ bar 15: %}
  \applyOutput #'Voice #note-two d'4.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[]
  \applyOutput #'Voice #note-five g'4. \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[]
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0 | %{ bar 16: %}
  \applyOutput #'Voice #note-two d'4
 ~ \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-dashtwo d'4
 ~ \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-dashtwo d'4
 ~   \applyOutput #'Voice #note-dashtwo d'4 | %{ bar 17: %}
  \applyOutput #'Voice #note-three e'4.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8[]
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-five g'4
 ~   \applyOutput #'Voice #note-dashfive g'4 | %{ bar 18: %}
  \applyOutput #'Voice #note-one c''4^.
  \applyOutput #'Voice #note-two d''4^. \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-three e''4^.
 ~ #(define (note-dashthree grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "–")))))))
  \applyOutput #'Voice #note-dashthree e''4
| %{ bar 19: %}
  \applyOutput #'Voice #note-two d''4^.
  \applyOutput #'Voice #note-one c''4^.   \applyOutput #'Voice #note-two d''4^.   \applyOutput #'Voice #note-six a'4 \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0 | %{ bar 20: %}
  \applyOutput #'Voice #note-one c''4^.
 ~ \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-dashone c''4
 ~ \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-dashone c''4
 ~   \applyOutput #'Voice #note-dashone c''4 \bar "|." } }
% === END JIANPU STAFF ===

>>
\header{
title="E 小调第 9 号交响曲《自新大陆》第二乐章 节选"
}
\layout{} }
\score {
\unfoldRepeats
<< 

% === BEGIN MIDI STAFF ===
    \new Staff { \new Voice="X" { \tempo 4=60 \transpose c des { \key c \major  \time 4/4 e'4. g'8 g'2 | %{ bar 2: %} e'4. d'8 c'2 | %{ bar 3: %} d'4. e'8 g'4. e'8 | %{ bar 4: %} d'1 | %{ bar 5: %} e'4. g'8 g'2 | %{ bar 6: %} e'4. d'8 c'2 | %{ bar 7: %} d'4. e'8 d'4. c'8 | %{ bar 8: %} c'1 | %{ bar 9: %} a'4. c''8 c''2 | %{ bar 10: %} b'4 g'4 a'2 | %{ bar 11: %} a'4 c''4 b'4 g'4 | %{ bar 12: %} a'1 | %{ bar 13: %} e'4. g'8 g'2 | %{ bar 14: %} e'4. d'8 c'2 | %{ bar 15: %} d'4. e'8 g'4. e'8 | %{ bar 16: %} d'1 | %{ bar 17: %} e'4. g'8 g'2 | %{ bar 18: %} c''4 d''4 e''2 | %{ bar 19: %} d''4 c''4 d''4 a'4 | %{ bar 20: %} c''1 } } }
% === END MIDI STAFF ===

>>
\header{
title="E 小调第 9 号交响曲《自新大陆》第二乐章 节选"
}
\midi { \context { \Score tempoWholesPerMinute = #(ly:make-moment 84 4)}} }
