======
Python
======

Deep Copy Object
================

Use :py:meth:`copy.deepcopy`.

Auto Enumerations
=================

Like ``iota`` in golang:

.. code-block:: python

   from enum import Enum, auto
   class Color(Enum):
       RED = auto()
       GREEN = auto()
       BLUE = auto()

Sort Tuple List
===============

.. code-block:: python

   tup_list.sort(key=lambda tup: tup[0])

Iterate with Index
==================

.. code-block:: python

   for i, v in enumerate(arr):
       pass
