========================
How Sphinx Builder Works
========================

:Sphinx Version: https://github.com/sphinx-doc/sphinx/tree/v7.3.7/sphinx

.. default-domain:: py
.. highlight:: python

Entry point
===========

Two `options of sphinx-build`_  ``-M`` and ``-b`` can specific builder:

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

In `build_main`, the important :class:`sphinx.application.Sphinx` object are created.

Create Sphinx Application
=========================

In `Sphinx.__init__`::

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
      self.builder.init()
      self.events.emit('builder-inited')

In ``BuildEnvironment.setup`` calls ``BuildEnvironment._updateconfig`` to detect
config changes::

   def _updateconfig(self, config: Config) -> None:
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

``Builder.init`` does nothing, ``StandaloneHTMLBuilder.init`` creates BuildInfo and read config (html_xxx)::

    def init(self) -> None:
        self.build_info = self.create_build_info()
        # ...
        self.use_index = self.get_builderconfig('use_index', 'html')

Build
=====

return to ``build_main``, after creating Sphinx obj, call ``Sphinx.build``.

``Sphinx.build`` calls three ``Builder.build_xxx`` variant::

   def build(self, force_all: bool = False, filenames: list[str] | None = None) -> None:
       self.phase = BuildPhase.READING
       try:
           if force_all:
               self.builder.build_all()
           elif filenames:
               self.builder.build_specific(filenames)
           else:
               self.builder.build_update()
            self.events.emit('build-finished', None)
        # ....

Both ``force_all`` and ``filenames`` comes from command line::

   parser.add_argument('filenames', nargs='*',
                       help=__('(optional) a list of specific files to rebuild. '
                               'Ignored if --write-all is specified'))
   group.add_argument('--write-all', '-a', action='store_true', dest='force_all',
                    help=__('write all files (default: only write new and '
                            'changed files)'))

The most usage one is ``Builder.build_update``::

   def build_update(self) -> None:
       """Only rebuild what was changed or added since last build."""
       self.compile_update_catalogs()
   
       to_build = self.get_outdated_docs()
       if isinstance(to_build, str):
           self.build(['__all__'], to_build)
       else:
           to_build = list(to_build)
           self.build(to_build,
                      summary=__('targets for %d source files that are out of date') %
  
The information about increatement build is mostly provides by ``StandaloneHTMLBuilder.get_outdated_docs``.
The 

Every build_xxx eventlly calls ``Builder.build``::

   def build(
       self,
       docnames: Iterable[str] | None,
       summary: str | None = None,
       method: str = 'update',
   ) -> None:
       """Main build method.
   
       First updates the environment, and then calls
       :meth:`!write`.
       """
       # ...
   
       # while reading, collect all warnings from docutils
       with logging.pending_warnings():
           updated_docnames = set(self.read())
   
       doccount = len(updated_docnames)
       logger.info(bold(__('looking for now-outdated files... ')), nonl=True)
       updated_docnames.update(self.env.check_dependents(self.app, updated_docnames))
       outdated = len(updated_docnames) - doccount
       if outdated:
           logger.info(__('%d found'), outdated)
       else:
           logger.info(__('none found'))
   
       if updated_docnames:
           # save the environment
           from sphinx.application import ENV_PICKLE_FILENAME
           with progress_message(__('pickling environment')), \
                   open(path.join(self.doctreedir, ENV_PICKLE_FILENAME), 'wb') as f:
               pickle.dump(self.env, f, pickle.HIGHEST_PROTOCOL)
   
           # global actions
           self.app.phase = BuildPhase.CONSISTENCY_CHECK
           with progress_message(__('checking consistency')):
               self.env.check_consistency()
       else:
           if method == 'update' and not docnames:
               logger.info(bold(__('no targets are out of date.')))
               return
   
       self.app.phase = BuildPhase.RESOLVING
   
       # filter "docnames" (list of outdated files) by the updated
       # found_docs of the environment; this will remove docs that
       # have since been removed
       if docnames and docnames != ['__all__']:
           docnames = set(docnames) & self.env.found_docs
   
       # determine if we can write in parallel
       if parallel_available and self.app.parallel > 1 and self.allow_parallel:
           self.parallel_ok = self.app.is_parallel_allowed('write')
       else:
           self.parallel_ok = False
   
       #  create a task executor to use for misc. "finish-up" tasks
       # if self.parallel_ok:
       #     self.finish_tasks = ParallelTasks(self.app.parallel)
       # else:
       # for now, just execute them serially
       self.finish_tasks = SerialTasks()
   
       # write all "normal" documents (or everything for some builders)
       self.write(docnames, list(updated_docnames), method)
   
       # finish (write static files etc.)
       self.finish()
   
       # wait for all tasks
       self.finish_tasks.join()

Call read::

    def read(self) -> list[str]:
        """(Re-)read all files new or changed since last update.

        Store all environment docnames in the canonical format (ie using SEP as
        a separator in place of os.path.sep).
        """
        logger.info(bold(__('updating environment: ')), nonl=True)

        self.env.find_files(self.config, self)
        updated = (self.env.config_status != CONFIG_OK)
        added, changed, removed = self.env.get_outdated_files(updated)

        # allow user intervention as well
        for docs in self.events.emit('env-get-outdated', self.env, added, changed, removed):
            changed.update(set(docs) & self.env.found_docs)

        # if files were added or removed, all documents with globbed toctrees
        # must be reread
        if added or removed:
            # ... but not those that already were removed
            changed.update(self.env.glob_toctrees & self.env.found_docs)

        if updated:  # explain the change iff build config status was not ok
            reason = (CONFIG_CHANGED_REASON.get(self.env.config_status, '') +
                      (self.env.config_status_extra or ''))
            logger.info('[%s] ', reason, nonl=True)

        logger.info(__('%s added, %s changed, %s removed'),
                    len(added), len(changed), len(removed))

        # clear all files no longer present
        for docname in removed:
            self.events.emit('env-purge-doc', self.env, docname)
            self.env.clear_doc(docname)

        # read all new and changed files
        docnames = sorted(added | changed)
        # allow changing and reordering the list of docs to read
        self.events.emit('env-before-read-docs', self.env, docnames)

        # check if we should do parallel or serial read
        if parallel_available and len(docnames) > 5 and self.app.parallel > 1:
            par_ok = self.app.is_parallel_allowed('read')
        else:
            par_ok = False

        if par_ok:
            self._read_parallel(docnames, nproc=self.app.parallel)
        else:
            self._read_serial(docnames)

        if self.config.root_doc not in self.env.all_docs:
            raise SphinxError('root file %s not found' %
                              self.env.doc2path(self.config.root_doc))

        for retval in self.events.emit('env-updated', self.env):
            if retval is not None:
                docnames.extend(retval)

        # workaround: marked as okay to call builder.read() twice in same process
        self.env.config_status = CONFIG_OK

        return sorted(docnames)

In ``Builder.build``, env are dump back to file:
  

- env.get_outdated_files
- builder.get_outdated_docs
- buildinfo
- use_index
- use_index
  
.. _options of sphinx-build: https://www.sphinx-doc.org/en/master/man/sphinx-build.html#options
