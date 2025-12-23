======================================================================
A set of smooth, fzf-powered shell aliases&functions for ``systemctl``
======================================================================

.. post:: 2025-09-12
   :tags: Zsh, Systemd, DevOps, Fzf, Shell
   :author: LA, AI
   :language: en
   :location: 深圳

If you've ever found yourself repeatedly typing long systemctl commands or struggling to remember exact service names, this post is for you.

A while ago I implemented a set of shell aliases and functions, and now I can manage my systemd services very smoothly:

.. asciinema:: /_assets/systemd.v2.cast

Motivation: The Pain Point
==========================

Let's acknowledge a universal sysadmin/developer experience: typing ``systemctl`` over and over, managing long unit names.

Beside, the current shell completion implementation is is quite slow, especially on thin client (for example: Raspberry Pi). I am not familiar with the shell completion, so I am not tended to improve it.

:ghrepo:`joehillen/sysz` is a TUI for systemd, which is a great inspiration that proves `fzf <https://junegunn.github.io/fzf/>`_ is perfect for this job: *Fuzzy completion is much more efficient than prefix completion*. It is quite frustrating that:

1. sysz is a TUI program; it is not a one-command action, you have to :menuselection:`1. type "sysz" --> 2. fuzzy search service name --> 3. select action (start, stop, ...)` step-by-step. If you have to start and stop service frequently (for example, when debugging), you have to repeat these steps over and over
2. sysz is unmaintained since 2022 ``:'(``

So I decided to build a custom set of shell functions and aliases that supercharges `systemctl` and `journalctl` with fuzzy-finding magic for my personal usage.


The Vision: What I Wanted to Build
==================================

Core Principle
   Keep it in the shell. No new binaries, just Shell functions and aliases.

Desired Features
   :Easy to type: no need to type long command name and unit name
   :Easy to repeat: history operations can be easily performed
   :Easy to maintain: just like any other programming, keep it simple and avoid repetition.
   :Dual Support: seamlessly handle both `--system` (sudo) and `--user` units.
   :Error handling: print detailed information when operation failed
   :One for one: each operation corresponds to a command/alias, which is completion friendly constrast to subcommand

Implementation: Breaking Down the Script
========================================

1. The Basics: Aliases
----------------------

We can easily define some extremely short aliases for the long ``systemctl`` and ``journalctl`` commands:

.. code:: bash

   alias s='sudo systemctl'
   alias sj='journalctl'
   alias u='systemctl --user'
   alias uj='journalctl --user'

Operating on ``systemctl`` unit require root privilege, so a ``sudo`` is required.

2. The Heart: Taming Systemd with FZF
-------------------------------------

Using fzf to fuzzy complete can greatly improve the efficiency of inputting SystemD units.

``systemctl list-units | fzf``
   The output of ``systemctl list-units`` looks like this::

     UNIT                           LOAD   ACTIVE SUB       DESCRIPTION
     ...                            ...    ...    ...       ...
     -.mount                        loaded active mounted   Root Mount
     boot.mount                     loaded active mounted   /boot
     dev-hugepages.mount            loaded active mounted   Huge Pages File System
     dev-mqueue.mount               loaded active mounted   POSIX Message Queue File System
     proc-sys-fs-binfmt_misc.mount  loaded active mounted   Arbitrary Executable File Formats File System
     run-user-1000-doc.mount        loaded active mounted   /run/user/1000/doc
     ...                            ...    ...    ...       ...

     Legend: LOAD   → Reflects whether the unit definition was properly loaded.
             ACTIVE → The high-level unit activation state, i.e. generalization of SUB.
             SUB    → The low-level unit activation state, values depend on unit type.

     162 loaded units listed. Pass --all to see loaded but inactive units, too.
     To show all installed unit files use 'systemctl list-unit-files'.

   We can easily write a script like that:

   .. code:: bash

       systemctl list-units --legend=false \
       | fzf --accept-nth=1 \
             --no-hscroll \
             --preview="systemctl status {1}" \
             --preview-window=down

   :``--legend=false``: can hide the trailing hints of outputs, but the column is also hidden
   :``--accept-nth=1``: ask fzf only print the first column (aka the unit name) of the select row
   :``--preview="... {1}"``: the ``{num}`` syntax means pass the num\ :sup:`th` colmun of highlighting row. We can therefore preview the service status in real-time

