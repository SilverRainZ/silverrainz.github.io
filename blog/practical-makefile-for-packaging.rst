========================================
 编写便于打包的 Makefile
========================================

.. post:: 2016-06-25
   :tags: Linux, C, Makefile
   :author: LA
   :language: zh

..

   Note: 这篇文章假设你已经知道基本的 Makefile 编写规则

.. contents::

前言
----

安装基于 make 构建的程序基本上就是两个步骤：\ ``make`` 然后 ``make install``\ ，
前者把程序按依赖关系编译，后者把文档、数据、编译出来的二进制安装到系统中。
网络上关于 GNU Make 的教程不少，但似乎都止于「如何用 Makefile 自动编译程序」（\ ``make``\ ），
而关于用 Makefile 编写安装脚本（\ ``make install``\ ）的文章却寥寥无几。

..

   2016-08-10: 经 盖子 提醒，make 本来就不适合做这种事情，于是才有了 autotools
   这「更好」的构建工具。


最近在写 `Srain <https://github.com/SilverRainZ/srain>`_ 的时候，
算是摸索出了对于 ``make install`` 的比较正确的写法：

首先，对于项目生成产物只是单个可执行文件的情况下，直接在 install 目标里写
``install -Dm755 xxx /usr/bin/xxx`` 就好了。
但是并非所有项目都只包含单个可执行文件，程序可能还包含了 man 文档，icons，
图片，配置文件等，这些都要被安装到文件系统相应的位置上。

我们先假设项目的结构如下，代码写了什么不重要~

.. code-block::

   .
   ├── build
   ├── data
   │   ├── pixmaps
   │   │   └── srain-avatar.png
   │   └── icons
   │       └── 16x16
   │           └── srain-icon.png
   ├── Makefile
   └── srain.c

build 是存放编译中间文件和编译出来的二进制文件的地方，srain.c 是主程序代码，
srain-avatar.png 是程序要用到的图片。srain-icon.png 是程序图标。

安装图标
--------

