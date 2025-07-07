from __future__ import annotations
from typing import TYPE_CHECKING
import subprocess

if TYPE_CHECKING:
        from sphinx.application import Sphinx

from sphinxnotes.any.template import Environment

def query_artwork_filter(env: Environment):
    """
    Query artwork picture by ID and install theme to Sphinx's image DIR,
    return the relative uri of current doc root.
    """

    def _filter(id_: str) -> str | None:
        imgdir = '_images/artworks'
        imgdir = env._builder.srcdir.joinpath(imgdir)
        result = subprocess.run(['/home/la/latree/bin/artworks-query', id_, imgdir])
        if result.returncode != 0:
            return None
        return f'/{imgdir}/{id_}.webp'

    return _filter


def setup(app: Sphinx):
    Environment.add_filter('query_artwork', query_artwork_filter)
