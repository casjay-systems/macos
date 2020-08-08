#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
  . "../utils.sh"

srcdir="$(cd .. && pwd)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
rm -Rf "$HOME/.config/fish/omf" >/dev/null 2>&1
unlink -f "$HOME/.config/fish" >/dev/null 2>&1

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_fish() {
  echo ""
  execute \
    "ln -sf $srcdir/config/fish $HOME/.config/" \
    "$srcdir/config/fish → $HOME/.config/fish"
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_ohmyfish() {
  echo ""
  execute \
    "curl -LSsq https://get.oh-my.fish > $HOME/.config/fish/omf-install && \
    fish $HOME/.config/fish/omf-install --path=$HOME/.local/share/fish/oh-my-fish --config=$HOME/.config/fish/omf --noninteractive --yes \
    fish $HOME/.config/fish/plugins.fish" \
    "Installing oh-my-fish"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_fishplugins() {
  echo ""
  execute \
    "fish $HOME/.config/fish/plugins.fish 2>/dev/null" \
    "Installing fish plugins"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  setup_fish

  setup_ohmyfish

  setup_fishplugins

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main
