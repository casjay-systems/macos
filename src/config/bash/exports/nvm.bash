#  -*- shell-script -*-

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# node version manager

export NO_UPDATE_NOTIFIER="true"
export NVM_BIN="$HOME/.local/bin"
export NVM_DIR="$HOME/.local/share/nvm"
export NODE_REPL_HISTORY_SIZE=10000
if [ ! -d "$NVM_DIR" ]; then mkdir -p "$NVM_DIR"; fi
if [ -s "$NVM_DIR/nvm.sh" ]; then . "$NVM_DIR/nvm.sh"; fi
if [ -s "$NVM_DIR/bash_completion" ]; then . "$NVM_DIR"/bash_completion; fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
