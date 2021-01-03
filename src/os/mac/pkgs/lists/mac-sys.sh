#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
  . "../../../utils.sh"

srcdir="$(cd ../../.. && pwd)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

brew_tap_packages() {
  # Define taps
  local TAPS="homebrew/cask-fonts"

  # install
  for tap in ${TAPS}; do
    execute "brew tap ${tap}" "Setting up taps"
  done
}

brew_app_packages() {
  # Define brew apps
  local BREWS="git svn fortune cowsay neofetch coreutils fish bash zsh bash-completion@2 rsync "
  local BREWS+="nano neovim macvim emacs thefuck fnm byobu nethogs iftop iperf jq dialog links html2text "
  local BREWS+="mpd ncmpcpp newsboat pass editorconfig tmux screen hub zsh fish zsh-completions speedtest-cli "
  local BREWS+="ruby php perl node golang nvm youtube-dl direnv wget curl iproute2mac powerline-go dict "

  # install
  #for brew in ${BREWS}; do
  execute "brew install -f ${BREWS}" "Setting up brew apps"
  #done
}

brew_casks_packages() {
  #Define brew casks apps
  local CASKS="font-ubuntu font-powerline-symbols visual-studio-code firefox atom obs powershell "
  local CASKS+="libreoffice transmission gpg-suite opera brave-browser tor-browser thunderbird skype "
  local CASKS+="authy darktable nextcloud brackets iterm2 terminology vlc postman lastpass spectacle alfred the-unarchiver "

  # install
  #for cask in ${CASKS}; do
  execute "brew install --cask -f ${CASKS}" "Setting up brew casks"
  #done
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  brew_tap_packages
  brew_app_packages
  brew_casks_packages

}

main
