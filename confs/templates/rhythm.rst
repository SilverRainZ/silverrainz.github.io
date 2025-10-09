:拍号: :rhythm.time:`{{ time }} <{{ time }}>`
{% if musicca %}:鼓机: :musicca-drum:`{{ tempo if tempo else 60 }}-{{ musicca }}`{% endif %}
:鼓谱:

   .. lily::
      :loop:

      \version "2.20.0"

      main = {
         \drums {
            \tempo 4 = {{ tempo if tempo else 60 }}
            \time {{ time }}

            <<
            {
               % 镲，预备
               {% if time == '4/4' %}
                  hh4 hh hh hh
               {% elif time == '3/4' %}
                  hh4 hh hh
               {% elif time == '6/8' %}
                  hh8 hh hh hh hh hh
               {% endif %}

               % 节奏开始，重复 4 次
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