对于图标，Icon Theme Specification\ [#fn-icon-theme-spec]_
规定了图标在文件系统上的位置，程序只需要根据图标的名称（即文件名去掉扩展名）
和大小就可以获得图标文件的路径
（当然要借助各种库函数，比如 gtk 的 ``gtk_image_new_from_icon_name``\ ），
因此我们只要将图标文件复制到对应的位置上即可。

根据上面的 spec，程序寻找图标时应该依次检查 ``$HOME/.icons``\ 、\ ``$XDG_DATA_DIRS/icons`` 和 ``/usr/share/pixmaps``\ 。

参照 XDG Base Directory Specification\ [#fn-xdg-base-dir-spec]_ 看，
当 ``$XDG_DATA_DIRS`` 为空时，\ ``$XDG_DATA_DIRS`` 会默认为 ``/usr/local/share/:/usr/share/``
（感谢 csslayer 指出）。

因此把图标安装在 ``/usr/share/pixmaps``\ 、\ ``/usr/local/share/icons`` 和 ``/usr/share/icons``
下都是可行的，Arch Linux 偏向于安装在最后一个目录。
于是安装 *大小为 16x16 的图标* 的脚本可以这么写：

.. code-block:: shell

   cd data/icons/16x16; \
       for png in *.png; do \
           install -Dm644 "$$png" \
               "$(DESTDIR)/usr/share/icons/hicolor/16x16/apps/$$png"; \
       done

这里先不管 ``$(DESTDIR)`` 是什么东西，把它当作空变量即可：

.. code-block:: shell

   install -Dm644 "$$png" \
       "/usr/share/icons/hicolor/16x16/apps/$$png"; \

PREFIX
------

除了图标之外，其他的数据文件应该如何组织？
至少我们应该做到的是：


* 保证程序一定能找到数据文件
* 一定程度上允许用户自定义安装的位置

GNU make 提供了 prefix 等变量确定各种文件安装的位置\ [#fn-prefix]_\ ：


* ``prefix`` 是下述变量的前缀，默认的 prefix 值应该是 ``/usr/local``

  * ``exec_prefix`` 是下述变量的前缀，通常和 ``prefix`` 相等

    * ``bindir`` 安装可执行文件的位置，其值应为 ``$(exec_prefix)/bin``
    * ...

  * ``datarootdir`` 用来安装只读的，架构无关的数据文件，其值应为 ``$(prefix)/share``
  * ``sysconfdir`` 用来安装只读的配置文件，其值应为 ``$(predix)/etc``
  * ...

上面列出了各种用途的变量，但事实上我们不需要把数据文件分成那么细的粒度。
对于简单的项目，只有 prefix 是必要的，其他路径都可以 hardcode。

``make install`` 可以这么写（为了命名统一，prefix 用大写）：

.. code-block:: Makefile

   PREFIX = /usr/local

   install:
       install -Dm755 "build/srain" "$(PREFIX)/bin/srain"
       cd data/pixmaps; \
           for png in *.png; do \
               install -Dm644 "$$png" \
                   "$(PREFIX)/share/srain/pixmaps/$$png"; \
           done

放置各种文件的规范有了，但程序应该如何找到他的数据文件呢？
用 gcc 的 ``-D`` 参数声明一个宏，在编译的时候告诉程序的 prefix：

.. code-block:: Makefile

   CC = gcc
   CFLAGS = -O2 -Wall
   DEFS = -DPACKAGE_DATA_DIR=\"$(PREFIX)\"

   TARGET = build/srain

   $(TARGET): srain.c
       $(CC) $(CFLAGS) $(DEFS) $^ -o $@

在程序中你就可以根据这个宏在获得你的数据文件：

.. code-block:: c

   #ifndef PACKAGE_DATA_DIR
   #define PACKAGE_DATA_DIR "/usr/local"
   #endif

   gchar *get_pixmap_path(const gchar *filename){
       gchar *path;

       path = g_build_filename(PACKAGE_DATA_DIR, "share",
               "srain", "pixmaps", filename, NULL);

       if (g_file_test(path, G_FILE_TEST_EXISTS)){
           return path;
       }

       g_free(path);
       return NULL;
   }

注意上面的代码使用了 glib 函数库，当指定 prefix 为 ``/usr``\ ，
程序便会从 ``/usr/share/srain/pixmaps`` 里寻找图片。

..

   自行编译安装的程序通常被安装在 ``/usr/local``\ , 这也是 GNU 推荐的 prefix，
   Arch Linux 的包的 prefix 通常是 ``/usr``\ 。


如上一番设定后，程序经过编译和安装后便可以运行指定的任意目录上了，
你也可以指定为 ``$(PWD)/build`` 方便调试。

``make PREFIX=/usr; make PREFIX=/usr install`` 后，产生的文件如下：

.. code-block::

   /usr/bin/srain
   /usr/share/srain/pixmaps/srain-avatar.png
   /usr/share/icons/hicolor/16x16/apps/srain-icon.png

``make PREFIX=/home/la/tmp; make PREFIX=/home/la/tmp install`` 则是：

.. code-block::

   /home/la/tmp/bin/srain
   /home/la/tmp/share/srain/pixmaps/srain-avatar.png
   /usr/share/icons/hicolor/16x16/apps/srain-icon.png

DESTDIR
-------

上面的 ``make install`` 直接将各种文件安装在了目的文件系统上，如果 Makefile 写错的话，
可能对系统造成破坏，直接安装也不利于打包，正确的做法是，由 ``make install`` 
得到程序所有文件的列表和路径，再由包管理器把这些文件和路径存为软件包，
安装的时候根据路径把文件放到应该放的位置（这大概就是 Staged Install？）。
（这里感谢青蛙老师 :people:`hexchain <https://hexchain.org>` 的指导）

变量 ``DESTDIR``\ [#fn-destdir]_ 就是用来实现 Staged Install 的，把之前的 ``make install`` 改成这样：

.. code-block:: Makefile

   PREFIX = /usr/local
   install:
       install -Dm755 "build/srain" "$(DESTDIR)$(PREFIX)/bin/srain"
       cd data/pixmaps; \
           for png in *.png; do \
               install -Dm644 "$$png" \
                   "$(DESTDIR)$(PREFIX)/share/srain/pixmaps/$$png"; \
           done

注意 DESTDIR 变量只应该作用在 install 阶段，\ ``make PREFIX=/usr; make PREFIX=/usr DESTDIR=/tmp/``
会把所有文件都安装在 ``/tmp`` 下， 所有的影响都被限制在该目录内。这次生成的文件应该是：

.. code-block::

   /tmp/usr/bin/srain
   /tmp/usr/share/srain/pixmaps/srain-avatar.png
   /tmp/usr/share/icons/hicolor/16x16/apps/srain-icon.png

之后再由包管理器把这些文件打成包，安装到系统中。

Configure
---------

上面的 Makefile 有处不优雅的地方是，\ ``make`` 和 ``make install`` 的时候必须指定相同的 PREFIX，
不然安装后的程序肯定是运行不了的，而 make 本身并不能解决这个问题，因为 make 是「无状态」的。

这里\ [#fn-practical-makefiles]_\ 提供了一个脚本来让解决这个问题，将 Makefile 改名为 Makefile.in，
运行 ``./configure --prefix=xxx`` 来获得一个拥有指定 prefix 的 Makefile，
这样就可以不用每次敲 make 都输入 ``PREFIX=xxx`` 了。

:del:`于是大家都去用 autotools 了`

.. code-block:: sh

   #!/bin/sh

   prefix=/usr/local

   for arg in "$@"; do
       case "$arg" in
       --prefix=*)
           prefix=`echo $arg | sed 's/--prefix=//'`
           ;;

       --help)
           echo 'usage: ./configure [options]'
           echo 'options:'
           echo '  --prefix=<path>: installation prefix'
           echo 'all invalid options are silently ignored'
           exit 0
           ;;
       esac
   done

   echo 'generating makefile ...'
   echo "PREFIX = $prefix" >Makefile
   cat Makefile.in >>Makefile
   echo 'configuration complete, type make to build.'

如上，执行 ``./configure --prefix=/usr`` 就会把 Makefile.in 复制为 Makefile，并在
Makefile 最前面加上一句 ``PREFIX = /usr``\ （实际操作顺序是反过来的你们懂就好）。

编写 Archlinux 的打包脚本 PKGBUILD
----------------------------------

这样的一个项目打包起来是很愉快的 :)

.. code-block:: sh

   pkgname=srain

   ...
   build() {
       cd ${pkgname}
       mkdir build || true
       ./configure --prefix=/usr
       make
   }

   package() {
       cd ${pkgname}
       make DESTDIR=$pkgdir install
   }

完整的脚本请见：\ `srain.git - AUR Package Repositories <https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=srain>`_\ ，
可能稍有出入。

参考
----


.. [#fn-icon-theme-spec] `Icon Theme Specification <https://specifications.freedesktop.org/icon-theme-spec/icon-theme-spec-latest.html>`_\
.. [#fn-xdg-base-dir-spec] `XDG Base Directory Specification#Environment variables <https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html#Environment%20variables>`_\
.. [#fn-prefix] `GNU Coding Standards#Variables for Installation Directories <https://www.gnu.org/prep/standards/html_node/Directory-Variables.html>`_\
.. [#fn-destdir] `GNU Coding Standards#DESTDIR: Support for Staged Installs <https://www.gnu.org/prep/standards/standards.html#DESTDIR>`_\
.. [#fn-practical-makefiles] `Practical Makefiles, by example <http://nuclear.mutantstargoat.com/articles/make>`_\
