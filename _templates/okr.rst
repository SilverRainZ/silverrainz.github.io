:编号: :okr.id+by-path:`{{ id.split('-')[0] }} <{{ id }}>`\ ``-{{ id.split('-', maxsplit=1)[1]}}``
:优先级: {% if p0 is defined %}|p0|{% elif p1 is defined %}|p1|{% else %}|p2|{% endif %} 
{% if id.count('-') == 2 %}:对齐: :okr:`{{ id.rsplit('-', maxsplit=1)[0] }}`{% endif %}

.. list-table::
   :header-rows: 1
   :align: center
   :widths: auto

   * - Key Result
     - 进度
     - 分数

   {# TODO: 2025-04-27: compat for old schema #}
   {% for n in range(krs | length) %}
   * - {{ krs[n] }}
     - {% if hrs and hrs | length > n and hrs[n] != '_' %} {{ hrs[n] }} 小时 {% else %} ⁿ̷ₐ {% endif %}
     - {% if progs and progs | length > n and progs[n] != '_' %} |{{ progs[n]}}| {% else %} ⁿ̷ₐ {% endif %}
     - {% if scores and scores | length > n and scores[n] != '_' %} |{{ scores[n] }}| {% else %} ⁿ̷ₐ {% endif %}
   {% endfor %}

   {% if kr1 %}
   * - {% for line in kr1 %}
       {{ line }}
       {% endfor %}
     - {{ done1 or 'ⁿ̷ₐ' }}
     - {{ score1 or 'ⁿ̷ₐ' }}
   {% endif %}
   {% if kr2 %}
   * - {% for line in kr2 %}
       {{ line }}
       {% endfor %}
     - {{ done2 or 'ⁿ̷ₐ' }}
     - {{ score2 or 'ⁿ̷ₐ' }}
   {% endif %}
   {% if kr3 %}
   * - {% for line in kr3 %}
       {{ line }}
       {% endfor %}
     - {{ done3 or  }}
     - {{ score3 or 'ⁿ̷ₐ' }}
   {% endif %}
   {% if kr4 %}
   * - {% for line in kr4 %}
       {{ line }}
       {% endfor %}
     - {{ done4 or 'ⁿ̷ₐ' }}
     - {{ score4 or 'ⁿ̷ₐ' }}
   {% endif %}

{{ content }}
