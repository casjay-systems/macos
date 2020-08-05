#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.com
# @File        : install
# @Created     : Mon, Dec 31, 2019, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : installer script for DFAPPNAME
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set functions

# copies a file and shows progress
copy() {
  [[ -z "$1" || -z "$2" ]] && {
    printf_red "Usage: copy /source/file /destination/file"
    return 1
  }
  local dest=$2
  local size=$(stat -c%s "$1")
  [[ -d "$dest" ]] && dest="$2/$(basename "$1")"
  dd if="$1" 2> /dev/null | pv -petrb -s "$size" | dd of="$dest"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
