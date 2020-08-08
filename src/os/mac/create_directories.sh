#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
  . "../utils.sh"

srcdir="$(cd .. && pwd)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if [ -d "$srcdir/bin" ]; then
  mkdir -p "$HOME/.local/bin"
  rsync -aq "$srcdir/bin/." "$HOME/.local/bin"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_directories() {
  echo ""
  declare -a DIRECTORIES=(
    "$HOME/.config"
    "$HOME/.config/local"
    "$HOME/.local/bin"
    "$HOME/Projects"
    "$HOME/Downloads/torrents"
    "$HOME/Library/Fonts"

  )

  for i in "${DIRECTORIES[@]}"; do
    mkd "$i"
  done

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  create_directories

}

main
