#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" && . "../utils.sh"
srcdir="$(cd .. && pwd)"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
install_vim() {
  __cmd_exists dfmgr && dfmgr install vim && return
  [ -d "$srcdir/config/vim" ] || return
  if [ -f "$srcdir/config/vim/install.sh" ]; then
    execute "bash -c $srcdir/config/vim/install.sh" "Installing vim: $srcdir/config/vim/install.sh"
  elif [ -d "$srcdir/config/vim" ]; then
    rm -Rf "$HOME/.vimrc"
    if [ -L "$HOME/.vim" ]; then unlink "$HOME/.vim" 2>/dev/null; fi
    if [ -d "$HOME/.vim" ]; then rm -Rf -f "$HOME/.vim" 2>/dev/null; fi
    execute \
      "ln -sf $HOME/.config/vim $HOME/.vim" \
      "$HOME/.config/vim/  → $HOME/.vim"
    execute \
      "ln -sf $srcdir/config/vim/vimrc $HOME/.vimrc" \
      "$srcdir/config/vim/vimrc → $HOME/.vimrc"
  else
    exit
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_vimplugins() {
  [ -d "$srcdir/config/vim" ] || return
  if [ ! -f "$srcdir/config/vim/install.sh" ]; then
    if [ -d "$HOME/.local/share/vim/bundle/Vundle.vim/.git" ]; then
      execute \
        "git -C $HOME/.local/share/vim/bundle/Vundle.vim pull -q && \
        /usr/local/bin/vim -u $srcdir/config/vim/plugins.vimrc +PluginInstall +qall < /dev/null > /dev/null 2>&1" \
        "Updating Vundle and Plugins"
    else
      rm -Rf "$HOME/.local/share/vim/bundle/Vundle.vim"
      execute \
        "git clone -q https://github.com/VundleVim/Vundle.vim.git $HOME/.local/share/vim/bundle/Vundle.vim && \
        /usr/local/bin/vim -u $srcdir/config/vim/plugins.vimrc +PluginInstall +qall < /dev/null > /dev/null 2>&1" \
        "vim +PluginInstall +qall → $HOME/.local/share/vim/bundle/Vundle.vim"
    fi
  fi
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
main() {
  install_vim
  install_vimplugins
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
main
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