Merging ``list-units`` and ``list-unit-files``
   As ``list-units`` only list units currently in memory, we usually need to start from the unit that has not yet been loaded, so we also need to list all installed unit files via ``list-unit-files``:

   .. code:: bash

       cat <(systemctl list-units --legend=false) \
           <(systemctl list-unit-files --legend=false) \
       | fzf --accept-nth=1 \
             --no-hscroll \
             --preview="systemctl status {1}" \
             --preview-window=down

   :``<(systemctl ...)``: Use the `Process Substitution Syntax <https://www.gnu.org/software/bash/manual/html_node/Process-Substitution.html>`_ to merge stdout from multiple ``systemctl ...`` commands

Columnating
   The above script doesn't work well, ``list-units`` and ``list-unit-files`` have different output formats: the former one has 5 columns and the latter has 3, which will mess up fzf's UI:

   .. code:: bash

       cat <(echo 'UNIT/FILE LOAD/STATE ACTIVE/PRESET SUB DESCRIPTION') \
           <(systemctl list-units --legend=false) \
           <(systemctl list-unit-files --legend=false) \
       | column --table --table-columns-limit=5 \
       | sed 's/●/ /' \
       | grep . \
       | fzf --header-lines=1 \
             --accept-nth=1 \
             --no-hscroll \
             --preview="SYSTEMD_COLORS=1 systemctl status {1}" \
             --preview-window=down

   :``echo 'UNIT/FILE ...'``: a hardcoded table header that can tell the user the meaning of the column
   :``column --table ...``: the ``column`` command from `util-linux <https://github.com/util-linux/util-linux>`_ can columnate the text and output as a table, set ``--table-columns-limit`` to ``5`` to prevent the "DESCRIPTION" column from being trimmed
   :``sed 's/●/ /'``:  to strip the dot ("●") unit state which breaks the colmun
   :``grep .``: to strip the empty line
   :``SYSTEMD_COLORS=1``: force enabled colorful output

Reusable for ``--user``
   As we want to handle both ``--system`` and ``--user`` units, we can encapsulate the script to a function:

   .. code:: bash

      # SystemD unit selector.
      _sysls() {
          WIDE=$1
          [ -n "$2" ] && STATE="--state=$2"
          cat \
              <(echo 'UNIT/FILE LOAD/STATE ACTIVE/PRESET SUB DESCRIPTION') \
              <(systemctl $WIDE list-units --quiet $STATE) \
              <(systemctl $WIDE list-unit-files --quiet $STATE) \
          | sed 's/●/ /' \
          | grep . \
          | column --table --table-columns-limit=5 \
          | fzf --header-lines=1 \
                --accept-nth=1 \
                --no-hscroll \
                --preview="SYSTEMD_COLORS=1 systemctl $WIDE status {1}" \
                --preview-window=down
      }

      alias sls='_sysls --system'
      alias uls='_sysls --user'

   :``$1``: is ``--system`` or ``--user``
   :``$2``: is service states, see also ``systemctl list-units --state=help``

   Then we can use ``sls`` and ``uls`` to get the full service name by fuzzy matching.

3. The Complete Function
------------------------

Error handling
   When performing ``systemctl start xxx.service``, if the service does not start successfully, it only tell you to run ``journalctl -xeu`` to see the log:

   .. code:: console

      $ s start docker.service
      Job for docker.service failed because the control process exited with error code.
      See "systemctl status docker.service" and "journalctl -xeu docker.service" for details.

   In another situation, if a service immediately dies after launched, systemctl even tells you nothing:

   .. code:: console

      $ s start getty@foo
      $ echo $?
      0
      $ s status getty@foo
      × getty@foo.service - Getty on foo
           Loaded: loaded (/usr/lib/systemd/system/getty@.service; disabled; preset: enabled)
           Active: failed (Result: start-limit-hit) since Fri 2025-09-12 20:44:26 CST; 1s ago
              ...: ...

      Sep 12 20:44:26 x1c systemd[1]: ...
      Sep 12 20:44:26 x1c systemd[1]: Failed to start Getty on foo.

   To help users get detailed service status after launching a service, we can use the following pattern:

   .. code:: shell

      s start foo.service && s status $_ || sj -xeu $_

   :``A && B || C``: if A success, performing B, else C
   :``$_``: is the last argument of the previous command, in this case it is "foo.service"

