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
  \key f \major
  \time 4/4
  \tempo "Andante" 4 = 80

  r1

  \repeat volta 2 {
    c'4 a8 c' f'2
    d'4 f'8 d'8 c'2
    c'4 f8 g a4 g8 f
    g2. r4

    c'4 a8 c' f'4. e'8
    d'4 f' c'2
    c'4 g8 a8 bes4. e8
    f2. r4

    d'4 f' f' r
    e'4 d'8 e' f'4 r4
    d'8 e' f' d' d' c' a f
    g2. r4

    c'4 a8 c' f'4. e'8
    d'4 f' c'2
    c'4 g8 a8 bes4. e8
    f2. r4
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
