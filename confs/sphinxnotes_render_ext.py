DATA_DEFINE_DIRECTIVES = {
    'gallery': {
        'schema': {
            'name': 'words of str',
            'attrs': {
                'grid': 'str',
            },
            'content': 'words of str',
        },
        'template': {
            'text': """
.. grid:: {{ grid or '1 2 5 5' }}

    {% for word in (name or []) + (content or []) %}
    .. grid-item::
       .. artwork+embed:: {{ word }}

          .. figure:: /_assets/aw/{{ '{{ id }}' }}.webp

             {{ '``{{ name }}``, {{ date.year}}' }}

    {% endfor %}""",
        },
    },

    'redirect': {
        'schema': {
            'name': 'str',
        },
        'template': {
            'text': """
.. raw:: html

   <script>window.location.href = "{{ name }}";</script>"""
        },
    },

    'audio': {
        'schema': {
            'name': 'str',
            'attrs': {
                'align': 'str',
            },
            'content': 'str',
        },
        'template': {
            'text': """
{% set alignment = align if align in ('left', 'center', 'right') else 'left' %}
{% set margin = {'left': '0 auto 0 0', 'center': '0 auto', 'right': '0 0 0 auto'}[alignment] %}
.. raw:: html

   <figure style="text-align: {{ alignment }};">
     <audio controls preload="metadata" src="{{ name | e }}"
            style="display: block; margin: {{ margin }}; max-width: 100%;"></audio>
     {% if content %}
     <figcaption>{{ content | e | indent(5) }}</figcaption>
     {% endif %}
   </figure>""",
        },
    },

    'ghcard': {
        'schema': {
            'name': 'str',
        },
        'template': {
            'text': """
.. image:: https://gh-card.dev/repos/{{ name }}.svg?fullname=
   :target: https://github.com/{{ name }}
   :align: center"""
        },
    }
}
