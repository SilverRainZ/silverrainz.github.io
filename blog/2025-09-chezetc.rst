=======================================================
chezetc: Extending chezmoi to manage files under `/etc`
=======================================================

.. post::
   :tags: DevOps, Shell, dotfiles, Draft
   :author: LA
   :language: en
   :location: 燕郊

Extending chezmoi_ to manage files under ``/etc`` and other root-owned
directories.

For updates, please visit https://silverrainz.me/chezetc.

.. _chezmoi: https://www.chezmoi.io

Features
========

Chezetc enhances chezmoi, transforming it from a ``$HOME`` manager into a tool
that can seamlessly:

- Manage files in ``/etc`` and other directories owned by root.
- Manage multiple chezmoi repositories without manually specifying
  ``--config <PATH>``.

  .. note::

     This is particularly useful when managing files across different hosts,
     avoiding over-reliance on chezmoi's `templating`_ feature.

     .. _templating: https://chezmoi.io/user-guide/templating/

As chezetc is a wrapper around chezmoi, its usage is identical. Refer to the
Usage_ section for details.

Installation
============

Arch Linux users can install chezetc from the AUR or archlinuxcn::

   $ paru -S chezetc

For other distributions, ensure the following dependencies are installed:

- chezmoi
- sudo (must be properly configured; see `Sudo Configuration`_)
- coreutils
- bash
- gettext (provides ``envsubst``)

The following dependencies are optional but highly recommended. Without them,
you cannot customize the `Chezmoi Configuration`_:

- python >= 3.7
- python-tomli
- python-tomli-w

Then, clone the repository::

   $ git clone https://github.com/SilverRainZ/chezetc.git ~/.chezetc

Finally, add ``~/.chezetc`` to your ``$PATH``.

.. _Chezmoi Configuration: https://www.chezmoi.io/reference/configuration-file/
.. _Sudo Configuration: https://wiki.archlinux.org/title/Sudo#Configuration

Usage
=====

After installing dependencies and adding ``~/.chezetc`` to your ``$PATH``,
you can start managing your ``/etc`` files::

1. Initialize a new chezetc repository::

      $ chezetc init

   This is a one-time setup, and will This will create a new Git repository in
   ``~/.local/share/chezetc`` where chezmoi will store its source files.

2. Manage your first file with chezmoi, for example, your nginx config file::

      $ chezetc add /etc/hostname

   This will copy ``/etc/nginx/nginx.conf`` to ``~/.local/share/chezetc/nginx/nginx.conf``.

3. Edit the source file in your repository::

      $ chezetc edit ~/.local/share/chezetc/nginx/nginx.conf

   Or::

      $ chezetc edit /etc/nginx/nginx.conf

   This will open the corrsponding file in your ``$EDITOR``. Make some changes
   and save the file.

4. See what changes chezetc will apply::

   $ chezetc diff

5. Apply the changes (this will require sudo password)::

   $ chezetc -v apply

This workflow is the same as chezmoi, but it securely handles sudo permissions
to modify system files. See `Quick Start of chezmoi`_ guide for more details.

.. _Quick Start of chezmoi: https://www.chezmoi.io/quick-start/

Key Differences with Chezmoi
----------------------------

- The chezetc CLI tool usage is identical to chezmoi; all flags are forwarded::

     $ chezetc --help
     Manage your dotfiles across multiple diverse machines, securely

     Usage:
       chezmoi [command]

     ...

  However, **DO NOT** pass flags such as ``--config``, ``--cache``, etc.,
  to chezetc. Refer to the end of the `chezetc script`_ for a list of denied flags.

- The default configuration is read from ``~/.config/chezetc/chezetc.toml``.
  Only **TOML** format is supported. Avoid specifying items like ``sourceDir``,
  ``destDir``, etc. The full deny list is available in the
  `chezmoi.toml template`_.

- By default, chezetc manages ``/etc`` and stores the source files in
  ``~/.local/share/chezetc``, user can customize them via ``$ETC_DST`` and
  ``$ETC_SRC``, see `Configuration`_ for more details.

- The ``chezetc.toml`` file configures the wrapped chezmoi instance.
  See `Configuration`_ for configuring chezetc itself.

.. _chezetc script: ./chezetc
.. _chezmoi.toml template: ./chezmoi.toml

Configuration
=============

chezetc can be customized by setting environment variables:

``$ETC_SRC``
   :default: ``'~/.local/share/chezetc'``

   Overrides chezmoi's ``sourceDir`` configuration. Customize the source
   directory by setting this variable.

``$ETC_DST``
   :default: ``'/etc'``

   Overrides chezmoi's ``destDir`` configuration. Customize the target
   directory by setting this variable.

``$ETC_CFG``
   :default: ``'~/.config/chezetc/chezetc.toml'``

   Overrides chezmoi's ``--config`` flag. Customize the configuration file path by setting this variable.

``$ETC_MODE``
   :default: ``'CHEZMOI'``
   :choice: ``['CHEZMOI', 'BASH_COMPLETION', 'ZSH_COMPLETION']``

   Different modes affect the operating behavior of chezetc:

   :``CHEZMOI``: Run as chezmoi wrapper, this is the default behavior
   :``BASH_COMPLETION``: Print bash shell completion code,
                         see `Shell Completion`_ for more details
   :``ZSH_COMPLETION``: Print Z shell completion code,
                        see `Shell Completion`_ for more details

``$ETC_APP``
   :default: ``'chezetc'``

   The ID of the chezetc application.

   You can create a new, independent instance by setting a different value.
   This is ideal for managing files on a different host or in a different
   root-owned directory.

   See also `Per-Host Configuration Management`_.

``$EDITOR``
   Overrides chezmoi's ``edit.command`` configuration. Customize the
   preferred editor by setting this variable.

Tips
====

Shell Completion
----------------

chezetc reuses the `Shell Completion of Chezmoi`_, so make sure your have
it properly configured first.

Bash:
   Generate completion code::

      $ mkdir -p ~/.bash_completions/
      $ ETC_MODE=BASH_COMPLETION chezetc > ~/.bash_completions/chezetc

   Source the generated file in your ``.bashrc``::

      source ~/.bash_completions/chezetc

Z shell
   Generate completion code::

      $ mkdir -p ~/.zsh/completions/
      $ ETC_MODE=ZSH_COMPLETION chezetc > ~/.zsh/completions/_chezetc

   Add the path to ``$fpath`` in your ``.zshrc``, note that the statement
   **MUST** be placed before ``compinit``::

      fpath=(~/.zsh/completions $fpath)

.. _Shell Completion of Chezmoi: https://www.chezmoi.io/reference/commands/completion/

Per-Host Configuration Management
---------------------------------

Create a script (``~/bin/chezetc-host``), which demonstrates how to manage a
distinct set of files in ``/etc`` for each host, stored in a Git repository::

   #!/bin/bash

   export ETC_APP=$0
   export ETC_SRC="$HOME/git/etcfiles/$HOST"
   exec chezetc "$@"

Make it executable::

   $ chmod +x ~/bin/chezetc-host

Initialize and use the new instance::

   chezetc-host init
   chezetc-host add /etc/nginx/nginx.conf

The source file will be created in
``~/git/etcfiles/YOUR-HOSTNAME/nginx/nginx.conf``

Acknowledgements
================

- Thanks to `@twpayne`_ and all chezmoi developers for creating such a powerful tool.
- Chezetc is heavily inspired by `Discussion #1510`_.

.. _@twpayne: https://github.com/twpayne
.. _Discussion #1510: https://github.com/twpayne/chezmoi/discussions/1510
