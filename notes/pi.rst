===================
家用树莓派 3B+ 配置
===================

:Date: 2020-04-24

.. highlight:: console

安装
====

B.T.W I use Arch ;-P

See https://archlinuxarm.org/platforms/armv8/broadcom/raspberry-pi-3

初始配置
========

安装必要的工具::

   # pacman -S \
            base-devel \
            neovim \
            git \
            wget \
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

      $ mkdir -p \
        bin \
        desktop \
        downloads \
        git \
        music \
        pictures  \
        public \
        workspace \
        documents  \
        games  \
        pkg \
        templates \
        videos

#. 导入 dotfiles::

      $ cd git
      $ git clone https://github.com/SilverRainZ/dotfiles
      $ cd dotfiles
      $ ./deploy.sh
      $ mkdir -p /home/la/.cache/zsh

    重新登陆


服务配置
========

文件服务
--------


创建常用的同步目录结构::

   $ cd ~/public
   $ mkdir tmp collection

挂载大容量存储
~~~~~~~~~~~~~~

参考 `这篇文章 <https://www.thegeekdiary.com/how-to-auto-mount-a-filesystem-using-systemd/>`_
和 :man:`SYSTEMD.MOUNT(5)`

la-wdbuzg0010bb 是大学时期买的一个 1TB 的西数移动硬盘。

   # blkid /dev/sda1
   $ cd ~/.config/systemd/user
   $ touch $(systemd-escape --path '/mnt/la-wdbuzg0010bb').mount

.. note:: systemd 对 mount unit 的文件名有要求，使用 ``systemd-escape --path`` 转义之

.. code-block:: ini



WebDAV
~~~~~~

使用 :archpkg:`nginx-mainline` + :archpkg:`nginx-mainline-mod-dav-ext`

Syncthing
~~~~~~~~~

TODO

参考
====

.. [#] https://www.thegeekdiary.com/how-to-auto-mount-a-filesystem-using-systemd/

--------------------------------------------------------------------------------

.. isso::
