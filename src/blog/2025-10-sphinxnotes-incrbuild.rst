==============================================================================
sphinxnotes-incrbuild: Enabling Sphinx incremental builds in CI/CD environment
==============================================================================

.. post:: 2025-10-15
   :tags: Sphinx, CI
   :author: LA
   :category: Sphinx, 新项目
   :language: en
   :location: 昆明
   :external_link: https://sphinx.silverrainz.me/incrbuild/

As we know, Sphinx supports incremental HTML build, and it works well locally. But for CI/CD, the environment is usually brand new, which causes Sphinx always to rebuild everything. The project wraps ``sphinx-build`` and ensures the environment is "incremental build"-able before running the real ``sphinx-build``.
