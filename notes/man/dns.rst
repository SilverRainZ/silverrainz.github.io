===
DNS
===

.. highlight:: console

Client
======

现代 Linux 发行版使用 :manpage:`systemd-resolved.service(8)` 接管 DNS。

查询域名::
   
   $ resolvectl query silverrainz.me  
   silverrainz.me: 185.199.109.153                -- link: wlan0
                   185.199.110.153                -- link: wlan0
                   185.199.108.153                -- link: wlan0
                   185.199.111.153                -- link: wlan0
                   2606:50c0:8000::153            -- link: wlan0
                   2606:50c0:8001::153            -- link: wlan0
                   2606:50c0:8002::153            -- link: wlan0
                   2606:50c0:8003::153            -- link: wlan0
   
   -- Information acquired via protocol DNS in 1.2779s.
   -- Data is authenticated: no; Data was acquired via local or encrypted transport: no
   -- Data from: network

Server
======
