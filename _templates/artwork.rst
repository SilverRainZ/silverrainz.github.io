:编号: {{ id }}
:日期: {{ date }}
:尺幅: {{ size }}
:媒介: {{ medium }}

{% if image %}

.. figure:: {{ image }}
   :width: 80%

   {{ id }}

{{ content | join('\n') }}

{% else %}

.. todo:: 图片未上传

{{ content | join('\n') }}

{% endif %}

