.. grid:: 2
   :gutter: 1

   .. grid-item-card::
      :columns: 6 6 4 3
      :img-background: {{ avatar }}
      :link: {{ blog }}

   .. grid-item-card::
      :columns: 6 6 8 9


      {% for line in content %}
      {{ line }}
      {% endfor %}
