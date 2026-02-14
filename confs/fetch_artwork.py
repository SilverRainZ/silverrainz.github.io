from __future__ import annotations
import subprocess
from os import path

from sphinx.application import Sphinx
from sphinx.environment import BuildEnvironment
from sphinx.util import logging
from sphinxnotes.render.template import _JinjaEnv

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
                result = subprocess.run(['/home/la/sync/latree/bin/artworks', 'fetch', id_, imgdir])
            except Exception as e:
                errmsg = str(e)
            else:
                if result.returncode == 0:
                    errmsg = None
                else:
                    errmsg = f'error code: {result.returncode}'
            if errmsg:
                logger.warning(f'failed to fetch arwork by ID {id_}: {errmsg}')

        f = f'/{imgdir}/{id_}.webp'
        return f if path.exists(f) else None

    return _filter


def setup(app: Sphinx):
    _JinjaEnv.add_filter('fetch_artwork', fetch_artwork_filter)
