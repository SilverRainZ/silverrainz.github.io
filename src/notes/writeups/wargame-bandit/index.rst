wargme-bandit
=============

-  ssh addr: bandit.labs.overthewire.org
-  url: http://overthewire.org/wargames/bandit/

bandit0
'''''''

flag: bandit0

bandit1
'''''''

flag: boJ9jbbUNNfktd78OOpsqOltutMc3MY1

bandit2
'''''''

flag: CV1DtqXWVFXTvM2F0k09SHz0YwRINYA9

bandit3
'''''''

flag: UmHadQclWmgdLOKQ3YNgjWxGoRMb5luK

bandit4
'''''''

flag: pIwrPrtPN36QITSp3EQaw936yaFoFgAB

bandit5
'''''''

flag: koReBOKuIDDepwhWk7jZC0RTdopnAYKh

bandit6
'''''''

flag: DXjZPULLxYr17uwoI01bNLQbtFemEgo7

::

    find -size 1033c | xargs ls -l

bandit7
'''''''

flag: HKBPTKQnIay4Fw76bEy8PVxKEDQRKTzs

::

    find / -user bandit7 -group bandit6 -size 33c

bandit8
'''''''

flag: cvX2JJa4CFALtqS87jk27qwqGhBM9plV

bandit9
'''''''

flag: UsvVyFSfZZWbi6wgC7dAFyFuR6jQQUhR

::

    cat data.txt | tr [a-z] [A-Z] | sort | uniq -u
    grep -i USVVYFSFZZWBI6WGC7DAFYFUR6JQQUHR data.txt

bandit10
''''''''

flag: trukldjsbj5g7yyj2x2r0o3a5hqjfulk

::

    grep -a data.txt

bandit11
''''''''

flag: IFukwKGsFW8MOq3IRFqrxE1hxTNEbUPR

::

    base64 -d data.txt

bandit12
''''''''

flag: 5Te8Y4drgCRfCx8ugdwuEX8KFC6k2EUu

::

    tr 'N-ZA-Mn-za-m' 'A-Za-z' < data.txt

bandit13
''''''''

flag: 8ZjyCRiBWFYkneahHwxCv3wb2a1ORpYL

经历了多少次的解压缩...

bandit14
''''''''

flag: 4wcYUJFw0k0XLShlDzztnTBHiqxU3b3e

::

    scp bandit13@bandit.labs.overthewire.org:/home/bandit13/sshkey.private ~
    chmod 0600 sshkey.private
    ssh -i ~/sshkey.private bandit14@bandit.labs.overthewire.org

bandit15
''''''''

flag: BfMYroe26WYalil77FoDi9qh59eK5xNr

::

    nc localhost 30000

输入 bandit14 的密码即可

bandit16
''''''''

flag: cluFn7wTiGryunymYOu4RcffSxQluehd

::

    $ openssl s_client -connect localhost:30001 -ssl3 -quiet

输入 bandit15 的密码即可

bandit17
''''''''

flag: xLYVMN9WE5zQ5vHacb0sZEVqbrp7nBTn

注意登入远程主机时的说明，这次我们对 `/var/tmp/` 没有写权限， 用
`mktemp -d` 建立临时目录，对该目录我们就有写权限。

::

    $ mktemp -d
    $ nc -v -w 2 localhost 31000-32000 2>a
    # 为什么连接成功的提示也会在 `stderr` 里面？
    $ grep succeeded
    # 只有五个端口，一个一个试：
    $ openssl s_client -connect localhost:31xxx -ssl3 -quiet
    # 最后 `31790` 返回了一个 rsa 私钥，
    $ openssl s_client -connect localhost:31790 -ssl3 -quiet > key
    $ chmod 0600 key
    $ ssh -i bandit17.key bandit17@bandit.labs.overthewire.org
    $ cat /etc/bandit_pass/bandit17
    # done.

bandit18
''''''''

flag: kfBf3eYk5BPBRzwjqutbbfE887SVc5Yd

::

    diff *.new *.old -c1

bandit19
''''''''

flag: IueksS7Ubh8G3DCwVzrTd8rAVOwq3M5x

::

    ssh -t bandit18@bandit.labs.overthewire.org /bin/sh

bandit20
''''''''

flag: GbKksEFF4yrVs6il55v6gwY5aVje5f0j

有关 setgid 和 setuid。

::

    ./bandit20-do cat /etc/bandit_pass/bandit20

bandit21
''''''''

flag: gE269g2h3mw3pwgrj0Ha9Uoqen1c9DGr

::

    echo GbKksEFF4yrVs6il55v6gwY5aVje5f0j | nc -l -p 1234 & ./suconnect 1234

bandit22
''''''''

flag: Yk7owGAcWjwMVRwrTesJEwB7WVOiILLI

::

    cat /etc/cron.d/cronjob_bandit22
    cat /usr/bin/cronjob_bandit22.sh
    cat /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv

bandit23
''''''''

flag: jc1udXuA1tiHqjIsL8yaapX5XIAI6i0n

::

    cat /usr/bin/cronjob_bandit23.sh
    echo I am user bandit23| md5sum | cut -d ' ' -f 1

bandit24
''''''''

flag: UoMYTrfrBFHyQXmg6gzctqAwOmw1IohZ

这道题卡了...以为密码会藏在被删掉的脚本里. 第二天想起原来 cron
执行的时候用的是 bandit24 的权限嘛... 所以写一个脚本, 属性最好 chmod
777:

::

    #!/bin/sh
    cp /etc/bandit_pass/bandit24 /tmp/tmp.xxx/psw
    chmod 666 /tmp/tmp.xxx/psw

即使是这么个小脚本也卡我半天...

*注意:*

-  别把 bandit24 写错...
-  把 tmp 目录的读写权限全部开放(似乎不用)
-  不能用重定向(权限不够)
-  sh 不一定在 /usr/bin/sh

bandit25
''''''''

flag: uNG9O58gUE7snukf3bvZ0rxhtnjzSGzG

没看清题意就瞎做...

::

    for i in {0000..9999}; do echo "UoMYTrfrBFHyQXmg6gzctqAwOmw1IohZ $i" >> /tmp/pin; done
    cat /tmp/pin | nc localhost 30002 > /tmp/log
    cat /tmp/log | grep "Corr|Succ"

答案果然在最后一个...

bandit26
''''''''

flag: 5czgV9L3Xx8JPOyRbXh6lQbmIOWvPT6Z

这一题难倒我了...答案是从网上看的 在 bandit25 给出了 bandit26 的私钥,
登录上去显示了 bandit26 的 ASCII art 之后退出:

::

    cat /etc/passwd | grep bindit26

发现 bandit26 的 shell 是奇怪的 /usr/bin/showtext (然后就卡这里不动了)
答案：\ `Answer <http://codebluedev.blogspot.com/2015/07/overthewire-bandit-level-26.html>`__
根本没想到去看 showtext 是什么内容

::

    cat /usr/bin/showtext

发现是 more 了一个文档然后直接退出. 所以把虚拟终端的宽度调成 4,
再连接上：

::

    ssh -i ~/bandit26.private bandit14@bandit.labs.overthewire.org

more 会因为分页 停下来... 此时按 v
键可以用默认编辑器(vi)编辑该文件，就可以读取密码了。

::

    :r /etc/bandit_pass/bandit26
    :set shell sh=/bin/sh
    :sh

进入 shell 执行 wechall 拿分 (more 这一招好脑洞)

bandit27
''''''''

还没有 bandit27
