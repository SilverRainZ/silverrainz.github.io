{% if avatar %}
.. image:: {{ avatar }}
   :width: 120px
   :alt: {{ names[0] }}
   :align: right
{% endif %}

{{ blog }}

{{ content | join('\n') }}
