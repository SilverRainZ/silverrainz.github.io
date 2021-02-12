======
Python
======

.. highlight:: python

Deep Copy Object
================

Use :py:meth:`copy.deepcopy`.

Auto Enumerations
=================

Like ``iota`` in golang::

   from enum import Enum, auto
   class Color(Enum):
       RED = auto()
       GREEN = auto()
       BLUE = auto()

Sort Tuple List
===============

::

   tup_list.sort(key=lambda tup: tup[0])

Iterate with Index
==================

::

   for i, v in enumerate(arr):
       pass

Python in One Line
==================

List comprehension::

    [expression for item in list]

Dict comprehension::

    {key: value for vars in iterable}

Labmda::

    x = lambda a, b : a * b

..
    Assignment is not allowed in lambda.

Clone Object
============

Create object and copy attributes::

    dst = src.__class__.__new__(src.__class__)
    dst.__dict__.update(src.__dict__)

Basic Type Casting/Conversion
=============================

String to bytes::

    'str'.encode()

Bytes to string::

    b'bytes'.decode('utf8')

Dict to tuple list::

    dict.items()

List to set::

    set([1, 1, 1])

Unit Testing
============

Class
=====

Pass all arguments to parent constructor in child class::

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

Use class as plain old data structure (POD) via dataclasses [#]_::

    from dataclasses import dataclass

    @dataclass
    class InventoryItem:
        """Class for keeping track of an item in inventory."""
        name: str
        unit_price: float
        quantity_on_hand: int = 0

        def total_cost(self) -> float:
            return self.unit_price * self.quantity_on_hand

    # Constructor will be automatically generated::

    def __init__(self, name: str, unit_price: float, quantity_on_hand: int=0):
        self.name = name
        self.unit_price = unit_price
        self.quantity_on_hand = quantity_on_hand

.. note:: New in python 3.7.

File Operations
===============

Temp directory::

    tempfile.mkdtemp(prefix='blahblah')

Delete directory::

    shutil.rmtree(dir)

Get basename::

    os.path.basename()

Get extname::

    fn, ext = os.path.splitext(fn)

Create soft/symbolic link::

    os.symlink(src, dst)

.. [#] https://docs.python.org/3/library/dataclasses.html
