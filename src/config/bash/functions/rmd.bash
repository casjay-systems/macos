#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : rmd
# @Created     : Mon, Dec 31, 2019, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : remove files and directories recursively
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# remove files and directories.

rmd() {
if [ -n "$*" ]; then
  printf_green "Deleting $@"
  rm -Rf "$@"
else
  printf_red "Must provide path to file or folder for deletion $@"
fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# vi: ts=4 noai

