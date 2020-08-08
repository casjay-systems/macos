#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : ppi.bash
# @Created     : Mon, Dec 31, 2019, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : Process phone images
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set functions

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

ppi() {
  command -v "convert" &>/dev/null || exit 0
  declare query="${1:-*.jpg}"
  declare geometry="${2:-50%}"
  for i in "$query"; do
    if [[ "$(echo ${i##*.} | tr '[:upper:]' '[:lower:]')" != "png" ]]; then
      imgName="${i%.*}.png"
    else
      imgName="_${i%.*}.png"
    fi
    convert "$i" \
      -colorspace RGB \
      +sigmoidal-contrast 11.6933 \
      -define filter:filter=Sinc \
      -define filter:window=Jinc \
      -define filter:lobes=3 \
      -sigmoidal-contrast 11.6933 \
      -colorspace sRGB \
      -background transparent \
      -gravity center \
      -resize "$geometry" \
      +append \
      "$imgName" &&
      printf "* %s (%s)\n" \
        "$imgName" \
        "$geometry"
  done
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
