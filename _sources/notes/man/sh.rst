============
Shell Script
============

:date: 2020-12-26
:version: 1

.. highlight:: bash

String
======

Get length::

    ${#str}

Substring / Slice::

    ${str:1:4}

Replace::

    ${v%.md}.rst

Heredoc
-------

Syntax::

   cat <<EOF
   ... Heredoc content
   EOF

.. note:: Shell variables in heredoc will be expanded

Avoid shell expanding variables::

   cat <<'EOF'
   ... Heredoc ${content}
   EOF

Command Line Arguments
======================

Number of pass-in arguments::

    $#

The "pass-in argument list::

    $* # Default, an *array*
    $@ # Default, a *string*

The arguments of previous command::

    !^      # First one
    !$      # Last one
    !*      # All
    !:n     # N-th
    !:n-m   # Range n~m


Command Line Wrapper 模版
-------------------------

::

   #!/bin/bash

   EXEC="xxxx"

   exec $EXEC $*


Bash `set` options
==================

Get help::

   $ bash -c 'help set'

脚本常用参数：

:-e: Exit immediately if a command exits with a non-zero status.
:-x: Print commands and their arguments as they are executed.
:-u: Treat unset variables as an error when substituting.
