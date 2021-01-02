#!/usr/bin/env bash

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#Powerline check
if [ "$POWERLINE" ]; then

  #Debian/Ubuntu/Arch
  if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then
    source /usr/share/powerline/bindings/bash/powerline.sh
  fi

  #Redhat/CentOS
  if [ -f /usr/share/powerline/bash/powerline.sh ]; then
    source /usr/share/powerline/bash/powerline.sh
  fi

  #MacOS
  if [ -f /usr/local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh ]; then
    source /usr/local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh
  fi

  powerline-daemon -q
  export POWERLINE_BASH_CONTINUATION=1
  export POWERLINE_BASH_SELECT=1
fi

# Borrowed and customized from https://github.com/riobard/bash-powerline

bashprompt() {
  function __tput() { tput $* 2>/dev/null; }

  # Unicode symbols
  PS_SYMBOL_DARWIN=' 🍎 ' 2>/dev/null
  PS_SYMBOL_LINUX=' 🐧 ' >/dev/null
  PS_SYMBOL_WIN=' 😥 ' >/dev/null
  PS_SYMBOL_OTHER=' 👽 ' 2>/dev/null
  GIT_BRANCH_SYMBOL=' 🎆 ' 2>/dev/null
  GIT_BRANCH_CHANGED_SYMBOL=' 🌲 ' 2>/dev/null
  GIT_NEED_PUSH_SYMBOL=' 🔼 ' 2>/dev/null
  GIT_NEED_PULL_SYMBOL=' 🔽 ' 2>/dev/null
  RUBY_SYMBOL=' ☢️ ' 2>/dev/null
  NODE_SYMBOL=' 🔥 ' 2>/dev/null
  PYTHON_SYMBOL=' 🐍 ' 2>/dev/null
  PHP_SYMBOL=' ♻️ ' 2>/dev/null

  FG_BLACK="\[$(__tput setaf 0 2>/dev/null)\]"
  FG_GRAY1="\[$(__tput setaf 15 2>/dev/null)\]"
  FG_GRAY2="\[$(__tput setaf 7 2>/dev/null)\]"
  FG_GRAY3="\[$(__tput setaf 8 2>/dev/null)\]"
  FG_RED="\[$(__tput setaf 9 2>/dev/null)\]"
  FG_GREEN="\[$(__tput setaf 10 2>/dev/null)\]"
  FG_YELLOW="\[$(__tput setaf 11 2>/dev/null)\]"
  FG_BLUE="\[$(__tput setaf 12 2>/dev/null)\]"
  FG_MAGENTA="\[$(__tput setaf 13 2>/dev/null)\]"
  FG_CYAN="\[$(__tput setaf 14 2>/dev/null)\]"
  FG_DARK_RED="\[$(__tput setaf 1 2>/dev/null)\]"
  FG_DARK_GREEN="\[$(__tput setaf 2 2>/dev/null)\]"
  FG_MUSTARD="\[$(__tput setaf 3 2>/dev/null)\]"
  FG_NAVY="\[$(__tput setaf 4 2>/dev/null)\]"
  FG_PURPLE="\[$(__tput setaf 5 2>/dev/null)\]"
  FG_TURQUOISE="\[$(__tput setaf 6 2>/dev/null)\]"

  BG_BLACK="\[$(__tput setab 0 2>/dev/null)\]"
  BG_GRAY1="\[$(__tput setab 15 2>/dev/null)\]"
  BG_GRAY2="\[$(__tput setab 7 2>/dev/null)\]"
  BG_GRAY3="\[$(__tput setab 8 2>/dev/null)\]"
  BG_RED="\[$(__tput setab 9 2>/dev/null)\]"
  BG_GREEN="\[$(__tput setab 10 2>/dev/null)\]"
  BG_YELLOW="\[$(__tput setab 11 2>/dev/null)\]"
  BG_BLUE="\[$(__tput setab 12 2>/dev/null)\]"
  BG_MAGENTA="\[$(__tput setab 13 2>/dev/null)\]"
  BG_CYAN="\[$(__tput setab 14 2>/dev/null)\]"
  BG_DARK_RED="\[$(__tput setab 1 2>/dev/null)\]"
  BG_DARK_GREEN="\[$(__tput setab 2 2>/dev/null)\]"
  BG_MUSTARD="\[$(__tput setab 3 2>/dev/null)\]"
  BG_NAVY="\[$(__tput setab 4 2>/dev/null)\]"
  BG_PURPLE="\[$(__tput setab 5 2>/dev/null)\]"
  BG_TURQUOISE="\[$(__tput setab 6 2>/dev/null)\]"
  BG_DEEP_GREEN="\[$(__tput setab 22 2>/dev/null)\]"
  DIM="\[$(__tput dim 2>/dev/null)\]"
  REVERSE="\[$(__tput rev 2>/dev/null)\]"
  RESET="\[$(__tput sgr0 2>/dev/null)\]"
  BOLD="\[$(__tput bold 2>/dev/null)\]"

  # what OS?
  case "$(uname)" in
  Darwin)
    PS_SYMBOL=$PS_SYMBOL_DARWIN
    ;;
  Linux)
    PS_SYMBOL=$PS_SYMBOL_LINUX
    ;;
  msys* | Win* | MINGW* | CYGWIN*)
    PS_SYMBOL=$PS_SYMBOL_WIN
    ;;
  *)
    PS_SYMBOL=$PS_SYMBOL_OTHER
    ;;
  esac

  if [ -f "$HOME/.noprompt" ]; then
    __ifphp() { true; }
    __php_info() { true; }
    __ifruby() { true; }
    __ruby_info() { true; }
    __ifnode() { true; }
    __node_info() { true; }
    __ifpython() { true; }
    __python_info() { true; }
  else
    ### Ruby #######################################################
    __ifruby() {
      if [ $(ls *.rb 2>/dev/null | wc -l) -ne 0 ] || [ "$(ls $(git rev-parse --show-toplevel 2>/dev/null)/*.rb | wc -l)" -ne 0 ]; then
        if [ $(command -v rbenv 2>/dev/null) ]; then
          __ruby_version() { printf "RBENV: $(rbenv version-name)"; }
        elif [ $(command -v rvm 2>/dev/null) ] && [ "$(rvm version | awk '{print $2}')" ]; then
          __ruby_version() { printf "RVM: $(rvm current)"; }
        elif [ $(command -v ruby 2>/dev/null) ]; then
          __ruby_version() { printf "Ruby: $(ruby --version | cut -d' ' -f2)"; }
        else
          __ruby_version() { return; }
        fi

        __ruby_info() {
          local version=$(__ruby_version)
          [ -z "${version}" ] && return
          printf " ${version}$RUBY_SYMBOL $RESET"
        }
      else
        __ruby_info() { return; }
      fi
    }

    ### Node.js ####################################################
    __ifnode() {
      if [[ "$(ls $(git rev-parse --show-toplevel 2>/dev/null)/package*.json *.js package*.json 2>/dev/null | wc -l)" -ne 0 ]]; then
        if [[ -f "$NVM_DIR/nvm.sh" ]] && [[ "$(command -v nvm_ls_current 2>/dev/null)" ]] && [[ $(nvm_version | grep -qv "N/A" >/dev/null 2>&1) ]]; then
          __node_version() { printf "$(node --version)"; }
          __node_info() {
            local version="$(__node_version)"
            [ -z "${version}" ] && return
            printf " NVM: ${version}$NODE_SYMBOL$RESET"
          }

        elif [[ -n "$(command -v fnm)" ]]; then
          __node_version() { printf "$(node --version)"; }
          __node_info() {
            local version="$(__node_version)"
            [ -z "${version}" ] && return
            printf " FNM: ${version}$NODE_SYMBOL$RESET"
          }

        elif [[ -n "$(command -v node)" ]]; then
          __node_version() { printf "$(node --version)"; }
          __node_info() {
            local version="$(__node_version)"
            [ -z "${version}" ] && return
            printf " Node: ${version}$NODE_SYMBOL$RESET"
          }
        fi
      else
        __node_version() { return; }
        __node_info() { return; }
      fi
    }

    ### python ####################################################
    __ifpython() {
      if [[ -n "$VIRTUAL_ENV" ]] && [[ $(ls $VIRTUAL_ENV/pyvenv.cfg 2>/dev/null | wc -l) -ne 0 ]] || [[ $(ls ./pyvenv.cfg 2>/dev/null | wc -l) -ne 0 ]]; then
        __python_info() {
          PYTHON_VERSION="$($(command -v python3) --version | sed 's#Python ##g')"
          PYTHON_VIRTUALENV="$(basename "$VIRTUAL_ENV")"
          if [ -n "$PYTHON_VIRTUALENV" ]; then
            printf " $PYTHON_VIRTUALENV: $PYTHON_VERSION$PYTHON_SYMBOL$RESET"
          else
            printf " VENV: $PYTHON_VERSION$PYTHON_SYMBOL$RESET"
          fi
        }
      elif [ -n "$(command -v python3)" ] && [ "$(ls $(git rev-parse --show-toplevel 2>/dev/null)/*.py* | wc -l)" -ne 0 ] || [ $(ls *.py *.pyc 2>/dev/null | wc -l) -ne 0 ]; then
        __python_info() {
          PYTHON_VERSION="$($(command -v python3) --version | sed 's#Python ##g')"
          printf " Python: $PYTHON_VERSION$PYTHON_SYMBOL$RESET"
        }
      elif [ -n "$(command -v python2)" ] && [ "$(ls $(git rev-parse --show-toplevel 2>/dev/null)/*.py* | wc -l)" -ne 0 ] || [ $(ls *.py *.pyc 2>/dev/null | wc -l) -ne 0 ]; then
        __python_info() {
          PYTHON_VERSION="$($(command -v python2) --version | sed 's#Python ##g')"
          printf " Python: $PYTHON_VERSION$PYTHON_SYMBOL$RESET"
        }
      else
        __python_info() { return; }
      fi
    }

    ### php ####################################################
    __ifphp() {
      if [[ $(ls *.php* 2>/dev/null | wc -l) -ne 0 ]] || [ "$(ls $(git rev-parse --show-toplevel 2>/dev/null)/*.php | wc -l)" -ne 0 ]; then
        if [ $(command -v php 2>/dev/null) ]; then
          __php_version() { printf $(php --version | awk '{print $2}' | head -n 1); }
        else
          __php_version() { return; }
        fi
        __php_info() {
          local version=$(__php_version)
          [ -z "$version" ] && return
          printf " PHP: $version $BG_GRAY1 $PHP_SYMBOL$RESET"
        }
      else
        __php_info() { return; }
      fi

    }
  fi

  ### Git ########################################################
  __ifgit() {
    if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" == "true" ]; then
      __git_version() { printf " Git $(git --version | awk '{print $3}' | head -n 1)"; }
      __git_status() {
        local git_eng="env LANG=C git" # force git output in English to make our work easier
        local branch="$($git_eng symbolic-ref --short HEAD 2>/dev/null || $git_eng describe --tags --always 2>/dev/null)"
        [ -n "$branch" ] || return # git branch not found
        local marks
        [ -n "$($git_eng status --porcelain)" ] && marks+="$GIT_BRANCH_CHANGED_SYMBOL"
        local stat="$($git_eng status --porcelain --branch | grep '^##' | grep -o '\[.\+\]$')"
        local aheadN="$(echo $stat | grep -o 'ahead [[:digit:]]\+' | grep -o '[[:digit:]]\+')"
        local behindN="$(echo $stat | grep -o 'behind [[:digit:]]\+' | grep -o '[[:digit:]]\+')"
        [ -n "$aheadN" ] && marks+="$GIT_NEED_PUSH_SYMBOL$aheadN"
        [ -n "$behindN" ] && marks+="$GIT_NEED_PULL_SYMBOL$behindN"
        printf " [$branch]$marks"
      }
      __git_info() {
        __git_version && __git_status && printf "$GIT_BRANCH_SYMBOL"
      }
    else
      __git_version() { return; }
      __git_info() { return; }
    fi
  }

  ### PROMPT #####################################################
  __title_info() { echo -ne "${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}"; }

  case $TERM in
  *-256color)
    title() { echo -ne "\033]0;$(__title_info)\007"; }
    ;;
  xterm* | rxvt* | Eterm | aterm | kterm | gnome* | konsole | xfce4-terminal* | putty*)
    title() { echo -ne "\033]0;$(__title_info)\007"; }
    ;;
  screen*)
    title() { echo -ne "\033]0;$(__title_info)\007"; }
    ;;
  *)
    title() { echo -ne "\033]0;$(__title_info)\007"; }
    ;;
  esac

  ps1() {
    # Check the exit code of the previous command and display different
    # colors in the prompt accordingly.
    if [ $? -eq 0 ]; then
      local BG_EXIT="$BG_DARK_GREEN"
      local PS_SYMBOL="$PS_SYMBOL"
    else
      local BG_EXIT="$BG_RED"
      local PS_SYMBOL=" 😔 "
    fi

    PS_LINE="$(printf -- '%.0s' {4..2000})"
    PS_FILL="${PS_LINE:0:$COLUMNS}"
    PS_TIME="\[\033[\$((COLUMNS-10))G\]$RESET$BG_PURPLE$FG_BLACK[\t]$RESET"

    PS1="\${PS_FILL}\[\033[0G\]$RESET"
    PS1+="$BG_BLUE$FG_BLACK \s: \v $RESET"
    [ -n "$(command -v php 2>/dev/null)" ] && PS1+="$BG_PURPLE$FG_GRAY1$(__ifphp && __php_info)$RESET"
    [ -n "$(command -v ruby 2>/dev/null)" ] && PS1+="$BG_DARK_RED$FG_GRAY1$(__ifruby && __ruby_info)$RESET"
    [ -n "$(command -v node 2>/dev/null)" ] && PS1+="$BG_DEEP_GREEN$FG_GRAY1$(__ifnode && __node_info)$RESET"
    [ -n "$(command -v python 2>/dev/null)" ] && PS1+="$BG_RED$FG_BLACK$(__ifpython && __python_info)$RESET"
    [ -n "$(command -v git 2>/dev/null)" ] && PS1+="$BG_CYAN$FG_BLACK$(__ifgit && __git_info)$RESET"
    PS1+="$BG_PURPLE$FG_BLACK${PS_TIME}$RESET "
    PS1+="$BG_GRAY2$FG_BLACK \u@\H:$BG_DARK_GREEN\w$RESET \n"
    PS1+="$BG_EXIT$FG_BLACK Jobs: [\j]$BG_GRAY2$PS_SYMBOL$RESET"

  }

  PROMPT_COMMAND="ps1 && title && history -a && history -r "

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # ------------------------------------------------------------------
  # | PS2 - Continuation interactive prompt                          |
  # ------------------------------------------------------------------

  PS2="⚡ "

  export PS2

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # ------------------------------------------------------------------
  # | PS4 - debug interactive prompt                          |
  # ------------------------------------------------------------------

  PS4="$(
    tput cr 2>/dev/null
    tput cuf 6 2>/dev/null
    printf "${GREEN}+%s ($LINENO) +" " $RESET"
  )"

  export PS4

}

bashprompt 2>/dev/null
