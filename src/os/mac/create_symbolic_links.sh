#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" && . "../utils.sh"
srcdir="$(cd .. && pwd)"
backups="${backupsdir:-$HOME/.local/backups/os}"
mkdir -p "$backups"/{configs,home}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ ! -f "$HOME/.ncmpcpp/config" ] && [ -f "$srcdir/config/mpd/ncmpcpp.conf" ]; then
  mkdir "$HOME/.ncmpcpp"
  ln -sf "$srcdir/config/mpd/ncmpcpp.conf" "$HOME/.ncmpcpp/config"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
declare -a FILES_TO_SYMLINK=(
  # "config/bash/bash_logout"
  # "config/bash/bash_profile"
  # "config/bash/bashrc"
  # "shell/curlrc"
  # "shell/dircolors"
  # "shell/inputrc"
  # "shell/profile"
  # "shell/screenrc"
  # "shell/wgetrc"
  "shell/face"
)
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
declare -a CONFFOLDERS_TO_SYMLINK=(
  # "bash"
  # "dircolors"
  # "filezilla"
  # "fish"
  # "fontconfig"
  # "git"
  # "mpd"
  # "nano"
  # "neofetch"
  # "neovim"
  # "tmux"
  # "vim"
  # "youtube-dl"
  # "zsh"
)
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
declare -a LIBRARYFILES_TO_SYMLINK=(
  "Developer/Xcode/UserData/FontAndColorThemes/Dracula.xccolortheme"
  "Preferences/com.apple.systempreferences.plist"
  "Preferences/com.googlecode.iterm2.plist"
  "Preferences/.GlobalPreferences.plist"
  "Preferences/com.apple.Terminal.plist"
  "Preferences/com.apple.finder.plist"
  "Preferences/org.m0k.transmission.plist"
)
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
backup_symlinks() {
  local i=""
  local sourceFile=""
  local targetFile=""
  local skipQuestions=true
  skip_questions "$@" && skipQuestions=true
  for i in "${FILES_TO_SYMLINK[@]}"; do
    sourceFile="$srcdir/$i"
    targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"
    nameFile="$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"
    if [ -f "$targetFile" ] && [ ! -L "$targetFile" ] && [ -e "$sourceFile" ]; then
      execute \
        "mv -f $targetFile $backups/home/$nameFile" \
        "Backing up $targetFile  →  $backups/home/$nameFile"
    fi
  done
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
backup_confsymlinks() {
  local i=""
  local sourceFile=""
  local targetFile=""
  local skipQuestions=true
  skip_questions "$@" && skipQuestions=true
  for i in "${CONFFOLDERS_TO_SYMLINK[@]}"; do
    sourceFile="$srcdir/config/$i"
    targetFile="$HOME/.config/$i"
    nameFile="$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"
    if [ -f "$targetFile" ] || [ -d "$targetFile" ] && [ ! -L "$targetFile" ] && [ ! -f "$srcdir/config/$i/install.sh" ] && [ -e "$sourceFile" ]; then
      execute \
        "mv -f $targetFile $backups/home/config/$nameFile" \
        "Backing up $targetFile → $backups/home/config/$nameFile"
    fi
  done
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
backup_librarysymlinks() {
  local i=""
  local sourceFile=""
  local targetFile=""
  local skipQuestions=true
  skip_questions "$@" && skipQuestions=true
  for i in "${LIBRARYFILES_TO_SYMLINK[@]}"; do
    sourceFile="$srcdir/Library⁩/$i"
    targetFile="$HOME/Library⁩/$i"
    nameFile="$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"
    if [ -f "$targetFile" ] || [ -d "$targetFile" ] && [ ! -L "$targetFile" ]; then
      execute \
        "rsync -aq $targetFile/. $backups/home/Library⁩/$nameFile >/dev/null 2>&1 || true" \
        "Backing up $targetFile → $backups/home/Library⁩/$nameFile"
    fi
  done
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
create_symlinks() {
  setup() {
    unlink "$targetFile" 2>/dev/null || rm -Rf "$targetFile" 2>/dev/null
    ln -sf "$sourceFile" "$targetFile"
  }
  print_in_purple "\n   • Create file symlinks\n"
  local i=""
  local sourceFile=""
  local targetFile=""
  local skipQuestions=true
  skip_questions "$@" && skipQuestions=true
  for i in "${FILES_TO_SYMLINK[@]}"; do
    sourceFile="$srcdir/$i"
    targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"
    if [ -e "$sourceFile" ]; then
      execute \
        "ln -fs $sourceFile $targetFile" \
        "$targetFile → $sourceFile"
    fi
  done
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
create_confsymlinks() {
  setup() {
    unlink "$targetFile" 2>/dev/null || rm -Rf "$targetFile" 2>/dev/null
    ln -sf "$sourceFile" "$targetFile"
  }
  print_in_purple "\n   • Create config symlinks\n"
  local i=""
  local sourceFile=""
  local targetFile=""
  local skipQuestions=true
  skip_questions "$@" && skipQuestions=true
  for i in "${CONFFOLDERS_TO_SYMLINK[@]}"; do
    sourceFile="$srcdir/config/$i"
    targetFile="$HOME/.config/$i"
    if [ -e "$sourceFile" ]; then
      execute \
        "setup" \
        "$targetFile → $sourceFile"
    fi
  done
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
create_librarysymlinks() {
  if [[ "$OSTYPE" =~ ^darwin ]]; then
    print_in_purple "\n   • Create library symlinks\n"
    local i=""
    local sourceFile=""
    local targetFile=""
    local skipQuestions=true
    skip_questions "$@" skipQuestions=true
    for i in "${LIBRARYFILES_TO_SYMLINK[@]}"; do
      sourceFile="$srcdir/Library/$i"
      targetFile="$HOME/Library/$i"
      mkdir -p ${targetFile%/*}
      rm -Rf "$targetFile"
      if [ ! -e "$targetFile" ]; then
        execute \
          "ln -sf $sourceFile $targetFile" \
          "$targetFile → $sourceFile"
      elif [ "$(readlink "$targetFile")" == "$sourceFile" ]; then
        print_success "$targetFile → $sourceFile"
      else
        print_error "$targetFile → $sourceFile"
      fi
    done
  fi
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
main() {
  backup_symlinks "$@"
  backup_confsymlinks "$@"
  backup_librarysymlinks "$@"
  create_symlinks "$@"
  create_confsymlinks "$@"
  create_librarysymlinks "$@"
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
main "$@"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
