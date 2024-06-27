========================
How Sphinx Builder Works
========================

:Sphinx Version: https://github.com/sphinx-doc/sphinx/tree/v7.3.7/sphinx

.. highlight:: python


Entry point
===========

Tow `options of sphinx-build`_ can specific builder:

In ``sphinx.cmd`` mods:

``-M BUILDER_NAME``
   make mode, used in Makefile

   ``build.main`` →   ``build.make_main`` →  ``make_mode.run_make_mode``
   →  ``make_model.Make.run_generic_build`` →  ``build.build_main``

   In `run_generic_build`, outdir is hardcoded to ``<BUILDDIR>/<BUILDER>``::

      ...
      args = ['-b', builder,
              '-d', doctreedir,
              self.srcdir,
              self.builddir_join(builder)] // HERE
      return build_main(args + opts)


``-b BUILDER_NAME``
   ``build.main`` →  ``build.build_main``

   outdir is ``<BUILDDIR>``.

In `build_main`, the important `application.Sphinx` object are created.

The Sphinx Application
======================

In `application.Sphinx.__init__`::

   # ...

   # load all user-given extension modules
   for extension in self.config.extensions:
      self.setup_extension(extension)

   # preload builder module (before init config values)
   self.preload_builder(buildername)

   # call possible config.setup() ...
   self.events.emit('config-inited', self.config)

   # set up the build environment
   self.env = self._init_env(freshenv)
      # create fresh env 
      self._create_fresh_env()
      # or load env from pickle files
      self._load_existing_env(outdir/.doctree/environment.pickle)
         env.setup(self)


   # create the builder
   self.builder = self.create_builder(buildername)


   # build environment post-initialisation, after creating the builder
   self._post_init_env()

   # set up the builder
   self._init_builder()
      # call events.emit('builder-inited', ...)

In ``BuildEnvironment.setup`` calls ``BuildEnvironment._update_config`` to detect
config changes::

   def _update_config(self, config: Config) -> None:
       # ...
       if self.config is None:
           self.config_status = CONFIG_NEW
       elif self.config.extensions != config.extensions:
           self.config_status = CONFIG_EXTENSIONS_CHANGED
           # ...
       else:
           # check if a config value was changed that affects how
           # doctrees are read
           for item in config.filter(frozenset({'env'})):
               if self.config[item.name] != item.value:
                   self.config_status = CONFIG_CHANGED
                   # ...

In ``Builder.build``, env are dump back to file:

env.get_outdated_files
builder.get_outdated_docs
buildinfo
use_index
use_index


.. _options of sphinx-build: https://www.sphinx-doc.org/en/master/man/sphinx-build.html#options
