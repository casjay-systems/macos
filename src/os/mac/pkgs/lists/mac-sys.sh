#!/usr/bin/env bash

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
  execute "brew tap $tap" "Setting up $tap"
done

for brew in $BREW; do
  execute "brew install -f $brew" "Setting up $brew"
done

for cask in $CASKS; do
  execute "brew install --cask -f $cask" "Setting up $cask"  
done
