# Definition of any domain's object schemas.
# See also https://sphinx.silverrainz.me/any/.

from sphinxnotes.any.domain import INDEXER_REGSITRY
from sphinxnotes.any.indexers import PathIndexer

INDEXER_REGSITRY['hyphen'] = PathIndexer('-', 1)
INDEXER_REGSITRY['hyphen2'] = PathIndexer('-', 2)
INDEXER_REGSITRY['slash'] = PathIndexer('/', 1)

OBJECT_TYPES = {
    'friend': {
        'schema': {
            'name': 'lines of str, required, uniq, ref',
            'attrs': {
                'avatar': 'str',
                'blog': 'str',
            },
            'content': 'lines of str',
        },
        'templates': {
            'obj': open('confs/templates/friend.rst', 'r').read(),
            'header': '{{ name[0] }}',
            'ref': '👤{{ name[0] }}',
        },
    },
    'book': {
        'schema': {
            'name': 'lines of str, required, uniq, ref',
            'attrs': {
                'isbn': 'str, uniq, ref',
                'status': 'str, ref',
                'startat': 'words of date, ref, index by year',
                'endat': 'words of date, ref, index by year',
            },
        },
        'templates': {
            'obj': open('confs/templates/book.rst', 'r').read(),
            'ref': '《{{ name[0] }}》',
            'header': '{{ name[0] }}',
        },
    },
    'artwork': {
        'schema': {
            'name': 'str, ref, required',
            'attrs': {
                'id': 'str, required, uniq, ref, index by hyphen',
                'date': 'date, ref, index by year',
                'medium': 'words of str, ref',
                'size': 'str, ref',
                'album': 'str, ref',
            },
        },
        'templates': {
            'obj': open('confs/templates/artwork.rst', 'r').read(),
            'ref': '《{{ name }}》',
            'embed': open('confs/templates/artwork.embed.rst', 'r').read(),
        },
    },
    'artist': {
        'schema': {
            'name': 'lines of str, required, ref',
            'attrs': {
                'movement': 'words of str, ref',
                'gallery': 'words of str, ref',
                'enwiki': 'str',
                'zhwiki': 'str',
                'artwork': 'words of str',
            },
        },
        'templates': {
            'obj': open('confs/templates/artist.rst', 'r').read(),
            'ref': '🧑‍🎨{{ name[0] }}',
            'header': '{{ name[0] }}',
        },
    },
    'gallery': {
        'schema': {
            'name': 'lines of str, required, uniq, ref',
            'attrs': {
                'website': 'str',
            },
        },
        'templates': {
            'obj': open('confs/templates/gallery.rst', 'r').read(),
            'ref': '🖼️{{ name[0] }}',
            'header': '{{ name[0] }}',
        },
    },
    'event': {
        'schema': {
            'name': 'str, required, ref',
            'attrs': {
                'date': 'words of date, ref, index by year',
                'location': 'str, ref',
            },
        },
        'templates': {
            'obj': open('confs/templates/event.rst', 'r').read(),
            'ref': '📅{{ name }}',
        },
    },
    'leetcode': {
        'schema': {
            'name': 'str, required, ref',
            'attrs': {
                'id': 'str, uniq, ref',
                'diffculty': 'str, ref',
                'language': 'words of str, ref',
                'key': 'words of str, ref',
                'date': 'words of date, ref, index by year',
                'reference': 'str',
            },
        },
        'templates': {
            'obj': open('confs/templates/leetcode.rst', 'r').read(),
            'ref': '🧮{{ name }}',
        },
    },
    'term': {
        'schema': {
            'name': 'lines of str, required, ref',
            'attrs': {
                'field': 'str, ref, index by slash',
                'enwiki': 'str',
                'zhwiki': 'str',
                'hide': 'bool',
            },
        },
        'templates': {
            'obj': open('confs/templates/term.rst', 'r').read(),
            'ref': '#️⃣{{ name[0] }}',
            'header': '{{ name[0] }}',
        },
    },
    'jour': {
        'schema': {
            'name': 'date, required, ref, index by year',
        },
        'templates': {
            'obj': open('confs/templates/jour.rst', 'r').read(),
            'header': '📰 :jour.name+by-year:`{{ name }}`',
            'ref': '📰{{ name }}',
        },
    },
    'okr': {
        'schema': {
            'attrs': {
                'id': 'str, required, uniq, ref, index by hyphen2',
                'kr1': 'lines of str',
                'kr2': 'lines of str',
                'kr3': 'lines of str',
                'kr4': 'lines of str',
                'kr5': 'lines of str',
                'kr6': 'lines of str',
                'p0': 'str, ref',
                'p1': 'str, ref',
                'p2': 'str, ref',
                'krs': 'lines of str',
            },
        },
        'templates': {
            'obj': open('confs/templates/okr.rst', 'r').read(),
            'ref': '🎯{{ name }}',
        },
    },
    'people': {
        'schema': {
            'name': 'lines of str, required, uniq, ref',
            'attrs': {
                'github': 'str',
                'blog': 'str',
                'enwiki': 'str',
                'zhwiki': 'str',
                'weibo': 'str',
            },
        },
        'templates': {
            'obj': open('confs/templates/people.rst', 'r').read(),
            'header': '{{ name[0] }}',
            'ref': '👤{{ name[0] }}',
        },
    },
    'rhythm': {
        'schema': {
            'name': 'str, ref',
            'attrs': {
                'time': 'str, required, ref',
                'tempo': 'str',
                'musicca': 'str',
            },
            'content': 'lines of str',
        },
        'templates': {
            'obj': open('confs/templates/rhythm.rst', 'r').read(),
            'ref': '🥁{{ name }}',
        },
    },
    'dev': {
        'schema': {
            'attrs': {
                'id': 'str, required, uniq, ref, index by hyphen',
                'type': 'str, ref',
                'web': 'str',
                'man': 'str',
                'price': 'str',
                'startat': 'date, ref, index by year',
                'endat': 'date, ref, index by year',
            },
        },
        'templates': {
            'obj': open('confs/templates/dev.rst', 'r').read(),
            'ref': '🎛️{{ name }}',
        },
    },
    'loveletter': {
        'schema': {
            'attrs': {
                'date': 'date, required, ref, index by year',
                'nick': 'str',
                'author': 'str, ref',
                'createdat': 'date, ref, index by year',
                'updatedat': 'date, ref, index by year',
            },
        },
        'templates': {
            'obj': open('confs/templates/loveletter.rst', 'r').read(),
            'ref': '💌{{ name }}',
        },
    },
}
