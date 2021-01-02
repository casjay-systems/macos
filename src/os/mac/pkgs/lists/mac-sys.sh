#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../../utils.sh"
  
# Define taps
TAPS="homebrew/cask-fonts "

# Define brew apps
BREW="git svn fortune cowsay neofetch coreutils fish bash zsh bash-completion@2 rsync "
BREW+="nano neovim macvim emacs thefuck fnm byobu nethogs iftop iperf jq dialog links html2text "
BREW+="mpd ncmpcpp newsboat pass editorconfig tmux screen hub zsh fish zsh-completions speedtest-cli"
BREW+="ruby php perl nodejs golang nvm youtube-dl direnv wget curl iproute2mac powerline-go dict "

#Define brew casks apps
CASKS="font-ubuntu font-powerline-symbols font-powerline-symbols visual-studio-code firefox atom obs "
CASKS+="powershell libreoffice transmission gpg-suite opera brave-browser tor-browser thunderbird skype "
CASKS+="authy darktable nextcloud brackets iterm2 terminology vlc postman lastpass spectacle alfred the-unarchiver "

# install
for tap in $TAPS; do
  echo ""
  execute "brew tap $tap" "Setting up $tap"
done
echo ""
for brew in $BREW; do
  echo ""
  execute "brew install -f $brew" "Setting up $brew"
done
echo ""
for cask in $CASKS; do
  echo ""
  execute "brew install --cask -f $cask" "Setting up $cask"
done
echo ""
