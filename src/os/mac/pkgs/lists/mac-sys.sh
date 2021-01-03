#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
  . "../../../utils.sh"

srcdir="$(cd ../../.. && pwd)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

brew_tap_packages() {
  installcmd() {
    for tap in ${@}; do
      execute "brew tap ${tap}" "Setting up ${tap}       "
    done
  }

  # Define taps
  declare -a TAPS=(
    #"homebrew/cask"
    #"homebrew/cask-fonts"
  )

  # install
  if [ -n "$TAPS" ]; then
    execute "installcmd ${TAPS}" "Setting up taps       "
    unset TAPS
  fi
}

brew_app_packages() {
  installcmd() {
    for brew in ${@}; do
      execute "brew install -f ${brew}" "Setting up ${brew}       "
    done
  }

  # Define brew apps
  if [ -n "TRAVIS" ]; then
    local BREWS="git svn fortune "
  else
    local BREWS="font-ubuntu font-powerline-symbols font-fira-code font-hack-nerd-font "
    local BREWS+="git svn fortune cowsay neofetch coreutils fish bash zsh bash-completion@2 rsync typora "
    local BREWS+="nano neovim macvim emacs thefuck fnm byobu nethogs iftop iperf jq dialog links html2text "
    local BREWS+="mpd ncmpcpp newsboat pass editorconfig tmux screen hub zsh fish zsh-completions speedtest-cli "
    local BREWS+="ruby php perl node golang nvm youtube-dl direnv wget curl iproute2mac powerline-go dict "
  fi
  # install
  if [ -n "$CASKS" ]; then
    execute "installcmd ${BREWS}" "Setting up apps       "
  fi
  unset BREWS
}

brew_casks_packages() {
  installcmd() {
    for cask in ${@}; do
      execute "brew install --cask -f ${cask}" "Setting up ${cask}       "
    done
  }

  #Define brew casks apps
  if [ -n "$TRAVIS" ]; then
    local CASKS="visual-studio-code "
  else
    local CASKS="visual-studio-code firefox atom obs powershell "
    local CASKS+="libreoffice transmission gpg-suite opera brave-browser tor-browser thunderbird skype "
    local CASKS+="authy darktable nextcloud brackets iterm2 terminology vlc insomnia lastpass spectacle alfred the-unarchiver "
  fi

  # install
  if [ -n "$CASKS" ]; then
    execute "installcmd ${CASKS}" "Setting up casks       "
  fi
  unset CASKS
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  brew_tap_packages
  brew_app_packages
  brew_casks_packages

}

main
