=====
rsync
=====

.. highlight:: console

经典的备份命令::

   $ rsync -av -r -d --delete SRC DEST

:--archive, -a:      Archive mode
:--verbose, -v:      Increase verbosity
:--recursive, -r:    Recurse into directories
:--dirs, -d:         Transfer directories without recursing


:--delete:           Delete extraneous files from dest dirs

关于 `-r` 和 `-d` 的区别，:manpage:`rsync(1)` 如是说：

   Tell the sending side to include any directories that are encountered.  Unlike `--recursive`, a directory's contents are not copied unless the directory name specified is "." or ends with a trailing slash (e.g.  ".", "dir/.", "dir/", etc.).  Without this option or the `--recursive` option, rsync will skip all directories it encounters (and output a message to that effect for each one). If you specify both `--dirs` and `--recursive`, `--recursive` takes precedence.

并没有看懂……
