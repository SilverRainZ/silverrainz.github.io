{% if hide -%}
{% if field %}:领域: :term.field+by-slash:`{{ field }} <{{ field }}>`{% endif %}
{% if enwiki %}:维基: :enwiki:`{{ enwiki }}`{% endif %}
{% if zhwiki %}:维基: :zhwiki:`{{ zhwiki }}`{% endif %}
{%- endif %}

{{ content }}
