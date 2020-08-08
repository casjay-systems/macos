#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
  . "../utils.sh"

srcdir="$(cd .. && pwd)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_fish() {
  echo ""
  execute \
    "unlink ~/.config/fish \
    rm -Rf ~/.config/fish && \
    ln -sf $srcdir/config/fish ~/.config/" \
    "$srcdir/config/fish → ~/.config/fish"
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_ohmyfish() {
  echo ""
  execute \
    "rm -Rf ~/.config/fish/omf && \
    curl -LSs https://get.oh-my.fish > "$HOME"/.config/fish/omf-install \
    fish "$HOME"/.config/fish/omf-install --path=~/.config/fish/plugins --config=~/.config/fish/omf --noninteractive --yes \
    fish "$HOME"/.config/fish/plugins.fish \
    rm -Rf "$HOME"/.config/fish/omf-install" \
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
