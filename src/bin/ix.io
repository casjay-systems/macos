#!/usr/bin/env bash

SCRIPTNAME="$(basename $0)"
SCRIPTDIR="$(readlink -f -- "$(dirname -- "$0")/..")"
USER="${SUDO_USER:-${USER}}"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : ix.io
# @Created     : Wed, Aug 05, 2020, 02:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : ix.io || Usage: 'command | ix.io or ix.io filename'
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

[ "$1" = "--help" ] && printf_help "Usage: command | ix.io or ix.io filename"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

[ -f "$HOME/.netrc" ] && opts='-n'
while getopts ":hd:i:n:" x; do
  case $x in
  h)
    echo "ix [-d ID] [-i ID] [-n N] [opts]"
    return
    ;;
  d)
    $echo curl $opts -X DELETE ix.io/$OPTARG
    return
    ;;
  i)
    opts="$opts -X PUT"
    local id="$OPTARG"
    ;;
  n) opts="$opts -F read:1=$OPTARG" ;;
  esac
done

shift $(($OPTIND - 1))
[ -t 0 ] && {
  filename="$1"
  shift
  [ "$filename" ] && {
    curl $opts -F f:1=@"$filename" $* ix.io/$id
    exit
  }
  echo "^C to cancel, ^D to send."
}
curl $opts -F f:1='<-' $* ix.io/$id

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# end
