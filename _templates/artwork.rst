:编号: :artwork.id+by-path:`{{ id }} <{{ id }}>`

:日期: :artwork.date+by-year:`{{ date }} <{{ date }}>`
{% if size %}:尺幅: :artwork.size:`{{ size }} <{{ size }}>`{% endif %}
:媒介: {% for m in medium %}:artwork.medium:`{{ m }} <{{ m }}>` {% endfor %}
{% if album %}:画集: :artwork.album:`{{ album }} <{{ album }}>`{% endif %}

{% if image %}
.. figure:: {{ image | thumbnail }}
   :target: https://raw.githubusercontent.com/SilverRainZ/bullet/master{{ image }}

   {{ title }}
{% else %}

.. todo:: 图片未上传
{% endif %}

{% if content %}{{ content }}{% endif %}
