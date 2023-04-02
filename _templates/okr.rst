:编号: ``{{ id }}``
{% if parent %}:对齐: :okr:`{{ parent }}`{% endif %}

.. list-table::
   :header-rows: 1
   :align: center
   :widths: auto

   * - Key Results
     - Scores

   {% for n in range(krs | length) %}
   * - {{ krs[n] }}
     - {{ scores[n] }}
   {% endfor %}

{% if content %}{{ content }}{% endif %}
