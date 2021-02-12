===
Awk
===

:date: 2020-12-25

.. highlight:: awk

Basic structure of an awk program is ``pattern { action }``, in short,
an Domain Specified Language for pattern matching.

Pass shell variables into awk::

    awk '{print $home}' home=$HOME

Use regular expression::

    # (The regex must be enclosed by slashes(``/``), and comes after the operator)
    /regex_pattern/ { print 1 }

Print remaining columns [#]_ ::

      { $1=""; print $0 }

Print a character arbitrary times, ``printf`` is not possible to do this,
use ``for`` loop::

      { for(c=0;c<50;c++) printf "-"; printf "\n" }

Edit inplace:

.. code-block:: sh

    awk -i inplace

.. [#] https://stackoverflow.com/a/2961994

.. seealso::

    - https://www.grymoire.com/Unix/Awk.html
