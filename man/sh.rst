============
Shell Script
============

-----------------------
sh, bash, zsh and so on
-----------------------

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
------

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

    $* # Default, an **array**
    $@ # Default, a **string**

The arguments of previous command::

    !^      # First one
    !$      # Last one
    !*      # All
    !:n     # N-th
    !:n-m   # Range n~m
