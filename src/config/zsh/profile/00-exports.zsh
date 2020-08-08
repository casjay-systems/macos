#!/usr/bin/env zsh

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

## set user mask

#umask 022

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# zsh exports

export ZDOTDIR="$HOME/.config/zsh"
export ZSH_CACHEDIR="$HOME/.cache/oh-my-zsh"
export ZSH="$HOME/.local/share/zsh/oh-my-zsh"
export ZSH_CUSTOM="$HOME/.local/share/zsh/oh-my-zsh/custom"

if (($ + commands[stty])); then
  stty -ixon
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# create dirs

mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/nvm"
mkdir -p "$HOME/.local/log"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Sudo prompt

export SUDO_PROMPT="$(printf "\t\t\033[1;36m")[sudo]$(printf "\033[0m") password for %p: "

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# basher

if [ -d "$HOME/.local/share/bash/basher" ]; then
  export BASHER_ROOT="$HOME/.local/share/bash/basher"
  export PATH="$HOME/.local/share/bash/basher/bin:$PATH"
  if [[ -f "$(command -v basher)" ]]; then
    eval "$(basher init -)"
  fi
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# export gpg tty

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="/run/user/$(id -u)/gnupg/S.gpg-agent.ssh"
eval $(gpg-agent --daemon 2>/dev/null)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Use custom `less` colors for `man` pages.

# Start blinking
export LESS_TERMCAP_mb=$(
  tput bold
  tput setaf 2
) # green
# Start bold
export LESS_TERMCAP_md=$(
  tput bold
  tput setaf 2
) # green
# Start stand out
export LESS_TERMCAP_so=$(
  tput bold
  tput setaf 3
) # yellow
# End standout
export LESS_TERMCAP_se=$(
  tput rmso
  tput sgr0
)
# Start underline
export LESS_TERMCAP_us=$(
  tput smul
  tput bold
  tput setaf 1
) # red
# End Underline
export LESS_TERMCAP_ue=$(tput sgr0)
# End bold, blinking, standout, underline
export LESS_TERMCAP_me=$(tput sgr0)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Don't clear the screen after quitting a `man` page.

export MANPAGER="less -X"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# ensure .gitconfig exists

if [[ -f ~/.config/local/gitconfig.local ]] && [[ ! -f ~/.gitconfig ]]; then
  cp -f ~/.config/local/gitconfig.local ~/.gitconfig
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# add emacs to bin

if [[ -d $HOME/.emacs.d/bin ]]; then
  export PATH="$HOME/.emacs.d/bin:$PATH"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# use vim as editor

export EDITOR="vim"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# set lang

export LANG="en_US"
export LC_ALL="en_US.UTF-8"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# rpm devel

export QA_RPATHS="$((0x0001 | 0x0010))"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# mpd name

export MPDSERVER="$(hostname -s)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# tizonia cloud player config

export TIZONIA_RC_FILE="$HOME/.config/tizonia/tizonia.conf"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# create a banner

export BANNER="echo"
if [[ -n "$(command -v banner 2>/dev/null)" ]]; then
  export BANNER="banner"
elif [[ -n "$(command -v figlet 2>/dev/null)" ]]; then
  export BANNER="figlet -f banner"
elif [[ -n "$(command -v toilet 2>/dev/null)" ]]; then
  export BANNER="toilet -f mono9.tlf"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Ruby Version Manager

if [[ ! -d "$HOME/.local/share/gem/bin" ]]; then
  mkdir -p "$HOME/.local/share/gem/bin"
fi

export GEM_HOME="$HOME/.local/share/gem"
export rvm_ignore_gemrc_issues=1
export rvm_silence_path_mismatch_check_flag=1

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# node version manager

export NODE_REPL_HISTORY_SIZE=10000
export NVM_DIR="$HOME/.local/share/nvm"
if [[ ! -d $HOME/.local/share/nvm ]]; then mkdir -p $HOME/.local/share/nvm; fi
if [[ -s "$NVM_DIR/nvm.sh" ]]; then source "$NVM_DIR/nvm.sh"; fi
if [[ -s "$NVM_DIR/bash_completion" ]]; then source "$NVM_DIR"/bash_completion; fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# export browser

if [[ -z "$BROWSER" ]]; then
  if [[ -f "$(command -v garcon-url-handler 2>/dev/null)" ]]; then
    export BROWSER="$(command -v garcon-url-handler) --url $@"
  elif [[ -f "$(command -v firefox 2>/dev/null)" ]]; then
    export BROWSER="$(command -v firefox 2>/dev/null)"
  elif [[ -f "$(command -v chromium 2>/dev/null)" ]]; then
    export BROWSER="$(command -v chromium 2>/dev/null)"
  elif [[ -f "$(command -v google-chrome 2>/dev/null)" ]]; then
    export BROWSER="$(command -v google-chrome 2>/dev/null)"
  elif [[ -f "(command -v opera)" ]]; then
    export BROWSER="(command -v opera)"
  elif [[ -f "$(command -v epiphany-browser 2>/dev/null)" ]]; then
    export BROWSER="(command -v epiphany-browser)"
  elif [[ -f "$(command -v falkon 2>/dev/null)" ]]; then
    export BROWSER="(command -v falkon)"
  elif [[ -f "$(command -v midori 2>/dev/null)" ]]; then
    export BROWSER="(command -v midori)"
  elif [[ -f "$(command -v netsurf 2>/dev/null)" ]]; then
    export BROWSER="(command -v netsurf)"
  elif [[ -f "$(command -v surf 2>/dev/null)" ]]; then
    export BROWSER="(command -v surf)"
  elif [[ -f "$(command -v arora 2>/dev/null)" ]]; then
    export BROWSER="(command -v arora)"
  elif [[ -f "$(command -v lynx 2>/dev/null)" ]]; then
    export BROWSER="(command -v lynx)"
  fi
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# export terminal

if [[ -z "$TERMINAL" ]]; then
  if [[ -f "$(command -v termite 2>/dev/null)" ]]; then
    TERMINAL="$(command -v termite 2>/dev/null)"
  elif [[ -f "$(command -v terminology 2>/dev/null)" ]]; then
    TERMINAL="$(command -v terminology 2>/dev/null)"
  elif [[ -f "$(command -v xfce4-terminal 2>/dev/null)" ]]; then
    TERMINAL="$(command -v xfce4-terminal 2>/dev/null)"
  elif [[ -f "$(command -v qterminal-terminal 2>/dev/null)" ]]; then
    TERMINAL="$(command -v qterminal-terminal 2>/dev/null)"
  elif [[ -f "$(command -v qterminal-terminal 2>/dev/null)" ]]; then
    TERMINAL="$(command -v qterminal-terminal 2>/dev/null)"
  elif [[ -f "$(command -v xterm 2>/dev/null)" ]]; then
    TERMINAL="$(command -v xterm 2>/dev/null)"
  elif [[ -f "$(command -v uxterm 2>/dev/null)" ]]; then
    TERMINAL="$(command -v uxterm 2>/dev/null)"
  fi
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# export color

if [[ "$OSTYPE" = darwin* ]]; then
  LSCOLORS=DxgxcxdxCxegedabagacad
  export LSCOLORS
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# xdg

#export XDG_DATA_DIRS="${XDG_DATA_DIRS}"
#export XDG_CONFIG_HOME="$HOME/.config"
#export XDG_CACHE_HOME="$HOME/.cache"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# set term type

export TERM=screen-256color

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Setting the temp directory for vim

if [[ -z $TEMP ]]; then export TEMP=/tmp; fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# logging

export LOGDIR="$HOME/.local/log"
export DEFAULT_LOG_DIR="$LOGDIR"
export DEFAULT_LOG="scripts"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Update Path

# set PATH so it includes user's private bin if it exists
if [[ -d "$HOME"/.local/bin ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

if [[ -d "$HOME"/.local/share/scripts/bin ]]; then
  export PATH="$HOME/.local/share/scripts/bin:$PATH"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# export vdpau driver

if [ ! -z "$VDPAU_DRIVER" ]; then
  export VDPAU_DRIVER=va_gl
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# passmgr default settings - copy to your bash.local and change for your setup

if [[ -f "$HOME/.config/secure/passmgr.txt" ]]; then
  source "$HOME/.config/secure/passmgr.txt"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# github default settings - copy to your bash.local and change for your setup

if [[ -f "$HOME/.config/secure/github.txt" ]]; then
  source "$HOME/.config/secure/github.txt"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# gitlab default settings - copy to your bash.local and change for your setup

if [[ -f "$HOME/.config/secure/gitlab.txt" ]]; then
  source "$HOME/.config/secure/gitlab.txt"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# your private git - copy to your bash.local and change for your setup

if [[ -f "$HOME/.config/secure/gitpriv.txt" ]]; then
  source "$HOME/.config/secure/gitpriv.txt"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Dotfiles base repo  - copy to your bash.local and change for your setup

if [[ -f "$HOME/.config/secure/personal.txt" ]]; then
  source "$HOME/.config/secure/personal.txt"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# APIKEYS  - copy to your bash.local and change for your setup

if [[ -f "$HOME/.config/secure/apikeys.txt" ]]; then
  source "$HOME/.config/secure/apikeys.txt"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# cursor

#echo -e -n "\x6b[\x35 q"
#echo -e -n "\e]12;white \a"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# set variable for other scripts

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
