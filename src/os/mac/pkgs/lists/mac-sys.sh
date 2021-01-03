#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
  . "../../../utils.sh"

srcdir="$(cd ../../.. && pwd)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

brew_tap_packages() {
  installcmd() {
    execute "brew tap ${tap}" "Setting up ${tap}       "
  }

  # Define taps
  declare -a TAPS=(
    #"homebrew/cask"
    #"homebrew/cask-fonts"
  )

  # install
  if [ -n "$TAPS" ]; then
    for tap in ${TAPS}; do
      execute "installcmd ${tap}" "Setting up taps       "
    done
    unset TAPS
  fi
}

brew_app_packages() {
  installcmd() {
    execute "brew install -f ${brew}" "Setting up ${brew}       "
  }

  # Define brew apps
  local BREWS+="font-ubuntu font-powerline-symbols font-fira-code font-hack-nerd-font "
  local BREWS="git svn fortune cowsay neofetch coreutils fish bash zsh bash-completion@2 rsync typora "
  local BREWS+="nano neovim macvim emacs thefuck fnm byobu nethogs iftop iperf jq dialog links html2text "
  local BREWS+="mpd ncmpcpp newsboat pass editorconfig tmux screen hub zsh fish zsh-completions speedtest-cli "
  local BREWS+="ruby php perl node golang nvm youtube-dl direnv wget curl iproute2mac powerline-go dict "

  # install
  for brew in ${BREWS[@]}; do
    execute "installcmd ${brew}" "Setting up apps       "
  done
  unset BREWS
}

brew_casks_packages() {
  installcmd() {
    execute "brew install --cask -f ${cask}" "Setting up ${cask}       "
  }

  #Define brew casks apps
  local CASKS="visual-studio-code firefox atom obs powershell "
  local CASKS+="libreoffice transmission gpg-suite opera brave-browser tor-browser thunderbird skype "
  local CASKS+="authy darktable nextcloud brackets iterm2 terminology vlc insomnia lastpass spectacle alfred the-unarchiver "

  # install
  for cask in ${CASKS[@]}; do
    execute "installcmd ${cask}" "Setting up casks       "
  done
  unset CASKS
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  brew_tap_packages
  brew_app_packages
  brew_casks_packages

}

main
