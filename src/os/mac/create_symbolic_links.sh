#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
  . "../utils.sh"

srcdir="$(cd .. && pwd)"
mkdir -p ~/.local/backups/dotfiles/{configs,home}
backups="~/.local/backups/dotfiles"

if [ ! -f "$HOME/.ncmpcpp/config" ]; then
  mkdir "$HOME/.ncmpcpp"
  ln -sf "$srcdir/config/mpd/ncmpcpp.conf" "$HOME/.ncmpcpp/config"
fi

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
  "bash"
  "dircolors"
  "filezilla"
  "fish"
  "fontconfig"
  "git"
  "mpd"
  "nano"
  "neofetch"
  "neovim"
  "tmux"
  "vim"
  "youtube-dl"
  "zsh"

)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

declare -a LIBRARYFILES_TO_SYMLINK=(
  \
  "Developer/Xcode/UserData/FontAndColorThemes/Dracula.xccolortheme"
  "Preferences/com.googlecode.iterm2.plist"
  "Preferences/.GlobalPreferences.plist"
  "Preferences/com.apple.Terminal.plist"
  "Preferences/com.apple.finder.plist"

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

backup_librarysymlinks() {

  local i=""
  local sourceFile=""
  local targetFile=""
  local skipQuestions=true

  skip_questions "$@" &&
    skipQuestions=true

  for i in "${LIBRARYFILES_TO_SYMLINK[@]}"; do
    sourceFile="$srcdir/Library⁩/$i"
    targetFile="$HOME/Library⁩/$i"
    nameFile="$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

    if [ -f $targetFile ] || [ -d $targetFile ] && [ ! -L $targetFile ]; then
      echo ""
      execute \
        "rsync -aq $targetFile/. $backups/Library⁩/$nameFile >/dev/null 2>&1 || true" \
        "Backing up $targetFile → $backups/Library⁩/$nameFile"
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
    rm -Rfv $targetFile

    if [ ! -e "$targetFile" ]; then

      echo ""
      execute \
        "ln -sf $sourceFile $targetFile" \
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
    rm -Rfv $targetFile

    if [ ! -e "$targetFile" ]; then

      echo ""
      execute \
        "ln -sf $sourceFile $targetFile" \
        "$targetFile → $sourceFile"

    elif [ "$(readlink "$targetFile")" == "$sourceFile" ]; then
      print_success "$targetFile → $sourceFile"

    else
      print_error "$targetFile → $sourceFile"

    fi

  done

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_librarysymlinks() {

  local i=""
  local sourceFile=""
  local targetFile=""
  local skipQuestions=true

  skip_questions "$@" &&
    skipQuestions=true

  for i in "${LIBRARYFILES_TO_SYMLINK[@]}"; do
    sourceFile="$srcdir/Library/$i"
    targetFile="$HOME/Library/$i"
    mkdir -p ${targetFile%/*}
    rm -Rfv $targetFile

    if [ ! -e "$targetFile" ]; then

      echo ""
      execute \
        "ln -sf $sourceFile $targetFile" \
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
  print_in_purple "\n • Backing up Home files\n\n"
  backup_symlinks "$@"

  print_in_purple "\n • Backing up Config Folders\n\n"
  backup_configfolders "$@"

  print_in_purple "\n • Backing up Library Files\n\n"
  backup_librarysymlinks "$@"

  print_in_purple "\n • Installing Home Files\n\n"
  create_configfolders "$@"

  print_in_purple "\n • Installing Config Folders\n\n"
  create_symlinks "$@"

  print_in_purple "\n • Installing Library files\n\n"
  create_librarysymlinks "$@"

}

main "$@"