Repeatable
   The key to efficient debugging is repeatability. After fuzzy-selecting and starting a service once, I should be able to simply press the :kbd:`↑` arrow and :kbd:`Enter` to run the exact same command again, without going through the fuzzy selection process every time:

   .. code:: bash

      sstart () {
          CMD="s start $(sls static,disabled,failed) && s status \$_ || sj -xeu \$_"
          eval $CMD
          [ -n "$BASH_VERSION" ] && history -s $CMD
          [ -n "$ZSH_VERSION" ] && print -s $CMD
      }

   :``sls static,...``: pre-filtering services by states, services that need to be "start"-ed must not be in active state, filter by these states can reduce the number of outputs, accelerate the command to some extent |?|
   :``\$_``: prevent the variable from being expanded before eval
   :``history -s`` and ``print -s``: push the command to history, facilitating subsequent repetition

4. The Magic: Dynamic Function Generation
-----------------------------------------

After implementing ``sstart``, we also have to implement:

:``sstop``: for ``systemctl stop``
:``sre``: for ``systemctl restart``
:``ustart``: for ``systemctl --user start``
:``ustop``: for ``systemctl --user stop``
:``ure``: for ``systemctl --user restart``

Repeatedly implementing these functions is tedious and boring. Fortunately, we can dynamically generate them in a loop:

.. note::

   This dynamic generation approach avoids repetitive code but adds some complexity. For clarity, you could instead explicitly define each function.

.. code:: bash

   _SYS_ALIASES=(
       sstart sstop sre
       ustart ustop ure
   )
   _SYS_CMDS=(
       's start $(sls static,disabled,failed)'
       's stop $(sls running,failed)'
       's restart $(sls)'
       'u start $(uls static,disabled,failed)'
       'u stop $(uls running,failed)'
       'u restart $(uls)'
   )

   _sysexec() {
       for ((j=0; j < ${#_SYS_ALIASES[@]}; j++)); do
           if [ "$1" == "${_SYS_ALIASES[$j]}" ]; then
               cmd=$(eval echo "${_SYS_CMDS[$j]}") # expand service name
               wide=${cmd:0:1}
               cmd="$cmd && ${wide} status \$_ || ${wide}j -xeu \$_"
               eval $cmd

               # Push to history.
               [ -n "$BASH_VERSION" ] && history -s $cmd
               [ -n "$ZSH_VERSION" ] && print -s $cmd
               return
           fi
       done
   }

   # Generate bash function/zsh widgets.
   for i in ${_SYS_ALIASES[@]}; do
       source /dev/stdin <<EOF
   $i() {
       _sysexec $i
   }
   EOF
   done

:``for ((j=0; j < ...; j++))``: is a bash and zsh compatible ``for`` loop syntax
:``_sysexec``: a wrapper for dynamically dispatching function
:``source ...``: a way for generating function dynamically

Final Thoughts
==============

Now you can :menuselection:`1. type "sstart" --> 2. fuzzy search service name` to start a service. If service is failed, the related logs are print automaticlly. You also can press :kbd:`↑` to browse commands history to repeat the previous operation.

Using this script saved me a lot of unnecessary keystrokes, just an ``s`` gives me more happiness than ``systemctl``. The fuzzy search algorithm of fzf is good enough that I can get the desired result in one go even with a casual keystroke. It also works well on my Raspberry Pi 3B.

Feel free to grab the script from `my dotfiles repository <https://github.com/SilverRainZ/dotfiles/blob/c5d1b4bd14f2b4c1dd1198d9540adb63ac23cfc1/.sh/systemd.sh>`_ and adapt it to your own workflow. I'd love to hear about your own systemd productivity tricks in the comments!
