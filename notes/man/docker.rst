======
Docker
======

.. highlight:: console

Build image::

   $ docker build .

Get a clean Debian 10 shell with PWD mounted and 80 port exposed::

   $ docker pull debian:10
   $ docker run -it -v $PWD:/app -p 127.0.0.1:80:8080/tcp --name debian debian:10 bash

:`-i`, `--interactive`: Keep STDIN open even if not attached
:`-t`, `--tty`:         Allocate a pseudo-TTY
:`-v`:                  Start a container with a bind mount [#]_
:`-p`, `--expose`:      Bind port 8080 of the *container* to TCP port 80 of
                        *host* on 127.0.0 [#]_

Re-attach to it::

   $ docker exec -it debian bash

开机启动::

   $ docker update --restart=always name

复制文件::

   $ docker cp src.txt container:/dst.txt
   $ docker cp container:/src.txt dst.txt

.. [#] https://docs.docker.com/storage/bind-mounts/#start-a-container-with-a-bind-mount
.. [#] https://docs.docker.com/engine/reference/commandline/run/#publish-or-expose-port--p---expose
