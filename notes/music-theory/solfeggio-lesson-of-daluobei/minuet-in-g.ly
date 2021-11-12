\version "2.20.0"
\header {
  title = "Minuet in G"
}

snippetA = {
  d'4 g8 a b c'
  d'4 g g
  e'4 c'8 d' e' fis'
  g'4 g g
}

symbols = {
  \time  3/4
  \tempo 4 = 100
  \key   g \major

  % 1-4
  \snippetA
  \break

  % 5-8
  c'4 d'8 c' b a
  b4 c'8 b a g
  fis4 g8 a b g
  b4 a2
  \break

  % 9-12
  \snippetA
  \break

  % 13-16
  c'4 d'8 c' b a
  b4 c'8 b a4
  a4 b8 a g fis
  g2.
  \break

  % 17-20
  b'4 g'8 a' b' g'
  a'4 d'8 e' fis' d'
  g'4 e'8 fis' g' d'
  cis'4 b8 cis' a4
  \break

  % 21-24
  a8 b cis' d' e' fis'
  g'4 fis' e'
  fis'4 a cis'
  d'2.
  \break

  % 25-28
  % FIXME: d'2. ...
  d'4 g8 fis g4
  % FIXME: e'2. ...
  e'4 g8 fis g4
  d'4 c' b
  a8 g fis g a4
  \break

  % 29-32
  d8 e fis g a b
  c'4 b a
  b8 d' g4 fis
  g2.

  \bar "|."
}

\score {
  <<
    \new Staff {
      \clef "G_8"
      \symbols
    }
  >>

  \midi { }
  \layout { }
}
