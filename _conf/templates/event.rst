:日期: {% for d in date %}:event.date+by-year:`{{ d }} <{{ d }}>` {% endfor %}
{% if location %}:位置: :event.location:`{{ location }} <{{ location }}>`{% endif %}

{% if content %}{{ content }}{% endif %}
