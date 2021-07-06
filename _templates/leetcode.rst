:地址: https://leetcode.com/problems/{{ id }}
:难度: :leetcode.diffculty:`{{ diffculty }} <{{ diffculty }}>`
:语言: {% for l in language %}:leetcode.language:`{{ l }} <{{ l }}>` {% endfor %}
{% if key %}:思路: {{ key }}{% endif %}
{% if solution %}:他人题解: {% for s in solution %} - {{ s }}
{% endfor %}{% endif %}

.. dropdown:: 题解

   {% for l in language %}
   {% if l == 'rust' %}
   .. literalinclude:: ./{{ id }}/src/lib.rs
      :language: rust
   {% elif l == 'go' %}
   .. literalinclude:: ./{{ id }}/main.go
      :language: go
   {% endif %}
   {% endfor %}
