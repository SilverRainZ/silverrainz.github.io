import os
from enum import Enum, auto

class Deployment(Enum):
    Github = auto()
    Gitee = auto()
    Raspi = auto() # Raspberry Pi
    Local = auto()

    @classmethod
    def current(cls) -> 'Deployment':
        if os.environ.get('GITHUB_REPOSITORY') == 'SilverRainZ/ronin':
            return Deployment.Raspi
        if os.environ.get('GITHUB_WORKFLOW') == 'Publish Github Pages':
            return Deployment.Github
        if os.environ.get('GITHUB_WORKFLOW') == 'Publish Gitee Pages':
            return Deployment.Gitee
        return Deployment.Local

    def is_private(self) -> bool:
        return not self.is_public()

    def is_public(self) -> bool:
        return self in [Deployment.Github, Deployment.Gitee]

    def is_mirror(self) -> bool:
        return self is not Deployment.Github

    def url(self) -> str:
        if self == Deployment.Github:
            return 'https://silverrainz.me/'
        elif self == Deployment.Gitee:
            return 'https://silverrainz.gitee.io/'
        elif self == Deployment.Raspi:
            return 'https://rpi3/bullet'
        else:
            # file:///build_dir/html/index.html
            return 'TODO'


D = Deployment.current()
print('Deployment:', D)
