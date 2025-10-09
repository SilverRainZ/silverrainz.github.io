===
Git
===

.. highlight:: console

永久忽略一个对已 commit 文件/目录 的修改::

    $ git update-index --assume-unchanged xxx

中文路径乱码::

    $ git config core.quotepath false

提交时使用无插件的 vim::

    $ git config --global core.editor "vim --noplugin"

Update fork from source::

    $ git remote add upstream https://github.com/ORIGINAL_OWNER/ORIGINAL_REPOSITORY.git
    $ git fetch upstream
    $ git checkout master
    $ git merge upstream/master

Create empty branch::

    $ git checkout --orphan YourBranchName

Delete remote tag::

    $ git push --delete origin tagname

将被忽略的语言（如 Markdown、restructuredText）计入 Languages 统计::

    *.rst linguist-detectable=true

Rebase 时保留 base 分支改动::

   git checkout --theirs <FILE>

重新提交时刷新日期::

   git commit --amend --date="$(date -R)"

GitHub
======

`我订阅的所有 Issue`__

__ https://github.com/notifications/subscriptions
