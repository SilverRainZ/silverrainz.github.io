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
  \key b \major
  \time 4/4
  \tempo "Andante" 4 = 80

  r1

  \repeat volta 2 {
    fis'4 dis'8 fis' b'2
    gis'4 b'8 gis'8 fis'2
    fis'4 b8 cis' dis'4 cis'8 b
    cis'2. r4

    fis'4 dis'8 fis' b'4. ais'8
    gis'4 b' fis'2
    fis'4 cis'8 dis'8 e'4. ais8
    b2. r4

    gis'4 b' b' r
    ais'4 gis'8 ais' b'4 r4
    gis'8 ais' b' gis' gis' fis' dis' b
    cis'2. r4

    fis'4 dis'8 fis' b'4. ais'8
    gis'4 b' fis'2
    fis'4 cis'8 dis'8 e'4. ais8
    b2. r4
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
