..
   WARNING

   This README is used to display on the Github repository page, so it cannot contain any Sphinx stuffs (directive or role).

====================
|logo| Silver Bullet
====================

Sphinx_-powered note-taking system of SilverRainZ_.

There is an article_ describes the architecture of this note-taking system from a technical level.

.. |logo| image:: /_static/logo.png
   :target: https://silverrainz.me
.. _Sphinx: https://sphinx-doc.org
.. _SilverRainZ: https://github.com/SilverRainZ
.. _article: https://silverrainz.me/blog/sphinx-as-note-taking-system-2.html

Browse
======

Visit https://silverrainz.me/ (hosted by Github Pages).

For visitors in China, there is a Gitee Pages mirror: https://silverrainz.gitee.io/

Dependencies
============

You must have following programs installed:

- Git
- GNU make
- Python3
- Sphinx>3.0

Install python package dependencies by the following commmands::

   pip3 install --user -r requirements.txt

I developed `series of sphinx extensions`_ for my note-taking system. You can found them in the requirements.txt_:

:sphinxnotes-any |any-badge|: Use `reST directive`_ to record and refer *anything*. For example, the paintings_ I have drawn, the books_ I have read.
:sphinxnotes-snippet |snippet-badge|: This extension allows me access reST documents from vim or terminal in extremely fast speed .
:sphinxnotes-lilypond |lilypond-badge|: For rendering my `musical scores`_.
:sphinxnotes-isso |isso-badge|: Embeding `Isso comments`_ in reST documents.
:sphinxnotes-strike |strike-badge|: Add HTML strikethrough text support.

.. _series of sphinx extensions: https://github.com/sphinx-notes
.. _requirements.txt: requirements.txt
.. _reST directive: https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#directives
.. _paintings: https://silverrainz.me/collections/art-works/index.html
.. _books: https://silverrainz.me/any-book.name.html
.. _musical scores: https://silverrainz.me/collections/scores/index.html
.. _Isso comments: https://posativ.org/isso/

.. |pages-badge| image:: https://img.shields.io/github/stars/sphinx-notes/pages.svg?style=social&label=Star&maxAge=2592000
   :target: https://github.com/sphinx-notes/pages
.. |snippet-badge| image:: https://img.shields.io/github/stars/sphinx-notes/snippet.svg?style=social&label=Star&maxAge=2592000
   :target: https://github.com/sphinx-notes/snippet
.. |any-badge| image:: https://img.shields.io/github/stars/sphinx-notes/any.svg?style=social&label=Star&maxAge=2592000
   :target: https://github.com/sphinx-notes/any
.. |lilypond-badge| image:: https://img.shields.io/github/stars/sphinx-notes/lilypond.svg?style=social&label=Star&maxAge=2592000
   :target: https://github.com/sphinx-notes/lilypond
.. |isso-badge| image:: https://img.shields.io/github/stars/sphinx-notes/isso.svg?style=social&label=Star&maxAge=2592000
   :target: https://github.com/sphinx-notes/isso
.. |strike-badge| image:: https://img.shields.io/github/stars/sphinx-notes/strike.svg?style=social&label=Star&maxAge=2592000
   :target: https://github.com/sphinx-notes/strike

To build various contents embeded in the documents, the following programs are optional
if you don’t need to view these contents:

- Lilypond
- Timidity++
- FFmpeg
- ImageMagick
- Graphviz
- PlantUML

Build
=====

Firstly clone this repository (The repository is quite big, clone with ``--depth=1`` if you dont want to make any changes)::

   git clone https://github.com/SilverRainZ/bullet.git

Ask sphinx to build HTML documentation::

   make

Root page of the HTML documentation can be found at ``_build/html/index.html``.

LICENSE
=======

Copyright 2020-2021, Shengyu Zhang.

The contents of this repository/documentation are all published under |cc-badge| Attribution-ShareAlike (CC BY-SA) agreement. For more details, please refer to: LICENSE_. 

.. |cc-badge| image:: https://licensebuttons.net/l/by-sa/4.0/88x31.png
   :target: http://creativecommons.org/licenses/by-sa/4.0/
   :height: 1.5em
.. _LICENSE: /LICENSE
