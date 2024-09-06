{% if isbn %}
:ISBN: {{ isbn }}
{% endif %}
{% if startat %}
:开始于: {% for s in startat %}:book.startat+by-month:`{{ s }} <{{ s }}>` {% endfor %}
{% endif %}
{% if endat %}
:结束于: {% for e in endat %}:book.endat+by-month:`{{ e }} <{{ e }}>` {% endfor %}
{% endif %}
{% if bookmark %}
:书签: 第 {{ bookmark }} 页
{% endif %}
{% if status %}
:状态: {{ status }}
{% endif %}

{% if content %}{{ content }}{% endif %}
