from __future__ import annotations
from typing import TYPE_CHECKING, cast
import json
import dataclasses

from sphinxnotes.any.domain import AnyDomain

from sphinx.util import logging

logger = logging.getLogger(__name__)

if TYPE_CHECKING:
        from sphinx.application import Sphinx

def _on_build_finished(app: Sphinx, _):
    logger.info(f'dumping any domain object data')

    name = app.config.any_domain_name
    data = app.env.domaindata[name]
    objs = {}
    for (objtype, objid), (docname, anchor, obj) in data['objects'].items():
        objs[f'{objtype}-{objid}'] = {
            'docname': docname,
            'anchor': anchor,
            'obj': dataclasses.asdict(obj),
        }
    file = app.doctreedir.joinpath(f'{name}-objects.json')
    with open(file, "w") as f:
        f.write(json.dumps(objs, indent=2, ensure_ascii=False))
    logger.info(f'writing any domain object data to {file}')

def setup(app: Sphinx):
    app.connect('build-finished', _on_build_finished)
