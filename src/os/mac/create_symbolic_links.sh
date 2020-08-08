#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
  . "../utils.sh"

srcdir="$(cd .. && pwd)"
mkdir -p ~/.local/backups/dotfiles/{configs,home}
backups="~/.local/backups/dotfiles"
mkdir -p "$HOME/.ncmpcpp"
ln -sf "$HOME/.config/mpd/ncmpcpp.conf" "$HOME/.ncmpcpp/config"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

declare -a FILES_TO_SYMLINK=(
  \
  "config/bash/bash_logout"
  "config/bash/bash_profile"
  "config/bash/bashrc"
  "shell/curlrc"
  "shell/dircolors"
  "shell/inputrc"
  "shell/profile"
  "shell/screenrc"

)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

declare -a CONFFOLDERS_TO_SYMLINK=(
  \
  "$(ls -d config/)"

)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

declare -a CONFFILES_TO_SYMLINK=(
  \
  "Preferences/com.googlecode.iterm2.plist"

)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

backup_symlinks() {

  local i=""
  local sourceFile=""
  local targetFile=""
  local skipQuestions=true

  skip_questions "$@" &&
    skipQuestions=true

  for i in "${FILES_TO_SYMLINK[@]}"; do
    sourceFile="$srcdir/$i"
    targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"
    nameFile="$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

    if [ -f $targetFile ] && [ ! -L $targetFile ]; then

      echo ""
      execute \
        "rsync -aq $targetFile/. $backups/home/$nameFile >/dev/null 2>&1 || true" \
        "Backing up $targetFile  →  $backups/home/$nameFile"
    fi

  done

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

backup_configfolders() {

  local i=""
  local sourceFile=""
  local targetFile=""
  local skipQuestions=true

  skip_questions "$@" &&
    skipQuestions=true

  for i in "${CONFFOLDERS_TO_SYMLINK[@]}"; do
    sourceFile="$srcdir/config/$i"
    targetFile="$HOME/.config/$i"
    nameFile="$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

    if [ -f $targetFile ] && [ ! -L $targetFile ]; then

      echo ""
      execute \
        "rsync -aq $targetFile/. $backups/config/$nameFile >/dev/null 2>&1 || true" \
        "Backing up $targetFile  →  $backups/config/$nameFile"
    fi

  done

}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

backup_confsymlinks() {

  local i=""
  local sourceFile=""
  local targetFile=""
  local skipQuestions=true

  skip_questions "$@" &&
    skipQuestions=true

  for i in "${CONFFILES_TO_SYMLINK[@]}"; do
    sourceFile="$srcdir/Library⁩/$i"
    targetFile="$HOME/Library⁩/$i"
    nameFile="$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

    if [ -f $targetFile ] || [ -d $targetFile ] && [ ! -L $targetFile ]; then

      echo ""
      execute \
        "rsync -aq $targetFile/. $backups/configs/$nameFile >/dev/null 2>&1 || true" \
        "Backing up $targetFile → $backups/configs/$nameFile"
    fi

  done

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_symlinks() {

  local i=""
  local sourceFile=""
  local targetFile=""
  local skipQuestions=true

  skip_questions "$@" &&
    skipQuestions=true

  for i in "${FILES_TO_SYMLINK[@]}"; do
    sourceFile="$srcdir/$i"
    targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

    if [ ! -e "$targetFile" ]; then
      rm -Rf $targetFile
      echo ""
      execute \
        "ln -fs $sourceFile $targetFile" \
        "$targetFile → $sourceFile"

    elif [ "$(readlink "$targetFile")" == "$sourceFile" ]; then
      print_success "$targetFile → $sourceFile"

    else
      print_error "$targetFile → $sourceFile"

    fi

  done

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_configfolders() {

  local i=""
  local sourceFile=""
  local targetFile=""
  local skipQuestions=true

  skip_questions "$@" &&
    skipQuestions=true

  for i in "${CONFFOLDERS_TO_SYMLINK[@]}"; do
    sourceFile="$srcdir/config/$i"
    targetFile="$HOME/.config/$i"

    if [ ! -e "$targetFile" ]; then
      rm -Rf $targetFile
      echo ""
      execute \
        "ln -fs $sourceFile $targetFile" \
        "$targetFile → $sourceFile"

    elif [ "$(readlink "$targetFile")" == "$sourceFile" ]; then
      print_success "$targetFile → $sourceFile"

    else
      print_error "$targetFile → $sourceFile"

    fi

  done

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_confsymlinks() {

  local i=""
  local sourceFile=""
  local targetFile=""
  local skipQuestions=true

  skip_questions "$@" &&
    skipQuestions=true

  for i in "${CONFFILES_TO_SYMLINK[@]}"; do
    sourceFile="$srcdir/Library/$i"
    targetFile="$HOME/Library/$i"

    if [ ! -e "$targetFile" ]; then
      rm -Rf $targetFile
      echo ""
      execute \
        "ln -fs $sourceFile $targetFile" \
        "$targetFile → $sourceFile"

    elif [ "$(readlink "$targetFile")" == "$sourceFile" ]; then
      print_success "$targetFile → $sourceFile"

    else
      print_error "$targetFile → $sourceFile"

    fi

  done

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  backup_symlinks "$@"

  backup_configfolders "$@"

  backup_confsymlinks "$@"

  create_configfolders "$@"

  create_symlinks "$@"

  create_confsymlinks "$@"

}

main "$@"
