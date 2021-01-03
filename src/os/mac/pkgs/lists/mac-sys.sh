#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
  . "../../../utils.sh"

srcdir="$(cd ../../.. && pwd)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

brew_packages() {

  # Define taps
  TAPS="homebrew/cask-fonts"

  # Define brew apps
  BREW="git svn fortune cowsay neofetch coreutils fish bash zsh bash-completion@2 rsync "
  BREW+="nano neovim macvim emacs thefuck fnm byobu nethogs iftop iperf jq dialog links html2text "
  BREW+="mpd ncmpcpp newsboat pass editorconfig tmux screen hub zsh fish zsh-completions speedtest-cli "
  BREW+="ruby php perl nvm youtube-dl direnv wget curl iproute2mac powerline-go dict "

  #Define brew casks apps
  CASKS="font-ubuntu font-powerline-symbols visual-studio-code firefox atom obs powershell "
  CASKS+="libreoffice transmission gpg-suite opera brave-browser tor-browser thunderbird skype "
  CASKS+="authy darktable nextcloud brackets iterm2 terminology vlc postman lastpass spectacle alfred the-unarchiver "

  # install
  execute "brew tap ${TAPS}" "Setting up taps"

  execute "brew install -f ${BREW}" "Setting up brew packages"

  execute "brew install --cask -f ${CASKS}" "Setting up brew casks"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  brew_packages

}

main
