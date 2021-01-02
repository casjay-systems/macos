#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
  . "../utils.sh"

srcdir="$(cd .. && pwd)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
create_bash_local() {

  declare -r FILE_PATH="$HOME/.config/local/bash.local"

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  if [ ! -e "$FILE_PATH" ] || [ -z "$FILE_PATH" ]; then
    printf "%s\n" "#!/bin/bash" >>"$FILE_PATH"
    printf "%s\n" 'export HOMEBREW_INSTALL_BADGE="☕️ 🐸"' >>"$FILE_PATH"
    printf "%s\n" 'export HOMEBREW_CASK_OPTS="--appdir=/Applications"' >>"$FILE_PATH"
    printf "%s\n" 'export PATH="/usr/local/bin:$PATH:/usr/local/sbin:/usr/bin:/sbin"' >>"$FILE_PATH"

  fi

  print_result $? "$FILE_PATH"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  create_bash_local

}

main

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
