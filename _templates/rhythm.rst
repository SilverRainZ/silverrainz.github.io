:拍号: :rhythm.time:`{{ time }} <{{ time }}>`
:数拍: {{ grid }} [#]_

.. lily::

   \version "2.20.0"
    
   main = {
     \drums {
       \tempo 4 = {{ tempo if tempo else 60 }}
       \time {{ time }}
    
       <<
         {
           hh4 hh hh hh % 预备

           \repeat percent 4 {
              {% for line in content %}{{ line }}
              {% endfor %}
           }
         }
       >>
     }
   }
    
   \score {
      \main \layout{}
   }
   \score {
      % https://lilypond.org/doc/v2.24/Documentation/notation/using-repeats-with-midi
      \unfoldRepeats { \main } \midi{}
   }

.. [#] 数拍子的方法参见好和弦 NiceChord 的 `不管什麼節奏，都能彈對的練習秘訣！`__

__ https://www.youtube.com/watch?v=NkYhAmIGSOw
