#!/usr/bin/env bash

SCRIPTNAME="$(basename $0)"
SCRIPTDIR="$(readlink -f -- "$(dirname -- "$0")/..")"
USER="${SUDO_USER:-${USER}}"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : termbin.com
# @Created     : Wed, Aug 05, 2020, 02:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : Post text to termbin.com
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

IFS=''
[ "$1" = "--help" ] && printf_help "Usage: command | termbin.com or termbin.com filename"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if ! cmd_exists nc; then
  printf_red "Command nc was not found"
  printf_red "Please install the netcat package"
  exit 1
else

  if [ ! -z "$1" ]; then
    cat "$1" | nc termbin.com 9999 >/tmp/termbin 2>/dev/null
  else
    nc termbin.com 9999 >/tmp/termbin 2>/dev/null
  fi

  if [ -f /tmp/termbin ]; then
    echo "" >>/tmp/termbin
    printf_green $(cat /tmp/termbin 2>/dev/null)
    rm -Rf /tmp/termbin
  else
    printf_red "Something went wrong"
  fi
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# end
