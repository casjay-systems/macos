#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
  . "../utils.sh"

srcdir="$(cd .. && pwd)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_zsh() {
  if [ -f "$srcdir/config/zsh/install.sh" ]; then
    execute "bash -c $srcdir/config/zsh/install.sh" "Installing zsh: $srcdir/config/zsh/install.sh"
  elif [ -d "$srcdir/config/zsh" ]; then
    rm -Rf ~/.zshrc
    execute \
      "ln -sf $srcdir/config/zsh/zshrc ~/.zshrc" \
      "$srcdir/config/zsh/zshrc → ~/.zshrc"
  else
    exit
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_omyzsh() {
  if [ ! -f "$srcdir/config/zsh/install.sh" ]; then
    if [ -d "$HOME/.local/share/zsh/oh-my-zsh/.git" ]; then
      execute \
        "git -C $HOME/.local/share/zsh/oh-my-zsh pull -q" \
        "Updating oh-my-zsh"

    else
      execute \
        "rm -Rf $HOME/.local/share/zsh/oh-my-zsh && \
        git clone -q https://github.com/robbyrussell/oh-my-zsh.git $HOME/.local/share/zsh/oh-my-zsh" \
        "https://github.com/robbyrussell/oh-my-zsh.git → $HOME/.local/share/zsh/oh-my-zsh"
    fi
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
setup_plugins() {
  if [ -f "$srcdir/config/zsh/install.sh" ]; then
    if [ -d "$HOME/.local/share/zsh/oh-my-zsh/custom/plugins/zsh-syntax-highlighting/.git" ]; then
      execute \
        "git -C $HOME/.local/share/zsh/oh-my-zsh/custom/plugins/zsh-syntax-highlighting" \
        "Updating zsh-syntax-highlighting"
    else
      execute \
        "git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.local/share/zsh/oh-my-zsh/custom/plugins/zsh-syntax-highlighting" \
        "Installing zsh-syntax-highlighting"
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if [ -d "$HOME/.local/share/zsh/oh-my-zsh/custom/themes/powerlevel9k/.git" ]; then
      execute \
        "git -C $HOME/.local/share/zsh/oh-my-zsh/custom/themes/powerlevel9k pull -q" \
        "Updating powerlevel9k "
    else
      execute \
        "rm -Rf $HOME/.local/share/zsh/oh-my-zsh/custom/themes/powerlevel9k && \
        git clone -q https://github.com/bhilburn/powerlevel9k.git $HOME/.local/share/zsh/oh-my-zsh/custom/themes/powerlevel9k" \
        "https://github.com/bhilburn/powerlevel9k.git → $HOME/.local/share/zsh/oh-my-zsh/custom/themes/powerlevel9k"
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if [ -d "$HOME/.local/share/zsh/oh-my-zsh/custom/themes/powerlevel10k/.git" ]; then
      execute \
        "git -C $HOME/.local/share/zsh/oh-my-zsh/custom/themes/powerlevel10k pull -q" \
        "Updating powerlevel10k"
    else
      execute \
        "rm -Rf $HOME/.local/share/zsh/oh-my-zsh/custom/themes/powerlevel10k && \
        git clone -q https://github.com/romkatv/powerlevel10k.git $HOME/.local/share/zsh/oh-my-zsh/custom/themes/powerlevel10k" \
        "https://github.com/romkatv/powerlevel10k.git → $HOME/.local/share/zsh/oh-my-zsh/custom/themes/powerlevel10k"
    fi
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  setup_zsh
  setup_omyzsh
  setup_plugins

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main
