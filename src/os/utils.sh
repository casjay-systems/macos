#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" && . "osdetect.sh"

__curl() { __am_i_online && curl --disable -LSsfk --connect-timeout 3 --retry 0 --fail "$@" || return 1; }
__version() { curl --disable -LSsk --connect-timeout 3 --retry 0 "$1" || echo 000000; }

answer_is_yes() {
  [[ "$REPLY" =~ ^[Yy]$ ]] &&
    return 0 ||
    return 1
}

ask() {
  print_question "$1"
  read -r
}

ask_for_confirmation() {
  print_question "$1 (y/n) "
  read -r -n 1
  printf "\n"
}

ask_for_sudo() {
  sudo true &>/dev/null
  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done &>/dev/null &
}

__cmd_exists() {
  [ $# -eq 0 ] && return 1
  local args="$*"
  local exitTmp
  local exitCode
  for cmd in $args; do
    if find "$(command -v "$cmd" 2>/dev/null)" >/dev/null 2>&1 || find "$(which --skip-alias --skip-functions "$cmd" 2>/dev/null)" >/dev/null 2>&1; then
      local exitTmp=0
    else
      local exitTmp=1
    fi
    local exitCode+="$exitTmp"
  done
  [ "$exitCode" -eq 0 ] && return 0 || return 1
}

kill_all_subprocesses() {
  local i=""
  for i in $(jobs -p); do
    kill "$i"
    wait "$i" &>/dev/null
  done
}

execute() {
  local -r CMDS="$1"
  local -r MSG="${2:-$1}"
  local -r TMP_FILE="$(mktemp /tmp/XXXXX)"
  local exitCode=0
  local cmdsPID=""
  set_trap "EXIT" "kill_all_subprocesses"
  eval "$CMDS" \
    &>/dev/null \
    2>"$TMP_FILE" &
  cmdsPID=$!
  show_spinner "$cmdsPID" "$CMDS" "$MSG "
  wait "$cmdsPID" &>/dev/null
  exitCode=$?
  print_result $exitCode "$MSG"
  if [ $exitCode -ne 0 ]; then
    print_error_stream <"$TMP_FILE"
  fi
  rm -rf "$TMP_FILE"
  return $exitCode
}

get_answer() { printf "%s" "$REPLY"; }

get_os() {
  local os=""
  local kernelName=""
  kernelName="$(uname -s | awk '{print tolower($0)}')"
  if [ "$kernelName" == "darwin" ]; then
    os="macos"
  elif [ "$kernelName" == "linux" ] && [ -e "/etc/lsb-release" ]; then
    os="linux"
  else
    os="$kernelName"
  fi
  printf "%s" "$os"
}

get_os_version() {
  local os=""
  local version=""
  os="$(get_os)"
  if [ "$os" == "macos" ]; then
    version="$(sw_vers -productVersion)"
  elif [ "$os" == "linux" ]; then
    #version="$(lsb_release -i | awk '{print $3}')"
    version=$(cat /etc/*release | grep VERSION | sed 's#VERSION_ID=##g' | grep -v VERSION | head -n 1)
  fi
  printf "%s" "$version"
}

is_git_repository() { git rev-parse &>/dev/null; }

is_supported_version() {
  declare -a v1=(${1//./ })
  declare -a v2=(${2//./ })
  local i=""
  # Fill empty positions in v1 with zeros.
  for ((i = ${#v1[@]}; i < ${#v2[@]}; i++)); do
    v1[i]=0
  done

  for ((i = 0; i < ${#v1[@]}; i++)); do
    # Fill empty positions in v2 with zeros.
    if [[ -z ${v2[i]} ]]; then
      v2[i]=0
    fi

    if ((10#${v1[i]} < 10#${v2[i]})); then
      return 1
    elif ((10#${v1[i]} > 10#${v2[i]})); then
      return 0
    fi
  done
}

mkd() {
  if [ -n "$1" ]; then
    if [ -e "$1" ]; then
      if [ ! -d "$1" ]; then
        print_error "$1 - a file with the same name already exists!"
      else
        print_success "$1"
      fi
    else
      execute "mkdir -p $1" "$1"
    fi
  fi
}

printf_newline() { printf "${*:-}\n"; }
print_in_color() { printf "%b" "$(tput setaf "$2" 2>/dev/null)" "$1" "$(tput sgr0 2>/dev/null)"; }
printf_normal() { printf_color "\t\t$1\n" "$2"; }
printf_green() { printf_color "\t\t$1\n" 2; }
printf_red() { printf_color "\t\t$1\n" 1; }
printf_purple() { printf_color "\t\t$1\n" 5; }
printf_yellow() { printf_color "\t\t$1\n" 3; }
printf_blue() { printf_color "\t\t$1\n" 4; }
printf_cyan() { printf_color "\t\t$1\n" 6; }
print_in_green() { print_in_color "$1" 2; }
print_in_purple() { print_in_color "$1" 5; }
print_in_red() { print_in_color "$1" 1; }
print_in_yellow() { print_in_color "$1" 3; }
print_question() { print_in_yellow "   [?] $1"; }
print_success() { print_in_green "   [✔] $1\n"; }
print_warning() { print_in_yellow "   [!] $1\n"; }
print_error() { print_in_red "   [✖] $1 $2\n"; }
print_error_stream() {
  while read -r line; do
    print_error "↳ ERROR: $line"
  done
}
print_result() {
  if [ "$1" -eq 0 ]; then
    print_success "$2"
  else
    print_error "$2"
  fi
  return "$1"
}

set_trap() { trap -p "$1" | grep "$2" &>/dev/null || trap '$2' "$1"; }

skip_questions() {
  while :; do
    case $1 in
    -y | --yes) return 0 ;;
    *) break ;;
    esac
    shift 1
  done
  return 1
}

show_spinner() {
  local -r FRAMES='/-\|'
  # shellcheck disable=SC2034
  local -r NUMBER_OR_FRAMES=${#FRAMES}
  local -r CMDS="$2"
  local -r MSG="$3"
  local -r PID="$1"
  local i=0
  local frameText=""
  while kill -0 "$PID" &>/dev/null; do
    frameText="   [${FRAMES:i++%NUMBER_OR_FRAMES:1}] $MSG"
    printf "%s" "$frameText"
    sleep 0.2
    printf "\r"
  done
}

#connection test
__am_i_online() {
  local site="1.1.1.1"
  [ -z "$FORCE_CONNECTION" ] || return 0
  return_code() {
    if [ "$1" = 0 ]; then
      return 0
    else
      return 1
    fi
  }
  __test_ping() {
    local site="$1"
    timeout 0.3 ping -c1 $site >/dev/null 2>&1
    local pingExit=$?
    return_code $pingExit
  }
  __test_http() {
    local site="$1"
    curl -LSIs --max-time 1 http://$site" | grep -e "HTTP/[0123456789]" | grep "200 -n1 >/dev/null 2>&1
    local httpExit=$?
    return_code $httpExit
  }
  err() { [ "$1" = "show" ] && printf_error "${3:-1}" "${2:-This requires internet, however, You appear to be offline!}" 1>&2; }
  __test_ping "$site" || __test_http "$site" || err "$@"
}
#am_i_online_err "Message" "color" "exitCode"
__am_i_online_err() { __am_i_online show "$@"; }
