:维基: :zhwiki:`{{ title }}`
:艺术运动: {% for m in movement %}:artist.movement:`{{ m }} <{{ m }}>` {% endfor %}
{% if content %}{{ content }}{% endif %}
