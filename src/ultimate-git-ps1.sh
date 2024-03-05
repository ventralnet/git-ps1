#!/bin/sh

DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")")

. $DIR/git-util.sh

export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w$(__git_ps1)\[\033[00m\]\$ "