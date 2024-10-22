======
Pacman
======

.. highlight:: console

清除包缓存（保留最近一次）::

    # paccache -rk1 -ruk0

列出未使用的包::

    $ pacman -Qtdq

清理未使用的包::

    # pacman -Rns $(pacman -Qtdq)

Locally sign a key::

   # pacman-key --recv-keys KEY_ID
   # pacman-key --lsign-key KEY_ID
