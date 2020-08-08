#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : kill.bash
# @Created     : Mon, Dec 31, 2019, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : kill all jobs
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set functions

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

killproc() {
  local i=""
  if [ ! -z "$1" ]; then
    printf_red "Killing $1"
    for i in $(pidof "$1"); do
      kill -9 "$i" | devnull
      wait "$i" >/dev/null
    done
  else
    printf_red "Killing\n$(jobs -p)"
    for i in $(jobs -p); do
      kill -9 "$i" | devnull
      wait "$i" >/dev/null
    done
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# kill zombie processes

killzombies() {

  case "$1" in
  --admin)
    stat=$(ps ax | awk '{print $1}' | grep -v "PID" | xargs -n 1 ps lOp | grep -v "UID" | awk '{print"pid: "$3" *** parent_pid: "$4" *** status: "$10" *** process: "$13}' | grep ": Z")
    if ((${#stat} > 0)); then
      printf_red "zombie processes found:"
      ps ax | awk '{print $1}' | grep -v "PID" | xargs -n 1 ps lOp | grep -v "UID" | awk '{print"pid: "$3" *** parent_pid: "$4" *** status: "$10" *** process: "$13}' | grep ": Z"
      printf_red "\t\tKill zombies? [y/n]: "
      read keyb
      if [ $keyb == 'y' ]; then
        printf_red "killing zombies.."
        ps ax | awk '{print $1}' | grep -v "PID" | xargs -n 1 ps lOp | grep -v "UID" | awk '{print$4" status:"$10}' | grep "status:Z" | awk '{print $1}' | xargs -n 1 kill -9
      else
        printf_red "User canceled.."
      fi
    else
      printf_green "No zombies found"
    fi
    ;;
  --cron)
    stat=$(ps ax | awk '{print $1}' | grep -v "PID" | xargs -n 1 ps lOp | grep -v "UID" | awk '{print"pid: "$3" *** parent_pid: "$4" *** status: "$10" *** process: "$13}' | grep ": Z")
    if ((${#stat} > 0)); then
      ps ax | awk '{print $1}' | grep -v "PID" | xargs -n 1 ps lOp | grep -v "UID" | awk '{print$4" status:"$10}' | grep "status:Z" | awk '{print $1}' | xargs -n 1 kill -9
      echo $(date)": killed some zombie proceses!" >>/var/log/zombies.log
    fi
    ;;
  *)
    printf_green "Usage: __killzombies {--cron|--admin}"
    ;;
  esac
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
