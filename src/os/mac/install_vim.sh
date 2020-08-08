#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
  . "../utils.sh"

srcdir="$(cd .. && pwd)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_vim() {

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  echo ""
  execute \
    "ln -sf $srcdir/config/vim/vimrc ~/.vimrc" \
    "$srcdir/config/vim/vimrc  → ~/.vimrc"

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  if [ ! -d "$HOME/.local/share/vim/bundle/Vundle.vim/.git" ]; then
    echo ""
    execute \
      "rm -Rf $HOME/.local/share/vim/bundle/Vundle.vim && \
      git clone -q https://github.com/VundleVim/Vundle.vim.git $HOME/.local/share/vim/bundle/Vundle.vim && \
      vim +PluginInstall +qall < /dev/null > /dev/null 2>&1" \
      "vim +PluginInstall +qall → $HOME/.local/share/vim/bundle/"

  else
    echo ""
    execute \
      "cd $HOME/.local/share/vim/bundle/Vundle.vim && \
      git pull -q && \
      vim -u "$HOME/.config/vim/plugins.vimrc" +PluginInstall +qall < /dev/null > /dev/null 2>&1" \
      "Updating Vundle and Plugins"
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_vimrc_local() {

  declare -r FILE_PATH="$HOME/.config/local/vimrc.local"

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  if [ ! -e "$FILE_PATH" ]; then
    printf "" >>"$FILE_PATH"
  fi

  print_result $? "$FILE_PATH"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  create_vimrc_local

  install_vim

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main
