GnuPG
=====

.. warning:: TODO

    - 学习一下 GPG agent forward，zfox49 推荐：https://bigeagle.me/2016/07/GPG-and-SSH-agent-forwarding/
    - 买一个帅气的 yubikey

Q & A
-----

命令行输出含义
~~~~~~~~~~~~~~

这是我的新 key 的输出啦：

.. code-block:: console

    $ gpg -k i@srain.im
    pub   rsa4096 2017-08-16 [SC] [expires: 2018-08-16]
          99399D88F7B752BF364CD485A85E3925A6211F05
    uid           [ultimate] Shengyu Zhang (SilverRainZ) <i@srain.im>
    sub   rsa4096 2017-08-16 [E] [expires: 2018-08-16]

    $ gpg -K i@srain.im
    sec   rsa4096 2017-08-16 [SC] [expires: 2018-08-16]
          99399D88F7B752BF364CD485A85E3925A6211F05
    uid           [ultimate] Shengyu Zhang (SilverRainZ) <i@srain.im>
    ssb   rsa4096 2017-08-16 [E] [expires: 2018-08-16]

每个密钥的输出都有四行，大概是这么个意思：

.. code-block:: none
    :linenos:

    密钥类型 算法&位长 创建时间 [用途] [expires: 过期时间]
        密钥指纹
    用户ID [信任级别] 真实姓名 (注释) <电子邮箱>
    同第一行

第四行也是一个密钥，并且根据下面的解释，它是一个子密钥，其出现的原因见：
`为什么新密钥也会有子钥`_

根据 这篇文章 [#]_ 的说法，密钥类型的其含义为（很糟糕的缩写）：

    - sec => 'SECret key'
    - ssb => 'Secret SuBkey'
    - pub => 'PUBlic key'
    - sub => 'public SUBkey'

用途(Usage flag)中大写字母的含义为：

    - S => PUBKEY_USAGE_SIG  => key is good for signing
    - C => PUBKEY_USAGE_CERT => key is good for certifying other signatures
    - E => PUBKEY_USAGE_ENC  => key is good for encryption
    - A => PUBKEY_USAGE_AUTH => key is good for authentication

用户 ID:
    以 uid 开头的行代表这一行的信息都是有效的用户 ID，能够确定密钥的任意信息，
    包括姓名，注释，邮箱，GPG 对 uid 的处理比较灵活，因此某些情况下会出现歧义
    这个时候可以用密钥的短 ID 或者完整的指纹来确定密钥。

Key Server 上的密钥过期了怎么办
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

上传到 key server 上的只是公钥，过期(Expire)也是相对于公钥而言的，因为私钥应当
永远被保密，且其控制权完全在于拥有者。拥有私钥的人有权控制公钥的有效期，因此在
gpg 中，仅需 ``gpg --edit-key <uid>`` ，选中相应的密钥对，执行 ``expire`` 命令
重设有效时间，然后再次上传公钥 ``gpp --keyserver xxxx --sendkey xxxx`` 即可。

为什么新密钥也会有子钥
~~~~~~~~~~~~~~~~~~~~~~

Debian Wiki [#]_ 如是说：

    GnuPG actually uses a signing-only key as the master key, and creates an
    encryption subkey automatically.

即 GPG 创建密钥时，主密钥仅用于签名，若用户有加密的需求，会另外创建一个子密钥用
于加密， 对照上面的输出::

    pub   rsa4096 2017-08-16 [SC] [expires: 2018-08-16]
    ...
    sub   rsa4096 2017-08-16 [E] [expires: 2018-08-16]

子密钥确实是只用于加密 ``[E]`` 的，另，可以通过 ``gpg --full-gen-key`` 创建一个
仅用于签名的密钥，你会发现它的输出就只有三行，不再包含额外的子钥。

如何添加子钥
~~~~~~~~~~~~

``gpg --edit-keys <keyid>`` 之后用 ``addkey`` 命令添加即可，子钥没有独立的
UID，也没法单独从 key server 获取下来，所以大概没办法只用子钥在社区源打包了。

对 key server 的操作是不可撤销的
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

即使你的密钥已经过期，key server 也不会将它删除，而仅仅是显示 "revoked"，即你
可以标记你的操作已经失效但没办法撤销这个操作 :-(，同理，如果你上传了错误的 UID，
错误的 subkey，即使在本地将其删除再上传也没办法将其删除，只能将其 revoke。

Tips
----

- 使用 USTCLUG 的崔主席密钥服务器：https://sks.ustclug.org/，``--recv-keys``
  速度飞快。
- GPG 默认将 `~/.gunpu` 的权限设置为 700，只有你自己才能访问你的密钥

命令行参数备忘
--------------

列出本机上的密钥

::

    gpg --list-keys

删除公钥

::

    gpg --delete-key <ID>

删除私钥

::

    gpg --delete-secret-key <ID>

导出 ASCII 形式的公钥

::

    gpg --armor --output public-key.txt --export <ID>

生成指纹

::

    gpg --fingerprint <ID>

加密解密

::

    gpg --recipient <ID> --output demo.en.txt --encrypt demo.txt

    gpg --decrypt demo.en.txt --output demo.de.txt

签名

::

    # 为文件生成单独的签名
    gpg --detach-sign demo.txt

    # 生成单独的 ASCII 格式的签名
    gpg --armor --detach-sign demo.txt

    # 校验签名
    gpg --verify demo.txt.sig demo.txt


.. [#] https://www.void.gr/kargig/blog/2013/12/02/creating-a-new-gpg-key-with-subkeys/
.. [#] https://wiki.debian.org/Subkeys#What_are_subkeys.3F
