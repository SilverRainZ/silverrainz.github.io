\paper {

scoreTitleMarkup = ##f

bookTitleMarkup = ##f

evenHeaderMarkup = ##f

oddHeaderMarkup = ##f

evenFooterMarkup = ##f

oddFooterMarkup = ##f
}
\version "2.20.0"
\header {
  title = "送别"
  composer = "John P. Ordway"

tagline = ##f
}

symbols = {
  \key c \major
  \time 4/4
  \tempo "Andante" 4 = 80

  r1

  \repeat volta 2 {
    g4 e8 g c'2
    a4 c'8 a8 g2
    g4 c8 d e4 d8 c
    d2. r4

    g4 e8 g c'4. b8
    a4 c' g2
    g4 d8 e8 f4. b,8
    c2. r4

    a4 c' c' r
    b4 a8 b c'4 r4
    a8 b c' a a g e c
    d2. r4

    g4 e8 g c'4. b8
    a4 c' g2
    g4 d8 e8 f4. b,8
    c2. r4
  }
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

  \layout { }
  \midi { }
}
