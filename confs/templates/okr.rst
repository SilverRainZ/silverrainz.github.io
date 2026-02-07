:编号: :okr.id+by-hyphen2:`{{ id.split('-') | first }} <{{ id }}>`\ ``-{{ id.split('-', maxsplit=1) | first }}``
:优先级: {% if p0 is defined %}|p0|{% elif p1 is defined %}|p1|{% else %}|p2|{% endif %} 
{% if id.count('-') == 2 %}:对齐: :okr:`{{ id.rsplit('-', maxsplit=1)[0] }}`{% endif %}

{% if krs %}
.. note:: 2025 前的 OKR 使用旧格式，已归档，请勿用此格式创建新 OKR
.. code:: python
   
   {{ krs }}

{% else %}
.. list-table::
   :header-rows: 1
   :align: center
   :widths: auto

   * - KR
     - 进度

{% for i in range(1, 10) %}
   {% set kr = _['kr%d' % i] %}
   {%- if not kr %}{% continue %}{% endif %}
   {% set ns = namespace(progress = 'ⁿ̷ₐ', priority = 'p2') %}
   * - {% for line in kr %}
       {% if loop.first %}
          {% for v in line.split(' | ') %}
             {% if loop.last %}{% break%}{% endif %}
             {% if v.startswith('p') %}
               {% set ns.priority = v | trim %}
             {% elif '/' in v %}
               {% set ns.progress = ':progress:`%s`' % v | trim %}
             {% endif %}
          {% endfor %}
       |{{ ns.priority }}| {{ line.split(' | ') | last | trim }}
       {% else %}
       {{ line | trim }}
       {% endif %}
       {% endfor %}
     - {{ ns.progress }}
{% endfor %}
{% endif %}

{{ content }}
