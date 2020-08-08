#!/usr/bin/env bash

brew tap homebrew/cask-fonts
brew install -f git fortune cowsay neofetch coreutils fish vim bash zsh bash-completion@2 rsync
brew install -f mpd ncmpcpp newsboat pass editorconfig tmux screen hub zsh fish zsh-completions
brew install -f ruby php perl nodejs golang nvm youtube-dl direnv wget curl iproute2mac powerline-go
brew install -f nano neovim
brew cask install -f font-ubuntu font-powerline-symbols font-powerline-symbols visual-studio-code firefox atom
brew cask install -f powershell libreoffice transmission gpg-suite opera brave-browser tor-browser thunderbird
brew cask install -f authy darktable nextcloud brackets iterm2 terminology vlc emacs postman lastpass
brew cask install -f the-unarchiver obs skype spectacle alfred chirp

brew install -f vim --with-override-system-vi --with-lua --with-python3 --enable-gui --with-tlib
brew install -f emacs --with-cocoa --with-modules --with-imagemagick --with-librsvg --with-mailutils
