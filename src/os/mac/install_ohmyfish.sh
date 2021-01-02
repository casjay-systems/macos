#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
  . "../utils.sh"

srcdir="$(cd .. && pwd)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_fish() {
  unlink "$HOME/.config/fish" 2>/dev/null || rm -Rf $HOME/.config/fish 2>/dev/null
  if [ -f "$srcdir/config/fish/install.sh" ]; then
    execute "bash -c $srcdir/config/fish/install.sh" "Installing fish: $srcdir/config/fish/install.sh"
  elif [ -d "$srcdir/config/fish" ]; then
    execute \
      "ln -sf $srcdir/config/fish ~/.config/" \
      "$srcdir/config/fish → ~/.config/fish"
  else
    exit
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_ohmyfish() {
  if [ ! -f "$srcdir/config/fish/install.sh" ]; then
    if [ -d "$HOME/.local/share/fish/oh-my-fish/.git" ]; then
      execute \
        "git -C $HOME/.local/share/fish/oh-my-fish pull -q >/dev/null 2>&1 && \
        fish -c omf update" \
        "Updating oh-my-fish"
    else
      if [ ! -d "$HOME/.local/share/omf" ]; then
        curl -LSs https://github.com/oh-my-fish/oh-my-fish/raw/master/bin/install >"$srcdir/config/fish/omf-install"
        execute \
          "fish $srcdir/config/fish/omf-install --noninteractive --yes" \
          "Installing oh-my-fish"
      fi
    fi
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_fishplugins() {
  if [ ! -f "$srcdir/config/fish/install.sh" ]; then
    if [ -f "$srcdir/config/fish/plugins.fish" ]; then
      execute \
        "fish -c $srcdir/config/fish/plugins.fish 2>/dev/null" \
        "Installing fish plugins"
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
