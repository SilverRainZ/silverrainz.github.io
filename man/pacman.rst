======
Pacman
======

.. highlight:: console

Remove packages cache (recent 1 installed packages and all uninstalled packages)::

    # paccache -rk1 -ruk0 paccache

Removing unused packages (orphans)::

    # pacman -Rns $(pacman -Qtdq)
