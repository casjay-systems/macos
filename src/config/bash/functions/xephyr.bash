#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.com
# @File        : xephyr.bash
# @Created     : Mon, Dec 31, 2019, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : xephyr function
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set functions

xephyr() {
local args="$@"
if [ -f $(command -v Xephyr) ]; then
  if [ ! -z DISPLAY_LOW_DENSITY ]; then
    DISPLAY=$DISPLAY_LOW_DENSITY RESOLUTION="$(xrandr --current | grep  '*' | uniq | awk '{print $1}')"
  else 
    DISPLAY=$DISPLAY RESOLUTION="$(xrandr --current | grep  '*' | uniq | awk '{print $1}')"
  fi 

  if ! pidof Xephyr >/dev/null 2>&1 ; then
     Xephyr -br -ac -noreset -screen $RESOLUTION :9 >/dev/null 2>&1 &
     sleep 3
  fi
    DISPLAY=:9 "$args" >/dev/null 2>&1
fi  
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
