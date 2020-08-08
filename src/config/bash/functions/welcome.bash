#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : zz-welcome.bash
# @Created     : Mon, Dec 23, 2019, 14:13 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : welcome message
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set functions

printf_color() { printf "%b" "$(tput setaf "$2" 2>/dev/null)" "$1" "$(tput sgr0 2>/dev/null)"; }
printf_green() { printf_color "$1" 2; }
printf_red() { printf_color "$1" 1; }

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Main progam

show_welcome() {
  if [ ! -f $HOME/.config/bash/welcome.msg ]; then
    printf_green "
    \t\tWelcome to your system!
    \t\tIt would appear that it
    \t\thas been setup successfully.
    \t\tThe .sample files can be edited
    \t\tand renamed as they wont be
    \t\toverwritten on any updates.
    \n\t\tIf you configured tor you can run
    \t\tthe command show_welcome_tor
    \n\n"
    ask_for_confirmation "Show this message again?"
    printf "\n"
    if ! answer_is_yes; then
      touch $HOME/.config/bash/welcome.msg
    fi
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

show_welcome_tor() {
  if (sudo -vn && sudo -ln) 2>&1 | grep -v 'may not' >/dev/null; then
    if sudo bash -c '[ -f /var/lib/tor/hidden_service/hostname ]'; then
      printf_green "
    \t\tthe tor hostname of this system is:
    \t\t$(sudo cat /var/lib/tor/hidden_service/hostname)\n"
      sudo cat /var/lib/tor/hidden_service/hostname >"$HOME/tor_hostname"
    fi
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#/* vim set expandtab ts=4 noai
