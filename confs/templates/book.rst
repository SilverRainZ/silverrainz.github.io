{% if isbn %}
:ISBN: {{ isbn }}
{% endif %}
{% if startat %}
:开始于: {% for s in startat %}:book.startat+by-year:`{{ s }} <{{ s }}>` {% endfor %}
{% endif %}
{% if endat %}
:结束于: {% for e in endat %}:book.endat+by-year:`{{ e }} <{{ e }}>` {% endfor %}
{% endif %}
{% if status %}
:状态: {{ status }}
{% endif %}

{% if content %}{{ content }}{% endif %}
