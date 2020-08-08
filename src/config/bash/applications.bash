#!/usr/bin/env bash

#trap '' err exit SIGINT SIGTERM
export WHOAMI="${USER}"
export SUDO_PROMPT="$(printf "\t\t\033[1;31m")[sudo]$(printf "\033[1;36m") password for $(printf "\033[1;32m")%p: $(printf "\033[0m")"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : install
# @Created     : Wed, Aug 05, 2020, 02:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : functions for installed apps
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# fail if git is not installed

if ! command -v "git" >/dev/null 2>&1; then
  echo -e "\t\t\033[0;31mGit is not installed\033[0m"
  exit 1
fi

##################################################################################################

NC="$(tput sgr0 2>/dev/null)"
RESET="$(tput sgr0 2>/dev/null)"
BLACK="\033[0;30m"
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
PURPLE="\033[0;35m"
CYAN="\033[0;36m"
WHITE="\033[0;37m"
ORANGE="\033[0;33m"
LIGHTRED='\033[1;31m'
BG_GREEN="\[$(tput setab 2 2>/dev/null)\]"
BG_RED="\[$(tput setab 9 2>/dev/null)\]"

##################################################################################################

printf_color() { printf "%b" "$(tput setaf "$2" 2>/dev/null)" "$1" "$(tput sgr0 2>/dev/null)"; }
printf_normal() { printf_color "\t\t$1\n" "$2"; }
printf_green() { printf_color "\t\t$1\n" 2; }
printf_red() { printf_color "\t\t$1\n" 1; }
printf_purple() { printf_color "\t\t$1\n" 5; }
printf_yellow() { printf_color "\t\t$1\n" 3; }
printf_blue() { printf_color "\t\t$1\n" 4; }
printf_cyan() { printf_color "\t\t$1\n" 6; }
printf_info() { printf_color "\t\t[ ℹ️ ] $1\n" 3; }
printf_exit() {
  printf_color "\t\t$1\n" 1
  sleep 3
  exit 1
}
printf_help() {
  printf_color "\t\t$1\n" 1
  exit 0
}
printf_read() { printf_color "\t\t$1" 5; }
printf_success() { printf_color "\t\t[ ✔ ] $1\n" 2; }
printf_error() { printf_color "\t\t[ ✖ ] $1 $2\n" 1; }
printf_warning() { printf_color "\t\t[ ❗ ] $1\n" 3; }
printf_question() { printf_color "\t\t[ ❓ ] $1 - [❓]" 6; }
printf_error_stream() { while read -r line; do printf_error "↳ ERROR: $line"; done; }
printf_execute_success() { printf_color "\t\t[ ✔ ] $1 [ ✔ ] \n" 2; }
printf_execute_error() { printf_color "\t\t[ ✖ ] $1 $2 [ ✖ ] \n" 1; }
printf_execute_result() {
  if [ "$1" -eq 0 ]; then printf_execute_success "$2"; else printf_execute_error "$2"; fi
  return "$1"
}
printf_execute_error_stream() { while read -r line; do printf_execute_error "↳ ERROR: $line"; done; }
printf_not_found() { if ! cmd_exists "$1"; then printf_exit "The $1 command is not installed"; fi; }

##################################################################################################

printf_readline() {
  set -o pipefail
  [[ $1 == ?(-)+([0-9]) ]] && local color="$1" && shift 1 || local color="3"
  while read line; do
    printf_custom "$color" "$line"
  done
  set +o pipefail
}

##################################################################################################

printf_newline() {
  set -o pipefail
  [[ $1 == ?(-)+([0-9]) ]] && local color="$1" && shift 1 || local color="3"
  while read line; do
    printf_color "\t\t$line\n" "$color"
  done
  set +o pipefail
}

##################################################################################################

printf_custom() {
  [[ $1 == ?(-)+([0-9]) ]] && local color="$1" && shift 1 || local color="3"
  local msg="$@"
  shift
  printf_color "\t\t$msg" "$color"
  echo ""
}

##################################################################################################

printf_custom_question() {
  local custom_question
  [[ $1 == ?(-)+([0-9]) ]] && local color="$1" && shift 1 || local color="1"
  local msg="$@"
  shift
  printf_color "\t\t$msg" "$color"
}

##################################################################################################

printf_read_question() {
  printf_question "$1 is not installed Would you like install it"
}

##################################################################################################

printf_head() {
  [[ $1 == ?(-)+([0-9]) ]] && local color="$1" && shift 1 || local color="6"
  local msg="$@"
  shift
  printf_color "
\t\t##################################################
\t\t$msg
\t\t##################################################\n\n" "$color"
}

##################################################################################################

notifications() {
  local title="$1"
  shift 1
  local msg="$@"
  shift
  cmd_exists notify-send && notify-send -u normal -i "notification-message-IM" "$title" "$msg" || return 0
}

##################################################################################################

printf_result() {
  [ ! -z "$1" ] && EXIT="$1" || EXIT="$?"
  [ ! -z "$2" ] && local OK="$2" || local OK="Command executed successfully"
  [ ! -z "$3" ] && local FAIL="3" || local FAIL="Command has failed"
  if [ "$EXIT" -eq 0 ]; then
    printf_success "$OK"
    exit 0
  else
    printf_error "$FAIL"
    exit 1
  fi
}

##################################################################################################

die() { echo -e "$1" exit ${2:9999}; }
devnull() { "$@" >/dev/null 2>&1 || return $?; }
devnull1() { "$@" 1>/dev/null || return $?; }
devnull2() { "$@" 2>/dev/null || return $?; }
killpid() { devnull kill -9 $(pidof "$1"); }
hostname2ip() { getent hosts "$1" | cut -d' ' -f1 | head -n1; }
cmd_exists() {
  devnull unalias "$1"
  devnull command -v "$1"
}
set_trap() { trap -p "$1" | grep "$2" &>/dev/null || trap '$2' "$1"; }
getuser() { [ -z "$1" ] && cut -d: -f1 /etc/passwd | grep "$USER" || cut -d: -f1 /etc/passwd | grep "$1"; }
log() {
  mkdir -p "$HOME/.local/log"
  "$@" >"$HOME/.local/log/$APPNAME.log" 2>"$HOME/.local/log/$APPNAME.err"
}
system_service_exists() {
  if sudo systemctl list-units --full -all | grep -Fq "$1"; then return 0; else return 1; fi
  setexitstatus
  set --
}
system_service_enable() {
  if system_service_exists; then execute "sudo systemctl enable -f $1" "Enabling service: $1"; fi
  setexitstatus
  set --
}
system_service_disable() {
  if system_service_exists; then execute "sudo systemctl disable --now $1" "Disabling service: $1"; fi
  setexitstatus
  set --
}
run_post() {
  local e="$1"
  local m="$(echo $1 | sed 's#devnull ##g')"
  execute "$e" "executing: $m"
  setexitstatus
  set --
}

printclip() { clip -o -s; }
putclip() { xclip -i -sel c; }

##################################################################################################

get_app_info() {
  local APPNAME="$1"
  local FILE="$SCRIPTSFUNCTDIR/bin/$APPNAME"
  if [ -f "$FILE" ]; then
    echo ""
    cat "$SCRIPTSFUNCTDIR/bin/$APPNAME" | grep "# @" | grep " : " >/dev/null 2>&1 &&
      cat "$SCRIPTSFUNCTDIR/bin/$APPNAME" | grep "# @" | grep " : " | printf_newline "3" ||
      printf_red "File was found, however, No information was not found"
    echo ""
  else
    printf_red "File was not found"
  fi
  exit 0
}

##################################################################################################

#transmission-remote-cli() { cmd_exists transmission-remote-cli || cmd_exists transmission-remote  ;}

##################################################################################################

if ! cmd_exists backupapp; then
  backupapp() {
    local filename count backupdir rmpre4vbackup
    [ ! -z "$1" ] && local myappdir="$1" || local myappdir="$APPDIR"
    [ ! -z "$2" ] && local myappname="$2" || local myappname="$APPNAME"
    local backupdir="${MY_BACKUP_DIR:-$HOME/.local/backups/dotfiles}"
    local filename="$myappname-$(date +%Y-%m-%d-%H-%M-%S).tar.gz"
    local count="$(ls $backupdir/$myappname*.tar.gz 2>/dev/null | wc -l 2>/dev/null)"
    local rmpre4vbackup="$(ls $backupdir/$myappname*.tar.gz 2>/dev/null | head -n 1)"
    mkdir -p "$backupdir"
    if [ -e "$myappdir" ] && [ ! -d $myappdir/.git ]; then
      echo "#################################" >>"$backupdir/$myappname.log"
      echo "# Started on $(date +'%A, %B %d, %Y %H:%M:%S')" >>"$backupdir/$myappname.log"
      echo "# $backupdir/$filename $myappdir" >>"$backupdir/$myappname.log"
      echo "#################################" >>"$backupdir/$myappname.log"
      tar cfzv "$backupdir/$filename" "$myappdir" >>"$backupdir/$myappname.log" 2>&1 &&
        rm -Rf "$myappdir"
    fi
    if [ "$count" -gt "3" ]; then rm_rf $rmpre4vbackup; fi
  }
fi

##################################################################################################

runapp() {
  local logdir="${LOGDIR:-$HOME/.local/log}"
  mkdir -p "$logdir"
  if [ "$1" = "--bg" ]; then
    local logname="$2"
    shift 2
    echo "#################################" >>"$logdir/$logname.log"
    echo "$(date +'%A, %B %d, %Y')" >>"$logdir/$logname.log"
    echo "#################################" >>"$logdir/$logname.err"
    "$@" >>"$logdir/$logname.log" 2>>"$logdir/$logname.err" &
  elif [ "$1" = "--log" ]; then
    local logname="$2"
    shift 2
    echo "#################################" >>"$logdir/$logname.log"
    echo "$(date +'%A, %B %d, %Y')" >>"$logdir/$logname.log"
    echo "#################################" >>"$logdir/$logname.err"
    "$@" >>"$logdir/$logname.log" 2>>"$logdir/$logname.err"
  else
    echo "#################################" >>"$logdir/${SCRIPTNAME:-$1}.log"
    echo "$(date +'%A, %B %d, %Y')" >>"$logdir/${SCRIPTNAME:-$1}.log"
    echo "#################################" >>"$logdir/${SCRIPTNAME:-$1}.err"
    "$@" >>"$logdir/${SCRIPTNAME:-$1}.log" 2>>"$logdir/${SCRIPTNAME:-$1}.err"
  fi
}

##################################################################################################

cmdif() {
  local package=$1
  devnull unalias "$package"
  if devnull command -v "$package"; then return 0; else return 1; fi
}
perlif() {
  local package=$1
  if devnull perl -M$package -le 'print $INC{"$package/Version.pm"}'; then return 0; else return 1; fi
}
pythonif() {
  local package=$1
  if devnull $PYTHONVER -c "import $package"; then return 0; else return 1; fi
}

##################################################################################################

cmd_missing() { cmdif "$1" || MISSING+="$1 "; }
perl_missing() { perlif $1 || MISSING+="perl-$1 "; }
python_missing() { pythonif "$1" || MISSING+="$PYTHONVER-$1 "; }

##################################################################################################

rm_rf() { if [ -e "$1" ]; then devnull rm -Rf "$@"; fi; }
cp_rf() { if [ -e "$1" ]; then devnull cp -Rfa "$@"; fi; }
ln_rm() { devnull find "$1" -xtype l -delete; }
ln_sf() {
  [ -L "$2" ] && rm_rf "$2"
  devnull ln -sf "$@"
}
mv_f() { if [ -e "$1" ]; then devnull mv -f "$@"; fi; }
mkd() { devnull mkdir -p "$@"; }
replace() { find "$1" -not -path "$1/.git/*" -type f -exec sed -i "s#$2#$3#g" {} \; >/dev/null 2>&1; }
rmcomments() { sed 's/[[:space:]]*#.*//;/^[[:space:]]*$/d'; }
countwd() { cat $@ | wc-l | rmcomments; }
urlcheck() { devnull curl --config /dev/null --connect-timeout 3 --retry 3 --retry-delay 1 --output /dev/null --silent --head --fail "$1"; }
urlinvalid() { if [ -z "$1" ]; then
  printf_red "Invalid URL\n"
  exit 1
else
  printf_red "Can't find $1\n"
  exit 1
fi; }
urlverify() { urlcheck $1 || urlinvalid $1; }
symlink() { ln_sf "$1" "$2"; }

##################################################################################################

attemp_install_menus() {
  local prog="$1"
  if (dialog --timeout 10 --trim --cr-wrap --colors --title "install $1" --yesno "$prog in not installed! \nshould I try to install it?" 15 40); then
    sleep 2
    clear
    printf_custom "191" "\n\n\n\n\t\tattempting install of $prog\n\t\tThis could take a bit...\n\n\n"
    devnull pkmgr silent "$1"
    [ $? -ne 0 ] && dialog --timeout 10 --trim --cr-wrap --colors --title "failed" --msgbox "$1 failed to install" 10 41
    clear
  fi
}

##################################################################################################

custom_menus() {
  printf_custom_question "6" "Enter your custom program : "
  read custom
  printf_custom_question "6" "Enter any additional options [type file to choose] : "
  read opts
  if [ "$opts" = "file" ]; then opts="$(open_file_menus $custom)"; fi
  $custom $opts >/dev/null 2>&1 || clear
  printf_red "$custom is an invalid program"
}

##################################################################################################

run_prog_menus() {
  local prog="$1"
  shift 1
  local args="$@"
  if cmd_exists $prog; then
    devnull2 "$prog" "$@" || clear printf_red "An error has occured"
  else
    attemp_install_menus $prog &&
      devnull2 $prog $args || return 1
  fi
}

##################################################################################################

open_file_menus() {
  local prog="$1"
  shift 1
  local args="$@"
  if cmd_exists $prog; then
    local file=$(dialog --title "Play a file" --stdout --title "Please choose a file or url to play" --fselect "$HOME/" 14 48)
    [ -z "$FILE" ] && devnull2 "$prog" ""$file"" || clear
    printf_red "No file selected"
  else
    attemp_install_menus $prog &&
      devnull2 $prog $args || return 1
  fi
}

##################################################################################################

__getpythonver() {
  if [[ "$(python3 -V 2>/dev/null)" =~ "Python 3" ]]; then
    PYTHONVER="python3"
    PIP="pip3"
    PATH="${PATH}:$(python3 -c 'import site; print(site.USER_BASE)')/bin"
  elif [[ "$(python2 -V 2>/dev/null)" =~ "Python 2" ]]; then
    PYTHONVER="python"
    PIP="pip"
    PATH="${PATH}:$(python -c 'import site; print(site.USER_BASE)')/bin"
  fi
  if [ "$(cmdif yay)" ] || [ "$(cmdif pacman)" ]; then PYTHONVER="python" && PIP="pip3"; fi
}
__getpythonver

##################################################################################################

setexitstatus() {
  [ ! -z "$EXIT" ] && local EXIT="$?"
  local EXITSTATUS+="$EXIT"
  if [ -z "$EXITSTATUS" ] || [ "$EXITSTATUS" -ne 0 ]; then
    BG_EXIT="${BG_RED}"
    return 1
  else
    BG_EXIT="${BG_GREEN}"
    return 0
  fi
}

##################################################################################################

returnexitcode() {
  if [ "$EXIT" -eq 0 ]; then
    BG_EXIT="${BG_GREEN}"
    return 0
  else
    BG_EXIT="${BG_RED}"
    return 1
  fi
}

##################################################################################################

getexitcode() {
  EXIT="$?"
  if [ ! -z "$1" ]; then
    local PSUCCES="$1"
  elif [ ! -z "$SUCCES" ]; then
    local PSUCCES="$SUCCES"
  else
    local PSUCCES="Command successful"
  fi
  if [ ! -z "$2" ]; then
    local PERROR="$2"
  elif [ ! -z "$ERROR" ]; then
    local PERROR="$ERROR"
  else
    local PERROR="Last command failed to complete"
  fi
  if [ "$EXIT" -eq 0 ]; then
    printf_cyan "$PSUCCES"
  else
    printf_red "$PERROR"
  fi
  unset ERROR SUCCES
  returnexitcode
}

##################################################################################################

getlipaddr() {
  NETDEV="$(ip route | grep default | sed -e "s/^.*dev.//" -e "s/.proto.*//")"
  CURRIP4="$(/sbin/ifconfig $NETDEV | grep -E "venet|inet" | grep -v "127.0.0." | grep 'inet' | grep -v inet6 | awk '{print $2}' | sed s#addr:##g | head -n1)"
}

##################################################################################################

git_clone() {
  local repo="$1"
  [ ! -z "$2" ] && local myappdir="$2" || local myappdir="$APPDIR"
  [ ! -d "$myappdir" ] || rm_rf "$myappdir"
  devnull git clone --depth=1 -q --recursive "$@"
}

##################################################################################################

git_update() {
  cd "$APPDIR"
  local repo="$(git remote -v | grep fetch | head -n 1 | awk '{print $2}')"
  devnull git reset --hard &&
    devnull git pull --recurse-submodules -fq &&
    devnull git submodule update --init --recursive -q &&
    devnull git reset --hard -q
  if [ "$?" -ne "0" ]; then
    cd "$HOME"
    backupapp "$APPDIR" "$APPNAME" &&
      devnull rm_rf "$APPDIR" &&
      git_clone "$repo" "$APPDIR"
  fi
}

##################################################################################################

check_app() {
  local MISSING=""
  for cmd in "$@"; do cmdif $cmd || MISSING+="$cmd "; done
  if [ ! -z "$MISSING" ]; then
    printf_question "$cmd is not installed Would you like install it" [y/N]
    read -n 1 -s choice && echo
    if [[ $choice == "y" || $choice == "Y" ]]; then
      for miss in $MISSING; do
        if cmd_exists yay; then
          execute "pkmgr --enable-aur install $miss" "Installing $miss" | printf_readline
        else
          execute "pkmgr install $miss" "Installing $miss" | printf_readline
        fi
      done
    fi
  else
    return 1
  fi
}

##################################################################################################

check_pip() {
  local MISSING=""
  for cmd in "$@"; do cmdif $cmd || MISSING+="$cmd "; done
  if [ ! -z "$MISSING" ]; then
    printf_question "$1 is not installed Would you like install it" [y/N]
    read -n 1 -s choice
    if [[ $choice == "y" || $choice == "Y" ]]; then
      for miss in $MISSING; do
        execute "pkmgr pip $miss" "Installing $miss"
      done
    fi
  else
    return 1
  fi
}

##################################################################################################

check_cpan() {
  local MISSING=""
  for cmd in "$@"; do cmdif $cmd || MISSING+="$cmd "; done
  if [ ! -z "$MISSING" ]; then
    printf_question "$1 is not installed Would you like install it" [y/N]
    read -n 1 -s choice
    if [[ $choice == "y" || $choice == "Y" ]]; then
      for miss in $MISSING; do
        execute "pkmgr cpan $miss" "Installing $miss"
      done
    fi
  else
    return 1
  fi

}

##################################################################################################

can_i_sudo() {
  (
    ISINDSUDO=$(sudo grep -Re "$MYUSER" /etc/sudoers* | grep "ALL" >/dev/null)
    sudo -vn && sudo -ln
  ) 2>&1 | grep -v 'may not' >/dev/null
}

##################################################################################################

sudoask() {
  if [ ! -f "$HOME/.sudo" ]; then
    sudo true &>/dev/null
    while true; do
      echo "$$" >"$HOME/.sudo"
      sudo -n true
      sleep 10
      rm -Rf "$HOME/.sudo"
      kill -0 "$$" || return
    done &>/dev/null &
  fi
}

##################################################################################################

git_clone() {
  local repo="$1"
  rm_rf "$2"
  devnull git clone --depth=1 -q --recursive "$@"
}

##################################################################################################

git_update() {
  local repo="$(git remote -v | grep fetch | head -n 1 | awk '{print $2}')"
  devnull git reset --hard &&
    devnull git pull --recurse-submodules -fq &&
    devnull git submodule update --init --recursive -q &&
    devnull git reset --hard -q
  if [ "$?" -ne "0" ]; then
    cd "$HOME"
    backupapp &&
      devnull git_clone "$repo" $APPDIR
  fi
}

##################################################################################################

sudoexit() {
  if [ $? -eq 0 ]; then
    sudoask || printf_green "Getting privileges successfull continuing"
  else
    printf_red "Failed to get privileges\n"
  fi
}

##################################################################################################

requiresudo() {
  if [ -f "$(command -v sudo 2>/dev/null)" ]; then
    if (sudo -vn && sudo -ln) 2>&1 | grep -v 'may not' >/dev/null; then
      sudoask
      sudoexit
      sudo "$@" 2>/dev/null
    fi
  else
    printf_red "You dont have access to sudo\n\t\tPlease contact the syadmin for access"
  fi
}

##################################################################################################

kill_all_subprocesses() {
  local i=""
  for i in $(jobs -p); do
    kill "$i"
    wait "$i" &>/dev/null
  done
}

##################################################################################################

execute() {
  local -r CMDS="$1"
  local -r MSG="${2:-$1}"
  local -r TMP_FILE="$(mktemp /tmp/XXXXX)"
  local exitCode=0
  local cmdsPID=""
  set_trap "EXIT" "kill_all_subprocesses"
  eval "$CMDS" &>/dev/null 2>"$TMP_FILE" &
  cmdsPID=$!
  show_spinner "$cmdsPID" "$CMDS" "$MSG"
  wait "$cmdsPID" &>/dev/null
  exitCode=$?
  printf_execute_result $exitCode "$MSG"
  if [ $exitCode -ne 0 ]; then
    printf_execute_error_stream <"$TMP_FILE"
  fi
  rm -rf "$TMP_FILE"
  return $exitCode
}
##################################################################################################

show_spinner() {
  local -r FRAMES='/-\|'
  local -r NUMBER_OR_FRAMES=${#FRAMES}
  local -r CMDS="$2"
  local -r MSG="$3"
  local -r PID="$1"
  local i=0
  local frameText=""
  if [ "$TRAVIS" != "true" ]; then
    printf "\n\n\n"
    tput cuu 3
    tput sc
  fi
  while kill -0 "$PID" &>/dev/null; do
    frameText="                [ ${FRAMES:i++%NUMBER_OR_FRAMES:1} ] $MSG"
    if [ "$TRAVIS" != "true" ]; then
      printf "%s\n" "$frameText"
    else
      printf "%s" "$frameText"
    fi
    sleep 0.2
    if [ "$TRAVIS" != "true" ]; then
      tput rc
    else
      printf "\r"
    fi
  done
}

##################################################################################################

# end
# vi: set expandtab ts=4 fileencoding=utf-8 filetype=sh noai :
