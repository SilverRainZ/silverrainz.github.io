import os
from enum import Enum, auto

class Deployment(Enum):
    Github = auto()
    Homelab = auto()
    Local = auto()

    @classmethod
    def current(cls) -> 'Deployment':
        if os.environ.get('GITHUB_REPOSITORY') == 'SilverRainZ/ronin':
            return Deployment.Homelab
        if os.environ.get('GITHUB_WORKFLOW') == 'Publish Github Pages':
            return Deployment.Github
        return Deployment.Local

    def is_private(self) -> bool:
        return not self.is_public()

    def is_public(self) -> bool:
        return self in [Deployment.Github]

    def is_mirror(self) -> bool:
        return self is not Deployment.Github

    def url(self) -> str:
        if self == Deployment.Github:
            return 'https://silverrainz.me/'
        elif self == Deployment.Homelab:
            return 'https://rpi3.tailnet-ecdc.ts.net/bullet'
        elif self == Deployment.Local:
            # See ../utils/autobuild
            return 'http://127.0.0.1:30500'
        else:
            # file:///build_dir/html/index.html
            return ''
