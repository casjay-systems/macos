#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
  . "../utils.sh"

srcdir="$(cd ../.. && pwd)"
customizedir="$(cd ../../customize && pwd)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_fonts() {

  if [ -L ~/.local/share/fonts ]; then unlink ~/Library/Fonts; fi
  if [ -d ~/.local/share/fonts ] && [ ! -L ~/Library/Fonts ]; then
    mv -f ~/Library/Fonts ~/Library/Fonts.old
  fi

  echo ""
  execute \
    "ln -sf $customizedir/fonts ~/Library/Fonts" \
    "$customizedir/fonts → ~/Library/Fonts"

  if [ -d ~/.local/share/fonts.old ]; then
    rsync -ahq ~/.Library/Fonts/* ~/Library/Fonts/ 2>/dev/null
    rm -Rf ~/Library/Fonts.old/
  fi

}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  create_fonts

}

main
