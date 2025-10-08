======
Python
======

.. highlight:: python

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


Deep Copy::

    copy.deepcopy()


Basic Type Casting/Conversion
=============================

String to bytes::

    'str'.encode()

Bytes to string::

    b'bytes'.decode('utf8')

Hex string to bytes::

    bytes.fromhex('dead')

Dict to tuple list::

    dict.items()

List to set::

    set([1, 1, 1])

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

Auto Enumerations like `iota` in golang::

   from enum import Enum, auto
   class Color(Enum):
       RED = auto()
       GREEN = auto()
       BLUE = auto()

File Operations
===============

Temp file with real path::

    f = tempfile.NamedTemporaryFile()
    f.name

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

Packing
=======

Check pypi upload error:

.. code:: console

   $ twine check dist/*

Check source and wheel content:

.. code:: console

   $ tar tf dist/*.tar.gz
   $ unzip -l dist/*.whl

Get package version (commonly used for ``--version``)::

    from importlib.metadata import version
    version('sphinxnotes.any')

Install package from GitHub::

   git+https://github.com/python/mypy.git@master

.. seealso:: `VCS Support - pip documentation <https://pip.pypa.io/en/stable/topics/vcs-support/>`_
