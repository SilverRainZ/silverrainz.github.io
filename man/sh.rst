============
Shell Script
============

-----------------------
sh, bash, zsh and so on
-----------------------

:date: 2020-12-26
:version: 1

Heredoc syntax:

.. code-block:: bash

   cat <<EOF
   ... Heredoc content
   EOF

.. note:: Shell variables in heredoc will be expanded

Avoid shell expanding variables in heredoc:

.. code-block:: bash

   cat <<'EOF'
   ... Heredoc ${content}
   EOF

Replace ext in filename

.. code-block:: bash

   ${v%.md}.rst
