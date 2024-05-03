:类型: :dev.type:`{{ type }}`
{% if website %}:网站: {{ website }}{% endif %}
{% if man %}:手册: {{ man }}{% endif %}
{% if startat %}:购于: :dev.startat:`{{ startat }}`{% endif %}
{% if endat %}:购于: :dev.endat:`{{ endat }}`{% endif %}

{% if content %}{{ content }}{% endif %}
