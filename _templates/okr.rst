:编号: :okr.id+by-path:`{{ id.split('-')[0] }} <{{ id }}>`\ ``-{{ id.split('-', maxsplit=1)[1]}}``
:优先级: {% if p0 %}|p0|{% elif p1 %}|p1|{% else %}|p2|{% endif %} 
{% if id.count('-') == 2 %}:对齐: :okr:`{{ id.rsplit('-', maxsplit=1)[0] }}`{% endif %}

.. list-table::
   :header-rows: 1
   :align: center
   :widths: auto

   * - Key Results
     - 估时
     - 进度
     - 分数

   {% for n in range(krs | length) %}
   * - {{ krs[n] }}
     - {% if hrs and hrs | length > n and hrs[n] != '_' %} {{ hrs[n] }} 小时 {% else %} ⁿ̷ₐ {% endif %}
     - {% if progs and progs | length > n and progs[n] != '_' %} |{{ progs[n]}}| {% else %} ⁿ̷ₐ {% endif %}
     - {% if scores and scores | length > n and scores[n] != '_' %} |{{ scores[n] }}| {% else %} ⁿ̷ₐ {% endif %}
   {% endfor %}

{{ content }}
