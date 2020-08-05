#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Sudo prompt

export SUDO_PROMPT="$(printf "\t\t\033[1;31m")[sudo]$(printf "\033[1;36m") password for $(printf "\033[1;32m")%p: $(printf "\033[0m")"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
