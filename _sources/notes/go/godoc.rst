=====
Godoc
=====

.. highlight:: console

Install
=======

Use `go install`::

   $ go install golang.org/x/tools/cmd/godoc@latest

Build from source (:ghrepo:`golang/tools`)::

   $ cd tools
   $ go build ./cmd/godoc/ -o doc

Usage
=====

   $ godoc -http=localhost:6060
