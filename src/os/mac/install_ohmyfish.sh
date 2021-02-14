#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" && . "../utils.sh"
srcdir="$(cd .. && pwd)"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
setup_fish() {
  __cmd_exists dfmgr && dfmgr install fish && return
  [ -d "$srcdir/config/fish" ] || return
  unlink "$HOME/.config/fish" 2>/dev/null || rm -Rf "$HOME/.config/fish" 2>/dev/null
  if [ -f "$srcdir/config/fish/install.sh" ]; then
    execute "bash -c $srcdir/config/fish/install.sh" "Installing fish: $srcdir/config/fish/install.sh"
  elif [ -d "$srcdir/config/fish" ] && [ ! -L "$HOME/.config/fish" ]; then
    execute \
      "ln -sf $srcdir/config/fish ~/.config/" \
      "$srcdir/config/fish → ~/.config/fish"
  else
    exit
  fi
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
setup_ohmyfish() {
  [ -d "$srcdir/config/fish" ] || return
  if [ ! -f "$srcdir/config/fish/install.sh" ]; then
    if [ -d "$HOME/.local/share/fish/oh-my-fish/.git" ]; then
      execute "fish -c omf update" "Updating oh-my-fish"
    else
      if [ ! -d "$HOME/.local/share/omf" ]; then
        __curl https://github.com/oh-my-fish/oh-my-fish/raw/master/bin/install >"$srcdir/config/fish/omf-install"
        execute \
          "fish $srcdir/config/fish/omf-install --noninteractive --yes" \
          "Installing oh-my-fish"
      fi
    fi
  fi
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
setup_fishplugins() {
  [ -d "$srcdir/config/fish" ] || return
  if [ ! -f "$srcdir/config/fish/install.sh" ]; then
    if [ -f "$srcdir/config/fish/plugins.fish" ]; then
      execute \
        "fish -c $srcdir/config/fish/plugins.fish 2>/dev/null" \
        "Installing oh-my-fish plugins"
    fi
  fi
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
main() {
  setup_fish
  setup_ohmyfish
  setup_fishplugins
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
main
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
