:编号: {{ id }}
:日期: {{ date }}
:尺幅: :artwork.size:`{{ size }} <{{ size }}>`
:媒介: {% for m in medium %}:artwork.medium:`{{ m }} <{{ m }}>` {% endfor %}

{% if image %}
.. figure:: {{ image }}
   :width: 80%
{% else %}

.. todo:: 图片未上传
{% endif %}

{% if content %}{{ content }}{% endif %}
