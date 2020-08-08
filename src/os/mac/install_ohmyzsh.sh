#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
  . "../utils.sh"

srcdir="$(cd .. && pwd)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_zsh() {
  rm -Rf ~/.zshrc
  echo ""
  execute \
    "ln -sf $srcdir/config/zsh/zshrc ~/.zshrc" \
    "$srcdir/config/zsh/zshrc → ~/.zshrc"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_omyzsh() {
  if [ -d "$HOME/.local/share/zsh/oh-my-zsh/.git" ]; then
    echo ""
    execute \
      "cd $HOME/.local/share/zsh/oh-my-zsh && git pull -q" \
      "Updating oh-my-zsh"

  else
    echo ""
    execute \
      "rm -Rf $HOME/.local/share/zsh/oh-my-zsh && \
      git clone -q https://github.com/robbyrussell/oh-my-zsh.git $HOME/.local/share/zsh/oh-my-zsh" \
      "https://github.com/robbyrussell/oh-my-zsh.git → $HOME/.local/share/zsh/oh-my-zsh"
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_zsh9k() {
  if [ -d "$HOME/.local/share/zsh/oh-my-zsh/custom/themes/powerlevel9k/.git" ]; then
    echo ""
    execute \
      "cd $HOME/.local/share/zsh/oh-my-zsh/custom/themes/powerlevel9k && \
      git pull -q" \
      "Updating powerlevel9k "
  else
    echo ""
    execute \
      "rm -Rf $HOME/.local/share/zsh/oh-my-zsh/custom/themes/powerlevel9k && \
      git clone -q https://github.com/bhilburn/powerlevel9k.git $HOME/.local/share/zsh/oh-my-zsh/custom/themes/powerlevel9k" \
      "https://github.com/bhilburn/powerlevel9k.git → $HOME/.local/share/zsh/oh-my-zsh/custom/themes/powerlevel9k"
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_zsh10k() {
  if [ -d "$HOME/.local/share/zsh/oh-my-zsh/custom/themes/powerlevel10k/.git" ]; then
    echo ""
    execute \
      "cd $HOME/.local/share/zsh/oh-my-zsh/custom/themes/powerlevel10k && \
      git pull -q" \
      "Updating powerlevel10k"
  else
    echo ""
    execute \
      "rm -Rf $HOME/.local/share/zsh/oh-my-zsh/custom/themes/powerlevel10k && \
      git clone -q https://github.com/romkatv/powerlevel10k.git $HOME/.local/share/zsh/oh-my-zsh/custom/themes/powerlevel10k" \
      "https://github.com/romkatv/powerlevel10k.git → $HOME/.local/share/zsh/oh-my-zsh/custom/themes/powerlevel10k"
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_syntax() {
  if [ -d "$HOME/.local/share/zsh/oh-my-zsh/custom/plugins/zsh-syntax-highlighting/.git" ]; then
    echo ""
    execute \
      "cd $HOME/.local/share/zsh/oh-my-zsh/custom/plugins/zsh-syntax-highlighting && \
      git pull -q" \
      "Updating zsh-syntax-highlighting"
  else
    echo ""
    execute \
      "rm -Rf $HOME/.local/share/zsh/oh-my-zsh/custom/plugins/zsh-syntax-highlighting && \
      git clone -q https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.local/share/zsh/oh-my-zsh/custom/plugins/zsh-syntax-highlighting" \
      "https://github.com/zsh-users/zsh-syntax-highlighting.git → $HOME/.local/share/zsh/oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  setup_zsh

  setup_omyzsh

  setup_zsh9k

  setup_zsh10k

  setup_syntax

  sudo chmod -R 755 /usr/local/share/zsh/site-functions /usr/local/share/zsh/site-functions

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main
