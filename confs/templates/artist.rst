{% if movement %}:艺术运动: {% for m in movement %}:artist.movement:`{{ m }} <{{ m }}>` {% endfor %}{% endif %}
{% if enwiki %}:维基: :enwiki:`{{ enwiki }}`{% endif %}
{% if zhwiki %}:维基: :zhwiki:`{{ zhwiki }}`{% endif %}
{% if artwork %}:知名作品: {% for a in artwork %} :search:`🎨{{ a }} <{{ name }} {{ a }}>` {% endfor %}{% endif %}

{% if content %}{{ content }}{% endif %}
