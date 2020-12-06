Git
===

永久忽略一个对已 commit 文件/目录 的修改

::

    git update-index --assume-unchanged xxx

撤销本地 commit， **注意做好备份！**

::

    git reset --hard <commit_id>

撤销已 push 到远程的 commit， **注意做好备份！**

::

    git reset --hard <commit_id>
    git push origin HEAD --force

修改最后一次提交

::

    git commit --amend

中文路径乱码

::

    git config core.quotepath false

提交时使用无插件的 vim

::

    git config --global core.editor "vim --noplugin"

建立一个远程分支并追踪

::

    git branch branch-name
    git checkout branch-name
    git push  origin branch-name:branch-name
    # 冒号左边为本地分支，右边为远程分支，此时该远程分支不存在因为会被创建
    # NOTE: 如果本地分支为空，则删除远程分支
    git branch --set-upstream-to  origin/branch-name

从源仓库更新 fork

::

    git remote add upstream https://github.com/ORIGINAL_OWNER/ORIGINAL_REPOSITORY.git
    git fetch upstream
    git checkout master
    git merge upstream/master

推送 tag 到远程仓库

::

    # 推送单个 tag
    git push origin <tag name>
    # 推送全部 tag
    git push origin --tags

创建一个空的分支::

    git checkout --orphan YourBranchName
