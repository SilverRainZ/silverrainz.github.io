from __future__ import annotations
import subprocess
from os import path

from sphinx.application import Sphinx
from sphinx.environment import BuildEnvironment
from sphinx.util import logging
from sphinxnotes.any.template import Environment as TemplateEnvironment

from .deploy import Deployment


logger = logging.getLogger(__name__)


def fetch_artwork_filter(env: BuildEnvironment):
    """
    Fetch artwork picture by ID and install theme to Sphinx's source directory,
    return the relative URI of current doc root.
    """

    def _filter(id_: str) -> str | None:
        imgdir = '_assets/aw'
        imgdir = env.srcdir.joinpath(imgdir)
        if Deployment.current() == Deployment.Local:
            try:
                subprocess.run(['/home/la/sync/latree/bin/artworks', 'fetch', id_, imgdir])
            except Exception as e:
                logger.warning('failed to fetch artwork: %s', e)
        f = f'/{imgdir}/{id_}.webp'
        return f if path.exists(f) else None

    return _filter


def setup(app: Sphinx):
    TemplateEnvironment.add_filter('fetch_artwork', fetch_artwork_filter)
