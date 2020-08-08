#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
  . "../utils.sh"

srcdir="$(cd .. && pwd)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_tmux() {
  rm -Rf ~/.tmux.conf
  echo ""
  execute \
    "ln -sf $srcdir/config/tmux/tmux.conf ~/.tmux.conf" \
    "$srcdir/config/tmux/tmux.conf → ~/.tmux.conf"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_tmuxplugins() {
  if [ -d ~/.tmux/plugins/tpm ]; then

    echo ""
    execute \
      "cd $HOME/.local/share/tmux/plugins/tpm && \
      git pull -q" \
      "Updating tmux plugin manager"
    echo ""
    execute \
      "$HOME/.local/share/tmux/plugins/tpm/scripts/install_plugins.sh 2> /dev/null" \
      "Updating tmux plugins"
  else

    echo ""
    execute \
      "rm -Rf $HOME/.local/share/tmux/plugins/tpm && \
      git clone -q https://github.com/tmux-plugins/tpm $HOME/.local/share/tmux/plugins/tpm" \
      "https://github.com/tmux-plugins/tpm → $HOME/.local/share/tmux/plugins/tpm"
    echo ""
    execute \
      "$HOME/.local/share/tmux/plugins/tpm/scripts/install_plugins.sh" \
      "Installing tmux plugins → $HOME/.local/share/tmux/plugins"
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_tmux_local() {

  declare -r FILE_PATH="$HOME/.config/local/tmux.local"

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  if [ ! -e "$FILE_PATH" ]; then
    printf "" >>"$FILE_PATH"
  fi

  print_result $? "$FILE_PATH"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  create_tmux_local

  setup_tmux

  setup_tmuxplugins

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main
