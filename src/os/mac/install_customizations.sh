#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
  . "../utils.sh"

srcdir="$(cd ../.. && pwd)"

customizedir="$(cd ../../customize && pwd)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_user_shortcuts() {

  execute \
    "ln -sf $(command -v gdircolors) "$HOME"/.local/bin/dircolors" \
    "Creating dircolors"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_fonts() {

  if [ -L "$HOME"/.local/share/fonts ]; then unlink "$HOME"/Library/Fonts; fi
  if [ -d "$HOME"/.local/share/fonts ] && [ ! -L "$HOME"/Library/Fonts ]; then
    rsync -ahq "$HOME"/Library/Fonts "$HOME"/Library/Fonts.old 2>/dev/null &&
      rm -Rf "$HOME"/Library/Fonts
  fi

  execute \
    "ln -sf $customizedir/fonts "$HOME"/Library/Fonts" \
    "$customizedir/fonts → ~/Library/Fonts"

  if [ -d "$HOME"/.local/share/fonts.old ]; then
    rsync -ahq "$HOME"/.Library/Fonts.old/* "$HOME"/Library/Fonts/ 2>/dev/null
    rm -Rf "$HOME"/Library/Fonts.old/ 2>/dev/null
  fi

}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  create_user_shortcuts

  create_fonts

}

main
