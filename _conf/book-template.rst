{% if isbn %}
:ISBN: {{ isbn }}
{% endif %}
{% if startat %}
:开始于: {{ startat }}
{% endif %}
{% if endat %}
:结束于: {{ endat }}
{% endif %}
{% if bookmark %}
:书签: 第 {{ bookmark }} 页
{% endif %}

{{ content | join('\n') }}
