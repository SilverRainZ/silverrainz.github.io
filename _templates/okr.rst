.. list-table:: OKR-{{ id }}
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
