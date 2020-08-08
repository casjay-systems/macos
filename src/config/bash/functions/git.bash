#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : git.bash
# @Created     : Mon, Dec 31, 2019, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : functions for git
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set functions

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#Git Functions

get_git_repository_details() {
  local branchName=""
  local tmp=""
  ! git rev-parse &>/dev/null && return
  [ "$(git rev-parse --is-inside-git-dir)" == "true" ] && return

  if ! git diff --quiet --ignore-submodules --cached; then tmp="$tmp+"; fi
  if ! git diff-files --quiet --ignore-submodules --; then tmp="$tmp!"; fi
  if [ -n "$(git ls-files --others --exclude-standard)" ]; then tmp="$tmp?"; fi
  if git rev-parse --verify refs/stash &>/dev/null; then tmp="$tmp$"; fi
  [ -n "$tmp" ] && tmp=" [$tmp]"

  branchName="$(printf "%s" "$(git rev-parse --abbrev-ref HEAD 2>/dev/null ||
    git rev-parse --short HEAD 2>/dev/null ||
    printf " (unknown)")" | tr -d "\n")"
  printf "%s" "$1$branchName$tmp"
}

if ! cmd_exists gitreinit; then
  gitreinit() {
    oldpwd="$(pwd)"
    gitdir="$(echo $(git rev-parse --git-dir 2>/dev/null)/..)"
    repo="$(git remote -v | grep fetch | head -n 1 | awk '{print $2}' 2>/dev/null)"

    if [ ! -d "$gitdir" ]; then
      printf_exit "Not a git repo"
      exit 1
    else
      cd $gitdir
    fi

    printf_red "
         This is an extreme measure....
         Make sure you do a git pull before doing this.
         Press Control C to cancel...\n" && sleep 10 &&
      devnull rm -Rf .git &&
      [ -f gitmasterconfig ] && [ -d .git ] &&
      cp -f gitmasterconfig .git/config
    devnull git init -q &&
      devnull git add -q . &&
      git commit -q -S -m "Initial Commit"
    getexitcode "Reinit completed\n"
    cd $oldpwd
  }
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if ! cmd_exists gitcommit; then
  gitcommit() {
    [ "$1" = "-m" ] || [ "$1" = "--mess" ] || [ "$1" = "--message" ] &&
      shift 1 && MESSAGE="$1" && shift

    case "$MESSAGE" in
    tomany)
      shift 1
      mess=" 🦈🏠🐜 Fixes and Updates 🐜🦈🏠 "
      ;;
    docker)
      shift 1
      mess=" 🐜 Added Docker Workflow 🐜 "
      ;;
    node)
      shift 1
      mess=" 🐜 Added nodejs Workflow 🐜 "
      ;;
    ruby)
      shift 1
      mess=" 🐜 Added ruby Workflow 🐜 "
      ;;
    php)
      shift 1
      mess=" 🐜 Added php Workflow 🐜 "
      ;;
    perl)
      shift 1
      mess=" 🐜 Added perl Workflow 🐜 "
      ;;
    python)
      shift 1
      mess=" 🐜 Added python Workflow 🐜 "
      ;;
    bug)
      shift 1
      mess=" 🐛 Bug fixes 🐛 "
      ;;
    fixes)
      shift 1
      mess=" ❇ fixes ❇ "
      ;;
    add)
      shift 1
      mess="$1"
      shift 1
      ;;
    *)
      shift 1
      mess=" 😉 fixes 😉 "
      ;;
    esac

    oldpwd="$(pwd)"
    gitdir="$(echo $(git rev-parse --git-dir 2>/dev/null)/..)"
    repo="$(git remote -v | grep fetch | head -n 1 | awk '{print $2}' 2>/dev/null)"
    [ ! -z "$repo" ] || repo="localdir"

    if [ ! -d "$gitdir" ]; then
      printf_exit "Not a git repo"
      exit 1
    else
      cd $gitdir
    fi

    printf_warning "Commiting Changes with $mess" &&
      [ "$repo" != "localdir" ] ||
      devnull git pull -q 2>/dev/null ||
      printf_exit "Failed to pull"

    date +"%m%d%Y%H%M-git" >version.txt &&
      [ -f gitmasterconfig ] && [ -d .git ] &&
      cp -f gitmasterconfig .git/config
    devnull git add . &&
      [ "$1" ] &&
      git commit -q -S "$1" "$2" 2>/dev/null ||
      git commit -q -S -m " 🦈🏠🐜 Fixes and Updates 🐜🦈🏠 " 2>/dev/null &&
      [ "$repo" = "localdir" ] || devnull git push -q 2>/dev/null ||
      [ "$repo" = "localdir" ] || devnull git push -q 2>/dev/null
    getexitcode "Successfully pushed to \n\t\t$repo"
    cd $oldpwd

  }
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if ! cmd_exists gitup; then
  gitup() {
    oldpwd="$(pwd)"
    gitdir="$(echo $(git rev-parse --git-dir 2>/dev/null)/..)"
    repo="$(git remote -v | grep fetch | head -n 1 | awk '{print $2}' 2>/dev/null)"

    if [ ! -d "$gitdir" ]; then
      printf_exit "This does not seem to be a git repo"
      exit 1
    else
      cd $gitdir
    fi

    printf_warning "Commiting Changes" &&
      devnull git pull -q ||
      printf_exit "Failed to pull" &&
      date +"%m%d%Y%H%M-git" >version.txt &&
      [ -f gitmasterconfig ] && [ -d .git ] &&
      cp -f gitmasterconfig .git/config
    devnull git add . &&
      [ "$1" ] &&
      git commit -q -S "$1" "$2" ||
      git commit -q -S -m " 🦈🏠🐜 Fixes and Updates 🐜🦈🏠 " &&
      devnull git push -q || devnull git push -q
    getexitcode "Successfully pushed to \n\t\t$repo"
    cd $oldpwd
  }
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if ! cmd_exists gitpu; then
  gitpu() {
    oldpwd="$(pwd)"
    gitdir="$(echo $(git rev-parse --git-dir 2>/dev/null)/..)"
    repo="$(git remote -v | grep fetch | head -n 1 | awk '{print $2}' 2>/dev/null)"

    if [ ! -d "$gitdir" ]; then
      printf_exit "Not a git repo"
      exit 1
    else
      cd $gitdir
    fi

    printf_warning "Pulling changes from remote" &&
      devnull git pull -q || exit 1
    [ -f gitmasterconfig ] && [ -d .git ] &&
      cp -f gitmasterconfig .git/config || true
    getexitcode "Successfully pulled from \n\t\t$repo\n"
    cd $oldpwd
  }
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#Git add github remote
gitremoteaddgh() {
  git remote add origin https://github.com/"$1"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#Git remove github remote
gitremoteremgh() {
  git remote rm https://github.com/"$1"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#Git add gitlab remote
gitremoteaddgl() {
  git remote add origin https://gitlab.com/"$1"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#Git remove gitlab remote
gitremoteremgl() {
  git remote rm https://gitlab.com/"$1"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#Git add private remote
gitremoteaddpr() {
  local GITPRIVATE=${GITPRIVATEREPO:-https://git.casjay.in}
  git remote add origin "$GITPRIVATEREPO"/"$1"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#Git remove private remote
gitremoterempr() {
  local GITPRIVATE=${GITPRIVATEREPO:-https://git.casjay.in}
  git remote rm "$GITPRIVATEREPO"/"$1"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# vi: ts=4 noai
