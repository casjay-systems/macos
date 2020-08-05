#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.com
# @File        : 00-functions.bash
# @Created     : Mon, Dec 23, 2019, 14:13 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : functions for bash login
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

__tput() { tput $* 2> /dev/null; }
__whiletrue() { while true; do "$@" ;  sleep 60 ; done ; }
rm_rf() { devnull rm -Rf "$@" ; }
cp_rf() { if [ -e "$1" ]; then devnull cp -Rfa "$@" ; fi ; }
mv_f() { if [ -e "$1" ]; then devnull mv -f "$@" ; fi ; }
ln_rm() { devnull find "$HOME" -xtype l -delete ; }
ln_sf() { devnull ln -sf "$@" ; ln_rm ; }
git_clone() { rm_rf "$2" ; devnull git clone -q "$@" ; }
git_update() { devnull git pull -f ; }
returnexitcode() { local RETVAL="$?"; if [ "$RETVAL" -eq 0   ]; then BG_EXIT="${BG_GREEN}" ;  else BG_EXIT="${BG_RED}" ;fi ; }
getexitcode() { local RETVAL="$?" ; local ERROR="Failed" ; local SUCCES="$1" ; EXIT="$RETVAL" ; if [ "$RETVAL" -eq 0 ]; then printf_success "$SUCCES" ; return 0 ; else  printf_error "$ERROR" ; return 1 ; fi ; returnexitcode ;  }
devnull() { "$@" > /dev/null 2>&1 ; }
devnull1() { "$@" 1>/dev/null ; }
devnull2() { "$@" 2>/dev/null ; }
alias_function() { eval "${1}() $(declare -f "${2}" | sed 1d)" ;}
set_trap() { trap -p "$1" | grep "$2" &> /dev/null || trap '$2' "$1" ;}
gitforcepull() { git reset --hard HEAD ; git pull -fq ;}
gitforcepush() { git push -f ;}
cmd_exists() { unalias "$1"  >/dev/null 2>&1 ; command -v "$1" >/dev/null 2>&1 ;}
urlcheck() { devnull curl --output /dev/null --silent --head --fail "$1" ;}
urlinvalid() { if [ -z "$1" ]; then printf_red "Invalid URL" ; else printf_red "Can't find $1" ; fi ;}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

answer_is_yes() { [[ "$REPLY" =~ ^[Yy]$ ]] && return 0 || return 1 ;}
ask() { printf_question "$1" ; read -r ;}
ask_for_confirmation() { printf_question "$1 (y/n) " ; read -r -n 1 ; printf "" ;}
get_answer() { printf "%s" "$REPLY" ;}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Search history.

qh() { grep --color=always "$*" "$HISTFILE" | less -RX ;}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Search for text within the current directory.

qt() { grep -ir --color=always "$*" --exclude-dir=".git" --exclude-dir="node_modules" . | less -RX ;}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#Email sync for mutt
__mailsync() {
printf_green "Syncing Mailboxes with mailsync"
/usr/local/bin/mailsync >/dev/null 2>&1 || \
printf_red "Mail Sync Failed"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

__muttsync() {
printf_green "Syncing Mailboxes with mbsync"
/usr/bin/mbsync -a >/dev/null 2>&1 || \
printf_red "Mail Sync Failed"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# use grc if it's installed or execute the command direct

if ! cmd_exists grc ; then
  if [[ USEGRC = "yes" ]]; then
    grc() {
      if [[ -f "$(command -v grc)" ]]; then
        #grc --colour=auto
        $(command -v grc) --colour=on "$@"
      else
        "$@"
      fi
}
  fi
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# adds files permissons in binary form to the ls command output

if ! cmd_exists lso; then
lso()
{
  if [ -t 0 ];then ls -alG "$@";else cat -;fi |
    awk '{t=$0;gsub(/\x1B\[[0-9;]*[mK]/,"");k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(" %0o ",k);print t}'
}
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# remove last n records from history

if ! cmd_exists delhistory; then
delhistory() {
  local opt id n=1
  OPTIND=1 #reset index
  while getopts "n:" opt; do
    case $opt in
      n)  n=$OPTARG ;;
      \?) return 1 ;;
      :)  printf_red "Option -$OPTARG requires number of history last entries to remove as an argument" >&2;return 1 ;;
    esac
  done

  ((++n));id=$(history | tail -n $n | head -n1 | awk '{print $1}')
  while ((n-- > 0)); do history -d "$id"; done
}
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# converts text into a qr code

if ! cmd_exists qrcode; then
qrcode() {
  local text=$1
  [[ -e "$text" ]] && text=$(cat "$text")
  [[ -z "$text" ]] && [[ ! -t 0 ]] && text=$(cat -)
  [[ -z "$text" ]] && text=$(printclip)
  echo "$text" | curl -F-=\<- qrenco.de
}
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# prints/puts content of/to the clipboard

