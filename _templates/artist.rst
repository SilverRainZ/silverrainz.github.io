{% if movement %}:艺术运动: {% for m in movement %}:artist.movement:`{{ m }} <{{ m }}>` {% endfor %}{% endif %}
{% if gallery %}:画廊: {% for g in gallery %}:gallery:`{{ g }}` {% endfor %}{% endif %}

{% if content %}{{ content }}{% endif %}
