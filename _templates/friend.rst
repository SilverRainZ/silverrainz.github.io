{% if avatar %}
.. image:: {{ avatar }}
   :width: 120px
   :alt: {{ name[0] }}
   :align: right
{% endif %}

{{ blog }}

{% if content %}{{ content }}{% endif %}
