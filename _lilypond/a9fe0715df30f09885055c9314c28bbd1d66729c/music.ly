\version "2.20.0"
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

%{ The jianpu-ly input was:
% http://ssb22.user.srcf.net/mwrhome/jianpu-ly.html

NoBarNums % break heigth of chore names

title=送别
4=80
1=A
4/4

chords= a1 d2 a2 a1 e:7 a1 d2 a2 a1 e:7 d1 e:7 a2 d2 a2 e:7 a1 d2 a2 e:7 a1

5 q3 q5 1' -
6  q1' q6 5 -
5 q1 q2 3 q2 q1 
2  - - 0
\break

5 q3 q5 1'. q7
6 1' 5 -
5 q2 q3 4. q7,
1 - . 0
\break

6 ^"低八度" 1' 1' 0
7 q6 q7 1' ^"I" 0
q6 q7 q1' q6 q6 q5 q3 q1
2 - . 0
\break

5 q3 q5 1'. q7
6 1' 5 -
5 q2 q3 4. q7,
1 - . 0
%}


\score {
<< \override Score.BarNumber #'break-visibility = #center-visible
\override Score.BarNumber #'Y-offset = -1
\set Score.barNumberVisibility = #(every-nth-bar-number-visible 5)
\new ChordNames { \chordmode { a1 d2 a2 a1 e:7 a1 d2 a2 a1 e:7 d1 e:7 a2 d2 a2 e:7 a1 d2 a2 e:7 a1 } }

%% === BEGIN JIANPU STAFF ===
    \new RhythmicStaff \with {
    \consists "Accidental_engraver" 
    %% Get rid of the stave but not the barlines:
    \override StaffSymbol #'line-count = #0 %% tested in 2.15.40, 2.16.2, 2.18.0, 2.18.2, 2.20.0 and 2.22.2
    \override BarLine #'bar-extent = #'(-2 . 2) %% LilyPond 2.18: please make barlines as high as the time signature even though we're on a RhythmicStaff (2.16 and 2.15 don't need this although its presence doesn't hurt; Issue 3685 seems to indicate they'll fix it post-2.18)
    }
    { \new Voice="W" {
    \override Beam #'transparent = ##f
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
     \tempo 4=80 \mark \markup{1=A} \time 4/4 #(define (note-five grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "5")))))))
  \applyOutput #'Voice #note-five g'4
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
  \applyOutput #'Voice #note-three e'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0 #(define (note-one grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "1")))))))
  \applyOutput #'Voice #note-one c''4^.
 ~ #(define (note-dashone grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "–")))))))
  \applyOutput #'Voice #note-dashone c''4
#(define (note-six grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "6")))))))
| %{ bar 2: %}
  \applyOutput #'Voice #note-six a'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c''8[^.
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8]
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
| %{ bar 3: %}
  \applyOutput #'Voice #note-five g'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8[
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
  \applyOutput #'Voice #note-two d'8]
  \applyOutput #'Voice #note-three e'4 \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8]
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
 ~   \applyOutput #'Voice #note-dashtwo d'4 #(define (note-nought grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "0")))))))
  \applyOutput #'Voice #note-nought r4
\break | %{ bar 5: %}
  \applyOutput #'Voice #note-five g'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
  \applyOutput #'Voice #note-one c''4.^. #(define (note-seven grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "7")))))))
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8[]
| %{ bar 6: %}
  \applyOutput #'Voice #note-six a'4
  \applyOutput #'Voice #note-one c''4^. \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-five g'4
 ~   \applyOutput #'Voice #note-dashfive g'4 | %{ bar 7: %}
  \applyOutput #'Voice #note-five g'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8]
#(define (note-four grob grob-origin context)
  (if (and (eq? (ly:context-property context 'chordChanges) #t)
      (or (grob::has-interface grob 'note-head-interface)
        (grob::has-interface grob 'rest-interface)))
    (begin
      (ly:grob-set-property! grob 'stencil
        (grob-interpret-markup grob
          (make-lower-markup 0.5 (make-bold-markup "4")))))))
  \applyOutput #'Voice #note-four f'4.
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b8[]-\tweak #'X-offset #0.6 _.
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0 | %{ bar 8: %}
  \applyOutput #'Voice #note-one c'4
 ~ \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-dashone c'4
 ~   \applyOutput #'Voice #note-dashone c'4   \applyOutput #'Voice #note-nought r4 \break | %{ bar 9: %}
  \applyOutput #'Voice #note-six a'4
^"低八度"   \applyOutput #'Voice #note-one c''4^.   \applyOutput #'Voice #note-one c''4^.   \applyOutput #'Voice #note-nought r4 | %{ bar 10: %}
  \applyOutput #'Voice #note-seven b'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8]
  \applyOutput #'Voice #note-one c''4^. ^"I"   \applyOutput #'Voice #note-nought r4 | %{ bar 11: %} \set stemLeftBeamCount = #0
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
  \applyOutput #'Voice #note-six a'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-six a'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-one c'8]
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0 | %{ bar 12: %}
  \applyOutput #'Voice #note-two d'4
 ~ \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-dashtwo d'4
 ~   \applyOutput #'Voice #note-dashtwo d'4   \applyOutput #'Voice #note-nought r4 \break | %{ bar 13: %}
  \applyOutput #'Voice #note-five g'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-five g'8]
  \applyOutput #'Voice #note-one c''4.^. \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b'8[]
| %{ bar 14: %}
  \applyOutput #'Voice #note-six a'4
  \applyOutput #'Voice #note-one c''4^. \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-five g'4
 ~   \applyOutput #'Voice #note-dashfive g'4 | %{ bar 15: %}
  \applyOutput #'Voice #note-five g'4
\set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-two d'8[
\set stemLeftBeamCount = #1
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-three e'8]
  \applyOutput #'Voice #note-four f'4. \set stemLeftBeamCount = #0
\set stemRightBeamCount = #1
  \applyOutput #'Voice #note-seven b8[]-\tweak #'X-offset #0.6 _.
\once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0 | %{ bar 16: %}
  \applyOutput #'Voice #note-one c'4
 ~ \once \override Tie #'transparent = ##t \once \override Tie #'staff-position = #0   \applyOutput #'Voice #note-dashone c'4
 ~   \applyOutput #'Voice #note-dashone c'4   \applyOutput #'Voice #note-nought r4 \bar "|." } }
% === END JIANPU STAFF ===

>>
\header{
title="送别"
}
\layout{ \context { \Score \remove "Bar_number_engraver" } } }
\score {
\unfoldRepeats
<< 
\new ChordNames { \chordmode { a1 d2 a2 a1 e:7 a1 d2 a2 a1 e:7 d1 e:7 a2 d2 a2 e:7 a1 d2 a2 e:7 a1 } }

% === BEGIN MIDI STAFF ===
    \new Staff { \new Voice="X" { \tempo 4=80 \transpose c a, { \key c \major  \time 4/4 g'4 e'8 g'8 c''2 | %{ bar 2: %} a'4 c''8 a'8 g'2 | %{ bar 3: %} g'4 c'8 d'8 e'4 d'8 c'8 | %{ bar 4: %} d'2. r4 \break | %{ bar 5: %} g'4 e'8 g'8 c''4. b'8 | %{ bar 6: %} a'4 c''4 g'2 | %{ bar 7: %} g'4 d'8 e'8 f'4. b8 | %{ bar 8: %} c'2. r4 \break | %{ bar 9: %} a'4 ^"低八度" c''4 c''4 r4 | %{ bar 10: %} b'4 a'8 b'8 c''4 ^"I" r4 | %{ bar 11: %} a'8 b'8 c''8 a'8 a'8 g'8 e'8 c'8 | %{ bar 12: %} d'2. r4 \break | %{ bar 13: %} g'4 e'8 g'8 c''4. b'8 | %{ bar 14: %} a'4 c''4 g'2 | %{ bar 15: %} g'4 d'8 e'8 f'4. b8 | %{ bar 16: %} c'2. r4 } } }
% === END MIDI STAFF ===

>>
\header{
title="送别"
}
\midi { \context { \Score tempoWholesPerMinute = #(ly:make-moment 84 4)}} }