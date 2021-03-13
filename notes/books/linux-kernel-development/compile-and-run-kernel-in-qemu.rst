Compile and Run Kernel in Qemu
==============================

ref:
http://mgalgs.github.io/2015/05/16/how-to-build-a-custom-linux-kernel-for-qemu-2015-edition.html

Environment
-----------

-  Arch Linux
-  GCC 5.3.0
-  Linux Kernel Source Code Tree 4.5.0
-  QEMU 2.5.0
-  BusyBox 1.24.2

Compile
-------

Get source code:
~~~~~~~~~~~~~~~~

::

    $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

Though this repo named 'linux-2.6', but its content is same as
``torvalds/linux.git``, :-(

Compile it:
~~~~~~~~~~~

::

    $ cd linux-2.6
    $ make defconfig
    $ make -j8

The compiled executable kernel located at ``linux-2.6/vmlinux``, the
compressed kernel image we needed is
``linx-2.6/arch/x86_64/boot/bzImage`` (bzip2 compressed)

Initramfs
---------

::

    $ mkdir initramfs
    $ cd initramfs
    $ cp /usr/bin/busybox .
    $ touch init
    $ chmod +x init

Input below script in file ``init``:

::

    #!/busybox sh

    /busybox mount -t proc none /proc
    /busybox mount -t sysfs none /sys

    exec /busybox sh

Then, run:

::

    $ cd initramfs
    $ find . -print0 \ 
        | cpio --null -ov --format=newc \
        | gzip -9 > ../initramfs-busybox-x86_64.cpio.gz

Run
---

::

     qemu-system-x86_64 \
        -kernel linux-2.6/arch/x86_64/boot/bzImage \
        -initrd initramfs-busybox-x86_64.cpio.gz \
         -nographic -append "console=ttyS0"
