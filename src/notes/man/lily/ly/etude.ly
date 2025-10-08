% ========
% etude.ly
% ========
%
% Generate
% .. seealso::
%
%    https://lists.gnu.org/archive/html/lilypond-user/2016-07/msg00663.html
%    https://lsr.di.unimi.it/LSR/Item?id=630

\version "2.24.0"

% Motified from scm/lily/lily-library.scm::get-outfile-name.
#(define get-outfile-name (define-scheme-function
  (ext) (string?)
  "return current filename for generating backend output files"
  ;; user can now override the base file name, so we have to use
  ;; the file-name concatenated with any potential output-suffix value
  ;; as the key to out internal a-list
  (let* ((base-name (ly:parser-output-name))
         (output-suffix (ly:parser-lookup 'output-suffix))
         (alist-key (format #f "~a~a~a" base-name output-suffix ext))
         (counter-alist (ly:parser-lookup 'counter-alist))
         (output-count (assoc-get alist-key counter-alist 0))
         (result base-name))
    ;; Allow all ASCII alphanumerics, including accents
    (if (string? output-suffix)
        (set! result
              (format #f "~a-~a"
                      result
                      (string-regexp-substitute
                       "[^-[:alnum:]]"
                       "_"
                       output-suffix))))

    ;; assoc-get call will always have returned a number
    (if (> output-count 0)
        (set! result (format #f "~a-~a" result output-count)))

    (ly:parser-define! 'counter-alist
                       (assoc-set! counter-alist alist-key (1+ output-count)))
    (set! current-outfile-name result)
    result)))

#(define make-book (define-scheme-function
   (title music output ext)
   (string? ly:music? ly:output-def? string?)
   (_i "Print a book consisted of given @var{music}.")
   (let ((book
           #{
             \book {
               \header { title = $title }
               \score { $music }
             }
           #})
        )
   (ly:book-process
    book
    #{ \paper {} #} ; non-functional, placeholder
    output
    (get-outfile-name ext)))))

#(define pitch-equal? (define-scheme-function (p1 p2) (ly:pitch? ly:pitch?)
    (and
        (= (ly:pitch-notename p1) (ly:pitch-notename p2))
        (= (ly:pitch-octave p1) (ly:pitch-octave p2))
        (= (ly:pitch-alteration p1) (ly:pitch-alteration p2)))))

#(define make-title-text (define-scheme-function
   (title orig-tonic tonic is-melody is-harmony)
   (string? ly:pitch? ly:pitch? boolean? boolean?)
   (let ((lst (list))
         (tonic-name (string-upcase (note-name->string tonic))))
        (if (not (equal? is-melody is-harmony))
            (set! lst (append lst (list (if is-melody "Melody" "Harmony")))))
        (if (not (pitch-equal? tonic orig-tonic))
            (set! lst (append lst (list (string-append tonic-name " scale")))))
        (if (null? lst)
            title
            (string-append title " (" (string-join lst ", " 'infix) ")" )))))

% Test
% #(make-training-books "Etude" #{ \melody #} #{ \harmony #} #{ c #})
% #(ly:message "~a" (make-title-text "foooo" #{ c #} #{ d #} #t #f))
% #(ly:message "~a" (make-title-text "Foo" #{ c #} #{ c #} #t #t))
% #(ly:message "~a" (make-title-text "Foo" #{ c #} #{ e #} #f #t))
% #(ly:message "~a" (make-title-text "Foo" #{ c #} #{ c #} #t #f))
% #(ly:message "~a" (make-title-text "Foo" #{ c #} #{ d #} #t #f))
% #(ly:message "~a" (make-title-text "Foo" #{ c #} #{ d #} #f #t))

#(define make-transposed-book (define-scheme-function
   (title music tonic output ext)
   (string? ly:music? ly:pitch? ly:output-def? string?)
   (let ((new-music (ly:music-transpose music tonic)))
        (make-book title new-music output ext))))

#(define all-tonics
    (list
      #{ c #}
      #{ g #}
      #{ d #}
    ))

makeEtude = #(define-scheme-function
  (title melody harmony orig-tonic score-output midi-output)
  (string? ly:music? ly:music? (ly:pitch? #{c#})
   (ly:output-def? #{\layout{}#}) (ly:output-def? #{\midi{}#}))

  ; Create MIDI tracks in common keys for melody and harmony.
  (for-each
    (lambda (tonic)
      (let ((melody-title (make-title-text title orig-tonic tonic #t #f))
            (harmony-title (make-title-text title orig-tonic tonic #f #t))
            (etude-title (make-title-text title orig-tonic tonic #t #t)))
           (make-transposed-book melody-title melody tonic midi-output "midi")
           (make-transposed-book harmony-title harmony tonic midi-output "midi")
           (make-transposed-book etude-title #{<< $harmony $melody >>#} tonic midi-output "midi")
      ))
    all-tonics)

  ; Create scores for the entire etude.
  (make-book title #{<< $harmony $melody >>#} score-output "score")
  )
