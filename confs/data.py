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
}
