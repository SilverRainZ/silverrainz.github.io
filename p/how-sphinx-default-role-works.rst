=============================
How Sphinx Default Role Works
=============================

What is "default role"?
=======================

   The default role (```content```) has no special meaning by default. You are free to use it for anything you like, e.g. variable names; use the default_role config value to set it to a known role – the any role to find anything or the py:obj role to find Python objects are very useful for this.

   —— https://www.sphinx-doc.org/en/master/usage/restructuredtext/roles.html#roles

.. tip::

   ``::`content``` is equal to ```content```, and both of them have same interpreted text "content" and rolename name "" (an empty string).


How it works? The principle is *temporarily registering the default role with an empty string when parsing*.

Setup "default role"
====================

Default-role can be configured by directive :dudir:`default-role` (doc-level) or confval :std:confval:`default_role` (project-level).

Default Role Registration
=========================

Current there are tow ways for registering default role, one for doc-level and one for project-level.

Project-level Registration
--------------------------

The :py:func:`sphinx.docutils.rst.default_role` is a :py:class:`contextlib.contextmanager`. As context of ``with`` clause: when entering clause, function register the default role with empty string, when leaving, unregister it

.. code:: python

   @contextmanager
   def default_role(docname: str, name: str) -> Iterator[None]:
       if name:
           dummy_reporter = Reporter('', 4, 4)
           role_fn, _ = roles.role(name, english, 0, dummy_reporter)
           if role_fn:
               docutils.register_role('', role_fn)  # type: ignore[arg-type]
           else:
               logger.warning(__('default role %s not found'), name, location=docname)

       yield

       docutils.unregister_role('')

.. hint:: We can learn :py:meth:`docutils.parsers.rst.roles.role` is a good way to lookup role funtion by name.

:py:class:`sphinx.builders.Builder` use ``default_role`` context when parsing each document:

.. code:: python

    @final
    def read_doc(self, docname: str, *, _cache: bool = True) -> None:
        """Parse a file and add/update inventory entries for the doctree."""

        # …
        with sphinx_domains(self.env), rst.default_role(docname, self.config.default_role):
            # set up error_handler for the target document
            codecs.register_error('sphinx',
                                  UnicodeDecodeErrorHandler(docname))  # type: ignore[arg-type]

            publisher.set_source(source_path=filename)
            publisher.publish()
            doctree = publisher.document

        # …

Doc-level registration
======================

Sphinx overrides docutils' :dudir:`default-role`` implementation, use :py:class:`sphinx.directives.DefaultRole` instead.

In the ``run`` method, directivees add default role name to :py:attr:`sphinx.environment.BuildEnvironment.temp_data`. ``temp_data`` is a document-independent storage.

.. note:: You may wonder why there is no logic for handling unregistering. In fact, the unregistering of the default role is always completed by the ``default_role`` context above.
