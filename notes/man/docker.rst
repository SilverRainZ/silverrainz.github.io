======
Docker
======

.. highlight:: console

Build image::

   $ docker build .

Get a clean Debian 10 shell with PWD mounted::

   $ docker pull debian:10
   $ docker run -it -v $PWD:/app debian:10 bash

:`-i`, `--interactive`: Keep STDIN open even if not attached
:`-t`, `--tty`:         Allocate a pseudo-TTY
:`-v`:                  `Start a container with a bind mount`__

__ https://docs.docker.com/storage/bind-mounts/#start-a-container-with-a-bind-mount
