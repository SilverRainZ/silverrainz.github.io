\version "2.20.0"
\header {
  title = "送别"
  composer = "John P. Ordway"
}

symbols = {
  \key a \major
  \time 4/4
  \tempo "Andante" 4 = 80

  r1

  \repeat volta 2 {
    e'4 cis'8 e' a'2
    fis'4 a'8 fis'8 e'2
    e'4 a8 b cis'4 b8 a
    b2. r4

    e'4 cis'8 e' a'4. gis'8
    fis'4 a' e'2
    e'4 b8 cis'8 d'4. gis8
    a2. r4

    fis'4 a' a' r
    gis'4 fis'8 gis' a'4 r4
    fis'8 gis' a' fis' fis' e' cis' a
    b2. r4

    e'4 cis'8 e' a'4. gis'8
    fis'4 a' e'2
    e'4 b8 cis'8 d'4. gis8
    a2. r4
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
