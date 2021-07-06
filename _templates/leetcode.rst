:地址: https://leetcode.com/problems/{{ id }}
:难度: :leetcode.diffculty:`{{ diffculty }} <{{ diffculty }}>`
:语言: {% for l in language %}:leetcode.language:`{{ l }} <{{ l }}>` {% endfor %}
{% if key %}:思路: {% for k in key %}:leetcode.key:`{{ k }} <{{ k }}>` {% endfor %}{% endif %}
{% if date %}:日期: {% for d in date %}:leetcode.date:`{{ d }} <{{ d }}>` {% endfor %}{% endif %}
{% if reference %}:参考: {{ reference }}{% endif %}

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
