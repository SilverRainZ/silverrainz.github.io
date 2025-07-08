from __future__ import annotations
from typing import TYPE_CHECKING
import subprocess

if TYPE_CHECKING:
    from sphinx.application import Sphinx
    from sphinx.environment import BuildEnvironment

from sphinxnotes.any.template import Environment as TemplateEnvironment

def fetch_artwork_filter(env: BuildEnvironment):
    """
    Fetch artwork picture by ID and install theme to Sphinx's source directory,
    return the relative URI of current doc root.
    """

    def _filter(id_: str) -> str | None:
        imgdir = '_blobs/artworks'
        imgdir = env.srcdir.joinpath(imgdir)
        result = subprocess.run(['/home/la/latree/bin/artworks-fetch', id_, imgdir])
        if result.returncode != 0:
            return None
        return f'/{imgdir}/{id_}.webp'

    return _filter


def setup(app: Sphinx):
    TemplateEnvironment.add_filter('fetch_artwork', fetch_artwork_filter)
