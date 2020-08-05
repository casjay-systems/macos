#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Lock screen.
alias afk="gnome-screensaver-command --lock"    #lock screen

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -



# Empty trash.
alias empty-trash="rm -rf ~/.local/share/Trash/files/*"  #Delete old files

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Hide/Show desktop icons.
alias desktop-icons-hide="gsettings set org.gnome.desktop.background show-desktop-icons false"
alias desktop-icons-show="gsettings set org.gnome.desktop.background show-desktop-icons true"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Open from the terminal.
alias o="xdg-open"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# netstat aliases
alias ports="sudo netstat -taupln | grep LISTEN"
alias netstat="sudo netstat"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

