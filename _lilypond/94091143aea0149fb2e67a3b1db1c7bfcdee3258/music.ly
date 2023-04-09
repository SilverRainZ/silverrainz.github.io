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
  \key e \major
  \time 4/4
  \tempo "Andante" 4 = 80

  r1

  \repeat volta 2 {
    b4 gis8 b e'2
    cis'4 e'8 cis'8 b2
    b4 e8 fis gis4 fis8 e
    fis2. r4

    b4 gis8 b e'4. dis'8
    cis'4 e' b2
    b4 fis8 gis8 a4. dis8
    e2. r4

    cis'4 e' e' r
    dis'4 cis'8 dis' e'4 r4
    cis'8 dis' e' cis' cis' b gis e
    fis2. r4

    b4 gis8 b e'4. dis'8
    cis'4 e' b2
    b4 fis8 gis8 a4. dis8
    e2. r4
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
