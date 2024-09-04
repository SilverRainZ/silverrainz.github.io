:日期: {% for d in date %}:event.date+by-month:`{{ d }} <{{ d }}>` {% endfor %}
:位置: :event.location:`{{ location }} <{{ location }}>`

{% if content %}{{ content }}{% endif %}
