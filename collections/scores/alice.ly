\version "2.20.0"
\header {
  title = "Alice"
  composer = "古川本舖"
  arranger = "Osamuraisan"
  copyright = "SilverRainZ"
}

prelude = \repeat unfold 2 {
    e,4 c g d
    f, c g d
    g, c g d
    g,8(a,8\6) c4 g d
}

interlude = \repeat unfold 2 {
  <e, g>4 c' d' g'
  <f, g>4 c' d' g'
  <g, g>4 c' d' g'
  <f, g>4 c' d' g'
}

pieceA = {
  <a, c'>4 e' <e, g'> g
}

pieceAi = {
  <f, c'>4 g' <c g'> g
}

pieceB = {
  <c a'>4 g8 c'8 <f, c'>4 d
}

pieceBi = {
  <d g'>4 (c'') <a c''> g
}

pieceBii = {
  <c c'>4 d <g, d'> d'
}

pieceBiii = {
  <c c'>4 d <g, d'> f'
}

pieceC = {
  <c a>4 c' <g, e'> d
}

pieceCi = {
  <d c'>4 g <g, e'> g
}

pieceCii = {
  <c c'>4 d' <a, e'> g8 e'8
}

pieceCiii = {
  <d e'>4 c' <a, c'> g8 e'8
}

pieceCiv = {
  <c c'>4 d' <a, e'> g
}

pieceD = {
  <g, d'>4 c' <a, c'> g
}

pieceDi = {
  <g, d'>4 f' <a, e'> d
}

pieceDii = {
  <g, d'>4 d8 c'8 <a, c'>4 d8 e'8
}

pieceDiii = {
  <g, d'>4 c' <f, c'> g
}

pieceDiv = {
  <g, d'>4 d8 c'8 <a, c'>2
}

symbols =  {
  \time 4/4
  \tempo  "Allegro" 4 = 150

  % 1
  \prelude

  %9
  \pieceA
  \pieceB
  \pieceC
  \pieceD

  %13
  \pieceA
  \pieceB
  \pieceC
  \pieceDi

  %17
  \pieceA
  \pieceB
  \pieceC
  \pieceD

  %21
  \pieceA
  \pieceBi
  \pieceCi
  \pieceD

  %25
  \pieceA
  \pieceB
  <c a>4 c' <g, e'> <d f'>
  \pieceD

  %29
  \pieceA
  \pieceB
  \pieceC
  \pieceDi

  %33
  \pieceA
  \pieceB
  \pieceC
  \pieceD

  %37
  \pieceA
  \pieceBi
  \pieceCi
  \pieceDii

  \bar "||"

  %41
  \pieceDiii

  %42
  \pieceAi
  \pieceBii
  \pieceCii
  \pieceDiii

  %46
  \pieceAi
  \pieceBiii
  \pieceCiii
  \pieceDiii

  %50
  \pieceAi
  \pieceBiii
  \pieceCiv

  %53
  \pieceA
  \pieceBi
  \pieceCi
  \pieceDii

  \bar "||"

  %57
  \pieceA
  \pieceB
  \pieceC
  \pieceD

  %61
  \pieceA
  \pieceB
  \pieceC
  \pieceDi

  %65
  \pieceA
  \pieceB
  \pieceC
  \pieceD

  %69
  \pieceA
  \pieceBi
  \pieceCi
  \pieceDiv

  \bar "||"

  %73
  \prelude

  %81
  \interlude

  \bar "||"

  %89
  r1
  r1

  \bar "|."
}

\score {
  <<
    \new Staff {
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
