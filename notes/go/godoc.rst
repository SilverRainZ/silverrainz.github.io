=====
Godoc
=====

.. highlight:: console

Build a latest godoc from :ghrepo:`golang/tools` repository::

   $ cd tools
   $ go build ./cmd/godoc/ -o doc
   $ ./doc -http=localhost:6060
