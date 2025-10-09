..
   WARNING

   This README is used to display on the Github repository page, so it cannot
   contain any Sphinx stuffs (directive or role).

====================
|logo| Silver Bullet
====================

Fully structured note-taking system of SilverRainZ.

Powered by Sphinx |sphinx-logo| and Sphinx Notes |sphinx-notes-logo|.

.. |logo| image:: ./static/favicon.png
   :target: https://silverrainz.me
   :height: 1.5em

.. |sphinx-logo| image:: ./static/sphinx.png
   :target: https://www.sphinx-doc.org
   :height: 1.5em

.. |sphinx-notes-logo| image:: ./static/sphinxnotes-logo.png
   :target: https://github.com/sphinx-notes/
   :height: 1.5em

Browse
======

Visit https://silverrainz.me/.

Dependencies
============

You MUST have following programs installed:

- Git
- GNU make
- Python>=312
- Sphinx>=8

Install python package dependencies by the following commmands::

   pip3 install --user -r requirements.txt

I developed `series of sphinx extensions`_ for my note-taking system.
You can found them in the requirements.txt_:

.. _series of sphinx extensions: https://github.com/sphinx-notes
.. _requirements.txt: requirements.txt

The following programs are OPTIONAL if you don’t need to build various contents
embedded in the documentation:

- Lilypond
- Timidity++
- FFmpeg
- ImageMagick
- Graphviz
- PlantUML

Build
=====

Firstly clone this repository (The repository is quite big,
clone with ``--depth=1`` if you dont want to make any changes)::

   git clone https://github.com/SilverRainZ/bullet.git

Ask sphinx to build HTML documentation::

   make html

Root page of the HTML documentation can be found at ``build/html/index.html``.

LICENSE
=======

Copyright 2020-2025, Shengyu Zhang.

The contents of this repository/documentation are all published under
|cc-badge| Attribution-ShareAlike (CC BY-SA) agreement. For more details,
please refer to: LICENSE_.

.. |cc-badge| image:: https://licensebuttons.net/l/by-sa/4.0/88x31.png
   :target: http://creativecommons.org/licenses/by-sa/4.0/
   :height: 1.5em
.. _LICENSE: /LICENSE
