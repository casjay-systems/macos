#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
  . "../utils.sh"

srcdir="$(cd .. && pwd)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_fish() {
  echo ""
  execute \
    "unlink ~/.config/fish \
    rm -Rf ~/.config/fish \
    ln -sf $srcdir/config/fish ~/.config/" \
    "$srcdir/config/fish → ~/.config/fish"
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_ohmyfish() {
  echo ""
  execute \
    "rm -Rf ~/.config/fish/omf \
    curl -LSsq https://get.oh-my.fish >~/.config/fish/omf-install \
    fish ~/.config/fish/omf-install --path=~/.local/share/fish/oh-my-fish --config=~/.config/fish/omf --noninteractive --yes \
    fish ~/.config/fish/plugins.fish" \
    "Installing oh-my-fish"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_fishplugins() {
  echo ""
  execute \
    "fish $srcdir/config/fish/plugins.fish 2>/dev/null" \
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
