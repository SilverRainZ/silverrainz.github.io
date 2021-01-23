===
Awk
===

:date: 2020-12-25
:version: 1


Basic structure of an awk program:
   In short, an Domain Specified Language for pattern matching.

   .. code-block:: awk

      pattern { action }

Pass shell variables into awk

   .. code-block:: shell

      awk '{print $home}' home=$HOME

Use regular expression

   The regex must be enclosed by slashes(`/`), and comes after the operator.

   .. code-block:: awk

      /regex_pattern/ { print 1 }

Print remaining columns: [#]_

   .. code-block:: awk

      { $1=""; print $0 }

Print a character arbitrary times:

   ``printf`` is not possible to do this, use ``for`` loop.

   .. code-block:: awk

      { for(c=0;c<50;c++) printf "-"; printf "\n" }

Edit inplace:
    ``-i inplace``


.. [#] https://stackoverflow.com/a/2961994

.. seealso::

    - https://www.grymoire.com/Unix/Awk.html
