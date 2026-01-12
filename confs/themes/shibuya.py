html_theme_options = {
    'accent_color': 'teal',
    'color_mode': 'light',
    'github_url': f'https://github.com/SilveRrainZ',
    'nav_links': [
        {
            'title': '项目',
            'children': [{
                'title': 'Srain IRC Client',
                'url': 'https://srain.silverrainz.me',
            }, {
                'title': 'Sphinx Notes Project',
                'url': 'https://sphinx.silverrainz.me',
            }, {
                'title': '更多…',
                'url': f'https://github.com/SilveRrainZ',
                "external": True,
            }],
        },
        {
            'title': '关于',
            'children': [{
                'title': '关于我' ,
                'url': 'about/me',
            }, {
                'title': '关于本站',
                'url': 'about/site',
            }, {
                'title': '友人帐',
                'url': 'about/friends',
            }, {
                'title': '简历',
                'url': 'resume',
                "resource": True,
            }],
        },
    ],
}

html_context = {
    'source_type': 'github',
    'source_user': 'SilveRrainZ',
    'source_repo': 'silverrainz.github.io',
    'source_version': 'master',
    'source_docs_path': '/src/',
}

html_sidebars = {}
