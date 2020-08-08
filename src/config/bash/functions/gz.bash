#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : gz.bash
# @Created     : Mon, Dec 31, 2019, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : Get gzip information (gzipped file size + reduction size).
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set functions

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

gz() {

  declare -i gzippedSize=0
  declare -i originalSize=0

  if [ -f "$1" ]; then
    if [ -s "$1" ]; then

      originalSize=$(wc -c <"$1")
      printf "\n original size:   %12s\n" "$(hrfs "$originalSize")"

      gzippedSize=$(gzip -c "$1" | wc -c)
      printf " gzipped size:    %12s\n" "$(hrfs "$gzippedSize")"

      printf " ─────────────────────────────\n"
      printf " reduction:       %12s [%s%%]\n\n" \
        "$(hrfs $((originalSize - gzippedSize)))" \
        "$(printf "%s" "$originalSize $gzippedSize" |
          awk '{ printf "%.1f", 100 - $2 * 100 / $1 }' |
          sed -e "s/0*$//;s/\.$//")"
      #              └─ remove tailing zeros

    else
      printf "\"%s\" is empty.\n" "$1"
    fi
  else
    printf "\"%s\" is not a file.\n" "$1"
  fi

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
