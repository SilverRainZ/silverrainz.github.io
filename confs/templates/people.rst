{% if github %}
:Github: :ghuser:`{{ github }}`
{% endif %}
{% if blog %}
:博客: `{{ name }} 的博客 <{{ blog }}>`__
{% endif %}
{% if enwiki %}
:维基: :enwiki:`{{ enwiki }}`
{% endif %}
{% if zhwiki %}
:维基: :zhwiki:`{{ zhwiki }}`
{% endif %}
{% if weibo %}
:微博: :weibo:`{{ weibo }}`
{% endif %}

{{ content }}
