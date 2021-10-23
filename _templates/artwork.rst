:编号: {{ id }}
:日期: {{ date }}
{% if size %}:尺幅: :artwork.size:`{{ size }} <{{ size }}>`{% endif %}
:媒介: {% for m in medium %}:artwork.medium:`{{ m }} <{{ m }}>` {% endfor %}
{% if album %}:画集: :artwork.album:`{{ album }} <{{ album }}>`{% endif %}

{% if image %}
.. image:: {{ image }}
   :width: 80%
{% else %}

.. todo:: 图片未上传
{% endif %}

{% if content %}{{ content }}{% endif %}
