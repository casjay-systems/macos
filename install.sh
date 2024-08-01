#!/usr/bin/env bash

# // TODO: Add the ability to specify custom git repo

# Detect the platform (similar to $OSTYPE)
OS="$(uname)"
case $OS in
'Darwin')
  OS='Mac'
  if [ -z "$UPDATE" ]; then
    echo "Detected os is $OS"
    echo "Running the installer" && sleep 3 && bash -c "$(curl -LsS https://github.com/casjay-systems/macos/raw/main/src/os/mac_setup.sh)"
  else
    echo "Detected os is $OS"
    echo "Running the Updater" && sleep 3 && UPDATE=yes bash -c "$(curl -LsS https://github.com/casjay-systems/macos/raw/main/src/os/mac_setup.sh)"
  fi
  ;;
esac
