{% if isbn %}
:ISBN: {{ isbn }}
{% endif %}
{% if startat %}
:开始于: {{ startat }}
{% endif %}
{% if endat %}
:结束于: {{ endat }}
{% endif %}

{{ content | join('\n') }}
