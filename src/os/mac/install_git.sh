#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
  . "../utils.sh"

srcdir="$(cd .. && pwd)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_git() {
  if [ -f "$srcdir/config/git/install.sh" ]; then
    execute "bash -c $srcdir/config/git/install.sh" "Installing GIT: $srcdir/config/git/install.sh"
  elif [ -d "$srcdir/config/git " ]; then
    execute \
      "ln -sf $srcdir/config/git/gitconfig ~/.gitconfig" \
      "$srcdir/config/git/gitconfig  → ~/.gitconfig"
  else
    exit
  fi
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_ohmygit() {
  if [ ! -f "$srcdir/config/git/install.sh" ]; then
    if [ ! -d "$HOME/.local/share/git/oh-my-git/.git" ]; then
      execute \
        "rm -Rf $HOME/.local/share/git/oh-my-git && \
      git clone https://github.com/arialdomartini/oh-my-git $HOME/.local/share/git/oh-my-git" \
        "cloning oh-my-git → $HOME/.local/share/git/oh-my-git"
    else
      execute \
        "git -C $HOME/.local/share/git/oh-my-git pull -q" \
        "Updating oh-my-git"
    fi
  fi

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  if [ -f "$HOME/.config/local/bash.local" ]; then
    isInFile=$(cat "$HOME/.config/local/bash.local" | grep -c "oh-my-git")
    if [ $isInFile -eq 0 ]; then

      declare -r CONFIGS="
# OH-MY-GIT
[ -f \"\$HOME/.local/share/git/oh-my-git/prompt.sh\" ] \\
    && source \"\$HOME/.local/share/git/oh-my-git/prompt.sh\"
"

      execute \
        "printf '%s' '$CONFIGS' >> ~/.config/local/bash.local" \
        "Enabling oh-my-git in ~/.config/local/bash.local"
    fi
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  install_git
  install_ohmygit

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main
