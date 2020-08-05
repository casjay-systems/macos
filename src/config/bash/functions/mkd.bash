#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.com
# @File        : mkd
# @Created     : Mon, Dec 31, 2019, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : Create new directories and enter the first one
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set functions

mkd() {
    local dir="$1"
    if [ ! -z "$1" ]; then
      printf_green "Creating $@"
      mkdir -p "$@"
      cd "$dir"
    else
      printf_red "Usage: mkd folder\n"
    fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# vi: set ts=4 noai

