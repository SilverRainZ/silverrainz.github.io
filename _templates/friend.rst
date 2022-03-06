.. grid:: 1 1 2 2
   :gutter: 1

   .. grid-item::
      :columns: 3

      .. grid:: 1 1 1 1
         :gutter: 1

         .. grid-item-card::
            :img-background: {{ avatar }}
            :link: {{ blog }}

   .. grid-item::
      :columns: 9

      .. grid:: 1 1 1 1
         :gutter: 1

         .. grid-item-card::

            {% for line in content %}
            {{ line }}
            {% endfor %}
