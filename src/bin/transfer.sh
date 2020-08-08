#!/usr/bin/env bash

SCRIPTNAME="$(basename $0)"
SCRIPTDIR="$(readlink -f -- "$(dirname -- "$0")/..")"
USER="${SUDO_USER:-${USER}}"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : transfer.sh
# @Created     : Wed, Aug 05, 2020, 02:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : Upload file to https://transfer.sh
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set functions

SCRIPTSFUNCTURL="${SCRIPTSAPPFUNCTURL:-https://github.com/casjay-dotfiles/scripts/raw/master/functions}"
SCRIPTSFUNCTDIR="${SCRIPTSAPPFUNCTDIR:-$HOME/.config/bash}"
SCRIPTSFUNCTFILE="${SCRIPTSAPPFUNCTFILE:-applications.bash}"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if [ -f "$SCRIPTSFUNCTDIR/functions/$SCRIPTSFUNCTFILE" ]; then
  . "$SCRIPTSFUNCTDIR/functions/$SCRIPTSFUNCTFILE"
else
  curl -LSs "$SCRIPTSFUNCTURL/$SCRIPTSFUNCTFILE" -o "/tmp/$SCRIPTSFUNCTFILE" || exit 1
  . "/tmp/$SCRIPTSFUNCTFILE"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

[ "$1" = "--version" ] && get_app_info "$SCRIPTNAME"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

[ "$1" = "--help" ] && printf_help "Usage: command | transfer.sh or transfer.sh filename"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

tmpfile=$(mktemp -t transferXXX)
if tty -s; then
  basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g')
  curl -LSs --upload-file "$1" "https://transfer.sh/$basefile" >>$tmpfile
else
  curl -LSs --upload-file "-" "https://transfer.sh/$1" >>$tmpfile
fi

printf_green "$(cat $tmpfile)\n"
rm -f $tmpfile

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# end
