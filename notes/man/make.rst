========
Makefile
========

.. highlight:: Makefile

Automate variables::

     foo.out: bar1.c bar2.c bar1.c
   # ^^^^^^^  ^^^^^^
   # $@       $<
   # ^^^      ^^^^^^^^^^^^^^^^^^^^
   # $*       $+ (dup)
   #          ^^^^^^^^^^^^^
   #          $^ (dedup)
   #          ^^^^^^^^^^^^^
   #          $^ (newer that $@)


Template for python project::

   LANG = en_US.UTF-8

   MAKE = make
   PY   = python3
   RM   = rm -rf

   .PHONY: doc
   doc:
       $(MAKE) -C doc/

   .PHONY: dist
   dist: setup.py
       $(RM) dist/ build/ *.egg-info/
       $(PY) setup.py sdist bdist_wheel
       $(PY) -m twine check dist/*

   .PHONY: upload
   upload: dist/
   	   $(PY) -m twine upload --repository pypi $<*

   .PHONY: test
   test:
   	   $(PY) -m unittest -v
