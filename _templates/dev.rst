:类型: :dev.type:`{{ type }}`
{% if web %}:网站: {{ web }}{% endif %}
{% if startat %}:入手年份: :dev.startat:`{{ startat }}`{% endif %}
{% if endat %}:出手年份: :dev.endat:`{{ endat }}`{% endif %}
{% if price %}:价格: {{ price }}{% endif %}

{% if man %}
.. dropdown:: 📖说明书

   .. pdf-include:: {{ man }}
{% endif %}

{% if content %}{{ content }}{% endif %}
