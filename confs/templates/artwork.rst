:编号: :artwork.id+by-hyphen:`{{ id }} <{{ id }}>`
:日期: :artwork.date+by-year:`{{ date }} <{{ date }}>`
{% if size %}:尺幅: :artwork.size:`{{ size }} <{{ size }}>`{% endif %}
:媒介: {% for m in medium %}:artwork.medium:`{{ m }} <{{ m }}>` {% endfor %}
{% if album %}:画集: :artwork.album:`{{ album }} <{{ album }}>`{% endif %}

{% set image = id | fetch_artwork %}
{% if image %}
.. figure:: {{ image }}
   :width: 60%

   {{ name }}
{% else %}
.. todo:: 图片未上传
{% endif %}

{% if content %}{{ content }}{% endif %}
