#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : renameFilesRecursively.bash
# @Created     : Mon, Dec 31, 2019, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : rename Files Recursively function
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set functions

renameFilesRecursively() {

  SEARCH_PATH="$1"
  SEARCH="$2"
  REPLACE="$3"

  [ -z "$1" ] && printf_green 'usage: renameFilesRecursively "/home/user/my-files" "apple" "orange"' && return 1
  [ -z "$2" ] && printf_green 'usage: renameFilesRecursively "/home/user/my-files" "apple" "orange"' && return 1
  [ -z "$3" ] && printf_green 'usage: renameFilesRecursively "/home/user/my-files" "apple" "orange"' && return 1

  find ${SEARCH_PATH} -type f -name "*${SEARCH}*" | while read FILENAME; do
    NEW_FILENAME="$(echo ${FILENAME} | sed -e "s/${SEARCH}/${REPLACE}/g")"
    mv "${FILENAME}" "${NEW_FILENAME}"
  done

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
