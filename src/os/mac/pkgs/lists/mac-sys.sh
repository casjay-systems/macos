#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
  . "../../../utils.sh"

srcdir="$(cd ../../.. && pwd)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

brew_tap_packages() {
  # Define taps
  declare -a TAPS=(
    "homebrew/cask-fonts"
  )

  # install
  if [ -n "$TAPS" ]; then
    for tap in ${TAPS}; do
      execute "brew tap ${tap}" "Setting up $tap       "
    done
    unset LISTARRAY
    unset TAPS
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

brew_app_packages() {
  # Define brew apps
  if [ -n "TRAVIS" ]; then
    local BREWS="git "
    local BREWS+="svn "
    local BREWS+="fortune "
  else
    local BREWS="font-ubuntu font-powerline-symbols font-fira-code font-hack-nerd-font "
    local BREWS+="git svn fortune cowsay neofetch coreutils fish bash zsh bash-completion@2 rsync typora "
    local BREWS+="nano neovim macvim emacs thefuck fnm byobu nethogs iftop iperf jq dialog links html2text "
    local BREWS+="mpd ncmpcpp newsboat pass editorconfig tmux screen hub zsh fish zsh-completions speedtest-cli "
    local BREWS+="ruby php perl node golang nvm youtube-dl direnv wget curl iproute2mac powerline-go dict jq"
  fi
  # install
  if [ -n "$BREWS" ]; then
    for brew in ${BREWS}; do
      execute "brew install -f ${brew}" "Setting up ${brew}       "
    done
  fi
  unset BREWS
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

brew_casks_packages() {
  #Define brew casks apps
  if [ -n "$TRAVIS" ]; then
    local CASKS="authy "
    local CASKS+="visual-studio-code "
  else
    local CASKS="visual-studio-code firefox atom obs powershell "
    local CASKS+="libreoffice transmission gpg-suite opera brave-browser tor-browser thunderbird skype "
    local CASKS+="authy darktable nextcloud brackets iterm2 terminology vlc insomnia lastpass spectacle alfred the-unarchiver "
  fi

  # install
  if [ -n "$CASKS" ]; then
    for cask in ${CASKS}; do
      execute "brew install --cask -f ${cask}" "Setting up ${cask}       "
    done
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
