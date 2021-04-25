===================
家用树莓派 3B+ 配置
===================

:Date: 2020-04-24

.. highlight:: console

.. contents::
   :local:

安装
====

B.T.W I use Arch ;-P

See https://archlinuxarm.org/platforms/armv8/broadcom/raspberry-pi-3

初始配置
========

安装必要的工具::

   # pacman -S base-devel neovim git wget
   # pacman -S proxychains-ng
   # pacman -S zsh zsh-syntax-highlighting zsh-autosuggestions

配置用户
========

#. 机器信息设置::

      # echo 'la-pi3' > /etc/hostname
      # hostnamectl set-hostname la-pi3

#. 更换 root 密码::

      # passwd la

#. 添加用户 la::

      # useradd --shell /usr/bin/zsh --create-home --groups users,wheel la
      # passwd la

#. 配置 root 权限::

      # pacman -S sudo visudo
      # visudo
      # su la
      $ sudo id

   配置 wheel 用户组免密码使用 sudo：:archwiki:`Sudo_(简体中文)#设置示例`

#. 管理登陆和 SSH 配置

   #. 导入 la 用户的 key::

         $ mkdir .ssh

      从 la-tlp450 执行 ``ssh-copy-id -i .ssh/pi3 la@la-pi3``

      .. note::

         记不住 authorized_keys 的名字和它的权限没有关系，
         用 ``ssh-copy-id`` 代替手动复制

   #. 禁用 root 登陆 :archwiki:`OpenSSH_(简体中文)#禁用或限制_root_账户登录`::

         $ vim /etc/ssh/sshd_config
         # systemctl restart sshd

      不要断开链接，新开一个 terminal 测试

   #. 删除 alarm 用户::

         # userdel --remove alarm

      .. note:: 如遇 "userdel: user alarm is currently used by process XXX" 提示，应当是该用户的 systemd 实例，kill 之

#. 创建常用的 $HOME 布局::

      *nix style
      $ mkdir bin
      XDG directories
      $ mkdir desktop downloads music pictures public documents games templates videos
      My workflow
      $ mkdir git workspace pkg

#. 导入 dotfiles::

      $ cd git
      $ git clone https://github.com/SilverRainZ/dotfiles
      $ cd dotfiles
      $ ./deploy.sh
      $ mkdir -p /home/la/.cache/zsh

    重新登陆


服务配置
========

对外服务：

=================== ==========
服务                端口
------------------- ----------
webdav              30500/http
nfs                 default
syncthing           default
syncthing-webui     30501/http
=================== ==========

文件服务
--------


创建常用的同步目录结构::

   $ cd ~/public
   $ mkdir tmp collection

挂载大容量存储
~~~~~~~~~~~~~~

.. todo:: 想用 ``systemctl --user`` 管理这个 mount，试了挺久没有成功，先放着

参考 `这篇文章 <https://www.thegeekdiary.com/how-to-auto-mount-a-filesystem-using-systemd/>`_
和 :manpage:`SYSTEMD.MOUNT(5)`::

   # blkid /dev/sda1
   # touch /usr/lib/systemd/system/$(systemd-escape --path '/mnt/la-wdbuzg0010bb').mount

.. note:: la-wdbuzg0010bb 是大学时期买的一个 1TB 的西数移动硬盘。
          一直闲置所以用来当树莓派的存储

.. note:: systemd 对 mount unit 的文件名有要求，使用 ``systemd-escape --path`` 转义之

编写 mount 文件如下：

.. code-block:: ini
   :caption: /usr/lib/systemd/system/mnt-la\x2dwdbuzg0010bb.mount

   [Unit]
   Description=Mount la-wdbuzg0010bb

   [Mount]
   User=%u
   What=/dev/disk/by-uuid/d7bfcb86-eb6e-47d8-8706-9c3210d0f9fb
   Where=/mnt/la-wdbuzg0010bb
   Type=ext4
   Options=defaults

   [Install]
   WantedBy=multi-user.target

Enable and start::

   $ systemctl enable --now mnt-la\\x2dwdbuzg0010bb.mount


设置共享目录（先移除已创建的 :file:`~/public` ）::

   $ ln -s /mnt/la-wdbuzg0010bb/la-pi3-public/ ~/public

WebDAV
~~~~~~

使用 :archpkg:`nginx-mainline` + :aur:`nginx-mainline-mod-dav-ext`
后者需要自己 build。根据 :archwiki:`WebDAV#Nginx` 做如下配置：

以下配置加入 :file:`/etc/nginx/nginx.conf`:

.. code-block:: nginx

   load_module /usr/lib/nginx/modules/ngx_http_dav_ext_module.so;

   # ...

   http {
       server {
           listen 30500;

           location / {
               root /mnt/la-wdbuzg0010bb/la-pi3-public;

               dav_methods PUT DELETE MKCOL COPY MOVE;
               dav_ext_methods PROPFIND OPTIONS;

               # Adjust as desired:
               dav_access user:rw group:rw all:r;
               client_max_body_size 0;
               create_full_put_path on;
               client_body_temp_path /srv/client-temp;
               autoindex on;

               allow 10.0.0.0/24;
               deny all;
           }
       }
   }

.. note::

   本来想用 ``root /home/la/public`` ，试了下发现不支持 follow symlink，只好用
   mnt 的地址 ``root /mnt/la-wdbuzg0010bb/la-pi3-public``

NFS
~~~

根据 :archwiki:`NFS` 来。

服务端
^^^^^^

安装并启动服务::

   # pacman -S nfs-utils
   # timedatectl set-ntp 1
   # systemctl enable --now nfs-server.service

共享 la-wdbuzg0010bb：

.. code-block::
   :caption: /etc/exports

   /mnt/la-wdbuzg0010bb/ 10.0.0.0/24(rw,sync,nohide)


客户端
^^^^^^

安装服务::

   # pacman -S nfs-utils

创建 systemd mount point::

   # touch /etc/systemd/system/$(systemd-escape --path '/mnt/la-wdbuzg0010bb').mount

编写 mount 文件如下：

.. code-block:: ini
   :caption: /etc/systemd/system/mnt-la\x2dwdbuzg0010bb.mount

   [Unit]
   Description=Mount la-wdbuzg0010bb

   [Mount]
   What=la-pi3:/mnt/la-wdbuzg0010bb
   Where=/mnt/la-wdbuzg0010bb
   Type=nfs
   TimeoutSec=30
   ForceUnmount=true

   [Install]
   WantedBy=multi-user.target

启动 client::

   # systemctl enable --now 'mnt-la\x2dwdbuzg0010bb.mount'

Syncthing
~~~~~~~~~

安装及配置::

   # pacman -S syncthing
   # systemctl enable --now syncthing@la.service

:archpkg:`syncthing` 提供的 systemd service 没有开启网页管理界面，通过
``systemctl edit`` 启用它::

   # systemctl edit --now syncthing@la.service

.. code-block:: ini
   :caption: /etc/systemd/system/syncthing@la.service.d/override.conf

   [Service]
   ExecStart=
   ExecStart=/usr/bin/syncthing -gui-address="http://0.0.0.0:30501" -no-restart -logflags=0

而后::

   # systemctl daemon-reload
   # systemctl restart syncthing@la.service

--------------------------------------------------------------------------------

.. isso::
