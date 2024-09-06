{% if date %}:日期: :jour.date+by-month:`{{ date }} <{{ date }}>`{% endif %}
{% if category %}:类别: {{ category  }}{% endif %}

{% if content %}{{ content }}{% endif %}
