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
  \key g \major
  \time 4/4
  \tempo "Andante" 4 = 80

  r1

  \repeat volta 2 {
    d'4 b8 d' g'2
    e'4 g'8 e'8 d'2
    d'4 g8 a b4 a8 g
    a2. r4

    d'4 b8 d' g'4. fis'8
    e'4 g' d'2
    d'4 a8 b8 c'4. fis8
    g2. r4

    e'4 g' g' r
    fis'4 e'8 fis' g'4 r4
    e'8 fis' g' e' e' d' b g
    a2. r4

    d'4 b8 d' g'4. fis'8
    e'4 g' d'2
    d'4 a8 b8 c'4. fis8
    g2. r4
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
