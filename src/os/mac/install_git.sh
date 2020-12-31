#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
  . "../utils.sh"

srcdir="$(cd .. && pwd)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_git() {

  echo ""
  execute \
    "ln -sf $srcdir/config/git/gitconfig ~/.gitconfig" \
    "$srcdir/config/git/gitconfig  → ~/.gitconfig"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
install_ohmygit() {

  if [ ! -d "$HOME/.local/share/git/plugins/.git" ]; then

    echo ""
    execute \
      "rm -Rf $HOME/.local/share/git/plugins && \
      git clone https://github.com/arialdomartini/oh-my-git.git $HOME/.local/share/git/plugins" \
      "cloning oh-my-git → $HOME/.local/share/git/plugins"

  else
    echo ""
    execute \
      "cd $HOME/.local/share/git/plugins && \
      git pull -q" \
      "Updating oh-my-git"

  fi
  isInFile=$(cat ~/.config/local/bash.local | grep -c "oh-my-git")
  if [ $isInFile -eq 0 ]; then

    declare -r CONFIGS="
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# OH-MY-GIT

[ -f \"\$HOME/.config/git/plugins/prompt.sh\" ] \\
    && source \"\$HOME/.config/git/plugins/prompt.sh\"
"

    echo ""
    execute \
      "printf '%s' '$CONFIGS' >> ~/.config/local/bash.local" \
      "Enabling oh-my-git in ~/.config/local/bash.local"
  fi

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_gitconfig_local() {

  declare -r FILE_PATH="$HOME/.config/local/gitconfig.local"

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  if [ ! -e "$FILE_PATH" ]; then
    printf "" >>"$FILE_PATH"

    print_result $? "$FILE_PATH"

  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  create_gitconfig_local

  install_git

  install_ohmygit

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main
