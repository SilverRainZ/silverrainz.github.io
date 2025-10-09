=====
Shell
=====

:date: 2020-12-26
:version: 1

.. highlight:: bash

String
======

Get length::

   ${#str}

Substring / Slice::

   ${str:1:4}

Replace::

   ${v%.md}.rst

Prefix & Subfix::

   ${foo#"$prefix"}
   ${foo%"$suffix"}

Heredoc
-------

Syntax::

   cat <<EOF
   ... Heredoc content
   EOF

.. note:: Shell variables in heredoc will be expanded

Avoid shell expanding variables::

   cat <<'EOF'
   ... Heredoc ${content}
   EOF

Write to file::

   cat << EOF > /tmp/foo
   ... Heredoc content
   EOF

Output to variable, 使用时需要 quote 以保持原格式 ``"$VAR"``::

   read -r -d '' VAR << EOF
   ... Heredoc content
   EOF

.. seealso:: `How can I assign a heredoc value to a variable in Bash? - Stack Overflow <https://stackoverflow.com/questions/1167746/how-can-i-assign-a-heredoc-value-to-a-variable-in-bash>`_

``<<-EOF`` will ignore leading tabs in your heredoc, while ``<<EOF`` will not.

Command Line Arguments
======================

Number of pass-in arguments::

    $#

The "pass-in argument list::

    $* # Default, an *string*
    $@ # Default, a *array*

The arguments of previous command::

    !^      # First one
    !$      # Last one
    !*      # All
    !:n     # N-th
    !:n-m   # Range n~m


Command Line Wrapper 模版
-------------------------

::

   #!/bin/bash

   EXEC="xxxx"

   exec $EXEC $*


Bash `set` options
==================

Get help::

   $ bash -c 'help set'

脚本常用参数：

:-e: Exit immediately if a command exits with a non-zero status.
:-x: Print commands and their arguments as they are executed.
:-u: Treat unset variables as an error when substituting.


数组
====

Access by index::

   arr=("one" "tow" "three")
   for i in ${!arr[@]}; do
       echo $i ${arr[i]}
   done

交互式数组
==========

.. highlight:: console

查看行编辑快捷键::

   $ bindkey -M


Switch Case
===========

.. highlight:: shell

::

   case word in
      pattern1)
         Statement(s) to be executed if pattern1 matches
         ;;
      pattern2)
         Statement(s) to be executed if pattern2 matches
         ;;
      pattern3)
         Statement(s) to be executed if pattern3 matches
         ;;
      *)
        Default condition to be executed
        ;;
   esac
