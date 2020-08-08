#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : timer.bash
# @Created     : Mon, Dec 31, 2019, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : shows up/down seconds counter. Exits and produces a sound if reaches zero
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set functions

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# shows up/down seconds counter. Exits and produces a sound if reaches zero

timer() {
  local ts=$(($(date +%s)+${1:-0}-1))
  export ts
  local p1='d=$(($(date +%s)-$ts));[ $d -lt 0 ] && d=$((-d));'
  local p2='[ $d -eq 0 ] && exit 1;'
  local p3='date -u -d @"$d" +"%H.%M.%S"'
  showbanner -t.5 $p1$p2$p3
  local status=$?
  eval "$p1$p3"
  [[ $status -eq 8 ]] && speaker-test -t sine -f 1500 -S 70 -p 10000 -l 1 &>/dev/null
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