if ! cmd_exists printclip; then
printclip() {
  xclip -o -s
}
fi

if ! cmd_exists putclip; then
putclip() {
  xclip -i -sel c
}
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# netstat functions

if ! cmd_exists netstatl; then
netstatl() {
    sudo netstat -taupln | grep "$@"
}
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if ! cmd_exists netstatg; then
netstatg() {
    sudo netstat "-$1" | grep "$2"
}
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# sprunge.us || Usage: 'command | sprunge or sprunge filename'

if ! cmd_exists sprunge.us; then
sprunge.us() {
  if [[ $1 ]]; then
    curl -F 'sprunge=<-' "http://sprunge.us" <"$1"
  else
    curl -F 'sprunge=<-' "http://sprunge.us"
  fi
}
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# transfer.sh || Usage: 'command | transfer.sh or transfer.sh filename'

if ! cmd_exists transfer.sh; then
transfer.sh() {
  if [ $# -eq 0 ]; then
    printf_red "No arguments specified. Usage:\ntransfer.sh /tmp/test.md\ncat /tmp/test.md | transfer.sh test.md"
    return 1
  fi
  tmpfile=$( mktemp -t transferXXX )
  if tty -s; then
    basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g')
    curl -LSs --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile
  else
    curl -LSs --upload-file "-" "https://transfer.sh/$1" >> $tmpfile
  fi
  cat $tmpfile; rm -f $tmpfile
}
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# termbin.com || Usage: 'command | termbin.com or termbin.com filename'

if ! cmd_exists termbin.com; then
termbin.com() {
  nc termbin.com 9999
}
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# ix.io || Usage: 'command | ix.io or ix.io filename'

if ! cmd_exists ix.io; then
ix.io() {
  local opts
  local OPTIND
  [ -f "$HOME/.netrc" ] && opts='-n'
    while getopts ":hd:i:n:" x; do
    case $x in
      h) echo "ix [-d ID] [-i ID] [-n N] [opts]"; return;;
      d) $echo curl $opts -X DELETE ix.io/$OPTARG; return;;
      i) opts="$opts -X PUT"; local id="$OPTARG";;
      n) opts="$opts -F read:1=$OPTARG";;
    esac
  done
  shift $(($OPTIND - 1))
    [ -t 0 ] && {
    local filename="$1"
    shift
    [ "$filename" ] && {
    curl $opts -F f:1=@"$filename" $* ix.io/$id
    return
    }
    echo "^C to cancel, ^D to send."
    }
    curl $opts -F f:1='<-' $* ix.io/$id
}
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#pastebin.com || Usage: 'command | pastebin.com or pastebin.com filename'

if ! cmd_exists pastebin.com; then
pastebin.com() {
if [ ! -d "$HOME"/.local/bin ]; then mkdir "$HOME"/.local/bin ; fi
  if [ -f command -v pastebin.com ]; then
    command -v pastebin.com "$@"
  else
    curl -LSs "https://github.com/casjay-dotfiles/scripts/raw/master/bin/pastebin.com" -o "$HOME/.local/bin/pastebin.com"
    chmod 755 "$HOME"/.local/bin/pastebin.com
    "$HOME"/.local/bin/pastebin.com "$@"
  fi
}
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# generate random strings

if ! cmd_exists random-string; then
random-string() {
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-64} | head -n 1
}
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if ! cmd_exists mkpasswd; then
mkpasswd() {
    cat /dev/urandom | tr -dc [:print:] | tr -d '[:space:]\042\047\134' | fold -w ${1:-64} | head -n 1
}
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# post to social

tweet() {
    twitter set "$1"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

mastodon() {
    toot post "$1"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

social_post() {
    tweet "$1" >/dev/null 2>&1
    mastodon "$1" >/dev/null 2>&1
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# search command usage examples on commandlinefu.com
if ! cmd_exists cmdfu; then
cmdfu() {
  [ -z "$1" ] && printf_red "Please enter a search string"
  wget -qO - "http://www.commandlinefu.com/commands/matching/$(echo "$@" \
        | sed 's/ /-/g')/$(echo -n "$@" | base64)/sort-by-votes/plaintext" ;
}
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# terminal rickroll

rr () {
    curl -LSs https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# the fuck

fuck() {
    TF_CMD=$(TF_ALIAS=fuck \
    PYTHONIOENCODING=utf-8 \
    TF_SHELL_ALIASES=$(alias)
    thefuck $(fc -ln -1)) && \
    eval $TF_CMD && history -s $TF_CMD
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

###END
#/* vim: set expandtab ts=4 noai
