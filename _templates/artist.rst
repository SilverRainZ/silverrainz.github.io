{% if movement %}:艺术运动: {% for m in movement %}:artist.movement:`{{ m }} <{{ m }}>` {% endfor %}{% endif %}
{% if gallery %}:画廊: {% for g in gallery %}:gallery:`{{ g }}` {% endfor %}{% endif %}
{% if enwiki %}:维基: :enwiki:`{{ enwiki }}`{% endif %}
{% if zhwiki %}:维基: :zhwiki:`{{ zhwiki }}`{% endif %}

{% if content %}{{ content }}{% endif %}
