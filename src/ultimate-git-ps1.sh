#!/bin/sh

DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")")

. $DIR/git-util.sh
. $DIR/colors.sh

preamble="\[\033[01;32m\]\u@\h \[\033[01;34m\]\w \[\033[31m\]"
preamble="\[$BOLD$GREEN\]\u@\h $NORMAL"
terminator="$ "

export PS1=$preamble$terminator
