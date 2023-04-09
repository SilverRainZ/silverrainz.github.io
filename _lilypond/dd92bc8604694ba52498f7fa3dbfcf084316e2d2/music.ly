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
  \key d \major
  \time 4/4
  \tempo "Andante" 4 = 80

  r1

  \repeat volta 2 {
    a4 fis8 a d'2
    b4 d'8 b8 a2
    a4 d8 e fis4 e8 d
    e2. r4

    a4 fis8 a d'4. cis'8
    b4 d' a2
    a4 e8 fis8 g4. cis8
    d2. r4

    b4 d' d' r
    cis'4 b8 cis' d'4 r4
    b8 cis' d' b b a fis d
    e2. r4

    a4 fis8 a d'4. cis'8
    b4 d' a2
    a4 e8 fis8 g4. cis8
    d2. r4
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
