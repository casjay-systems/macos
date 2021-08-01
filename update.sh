#!/usr/bin/env bash

#colors
red='\e[1;31m%s\e[0m\n'
green='\e[1;32m%s\e[0m\n'
yellow='\e[1;33m%s\e[0m\n'
blue='\e[1;34m%s\e[0m\n'
magenta='\e[1;35m%s\e[0m\n'
cyan='\e[1;36m%s\e[0m\n'
NC='\033[0m'

if [[ ! "$OSTYPE" =~ ^darwin ]]; then
  printf "\n\t\t${RED} This script is for MacOS ${NC}\n\n"
  exit 1
fi

# vars
DOTFILESDIR="${DOTFILESDIR:-$HOME/.local/dotfiles/OS}"
NEWVERSION=""
OLDVERSION=""
choice=""

# Version check

if [ -f "$DOTFILESDIR/version.txt" ]; then
  printf "\t\t$magenta" "Checking for updates"
  NEWVERSION="$(echo "$(curl -q -LSs https://github.com/casjay-systems/macos/raw/main/version.txt | grep -v "#" | tail -n 1)")"
  OLDVERSION="$(tail -n 1 "$DOTFILESDIR/version.txt")"
  if [ "$NEWVERSION" == "$OLDVERSION" ]; then
    printf "\t\t$green" "No updates available current version is $OLDVERSION\n"
  else
    printf "\t\t$red" "Update available - New version is $NEWVERSION"
    printf "\t\t$red" "Would you like to update? [y/N]"
    read -r -n 1 -s choice
    if [ "$choice" == "y" ]; then
      git -C "$DOTFILESDIR" pull -q
      printf "\t\t$green" "Updated to latest version = $NEWVERSION\n"
    else
      printf "\t\t$magenta" "You decided not to update\n"
    fi
  fi
else
  printf "\t\t$red" "Can't find $DOTFILESDIR/version.txt"
fi
