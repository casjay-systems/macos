#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# passmgr default settings - copy to your bash.local and change for your setup

if [ -f "$HOME/.config/secure/passmgr.txt" ]; then
    source "$HOME/.config/secure/passmgr.txt"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# github default settings - copy to your bash.local and change for your setup

if [ -f "$HOME/.config/secure/github.txt" ]; then 
    source "$HOME/.config/secure/github.txt"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# gitlab default settings - copy to your bash.local and change for your setup

if [ -f "$HOME/.config/secure/gitlab.txt" ]; then 
    source "$HOME/.config/secure/gitlab.txt"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# your private git - copy to your bash.local and change for your setup

if [ -f "$HOME/.config/secure/gitpriv.txt" ]; then 
    source "$HOME/.config/secure/gitpriv.txt"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Dotfiles base repo  - copy to your bash.local and change for your setup

if [ -f "$HOME/.config/secure/personal.txt" ]; then 
    source "$HOME/.config/secure/personal.txt"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# APIKEYS  - copy to your bash.local and change for your setup

if [ -f "$HOME/.config/secure/apikeys.txt" ]; then 
    source "$HOME/.config/secure/apikeys.txt"
fi
