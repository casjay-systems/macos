#!/usr/bin/env bash

# Profile Custom Script

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# remove .sudo if exists
if [[ -f "$HOME/.sudo" ]]; then
      rm -Rf  "$HOME/.sudo"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


pathmunge () {
    case ":${PATH}:" in
        *:"$1":*)
            ;;
        *)
            if [ "$2" = "after" ] ; then
                PATH=$PATH:$1
            else
                PATH=$1:$PATH
            fi
    esac
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if ! type tree >& /dev/null; then
    tree () { # {{{
      opt=""
      directory="."
      while [ $# -gt 0 ];do
        case $1 in
          "-L")opt="$opt -d $2";shift;;
          "-d")opt="$opt -type d";shift;;
          "-*")echo "$1 is invalid option";exit 1;;
          "*")directory="$*";break;;
        esac
        shift
      done
      find "$directory" $opt| sort | sed '1d;s,[^/]*/,|    ,g;s/..//;s/[^ ]*$/|-- &/'
    }
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if [ -x /usr/bin/id ]; then
    if [ -z "$EUID" ]; then
        # ksh workaround
        EUID=`id -u`
        UID=`id -ru`
    fi
    USER="`id -un`"
    LOGNAME=$USER
    MAILDIR="$HOME/.local/share/mail/local/"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Path manipulation
if [ "$EUID" = "0" ]; then
    pathmunge /sbin
    pathmunge /usr/sbin
    pathmunge /usr/local/sbin
else
    pathmunge /usr/local/sbin after
    pathmunge /usr/sbin after
    pathmunge /sbin after
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

HOSTNAME=`/bin/hostname -f 2>/dev/null`

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if [ $UID -gt 199 ] && [ "`id -gn`" = "`id -un`" ]; then
    umask 002
else
    umask 022
fi

#direnv
if [[ -f "$(command -v direnv)" ]]; then
    eval "$(direnv hook bash 2>/dev/null)"
fi

export PATH USER LOGNAME MAILDIR HOSTNAME

unset i
unset -f pathmunge

# vim:ts=4:sw=4
