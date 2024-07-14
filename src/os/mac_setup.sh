#!/usr/bin/env bash
# shellcheck disable=2155,2027,2288,2140,2059,2164

export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:$PATH"

#Modify and set if using the auth token
AUTHTOKEN=""
# either http https or git
GITPROTO="https://"
#Your git repo
GITREPO="github.com/casjay-systems/macos"
# Git Command - Private Repo
#GITURL="$GITPROTO$AUTHTOKEN:x-oauth-basic@$GITREPO"
#Public Repo
GITURL="$GITPROTO$GITREPO"
# Default NTP Server
NTPSERVER="0.casjay.pool.ntp.org"
# Set the temp directory
DOTTEMP="/tmp/dotfiles-desktop-$USER"
# Default dotfiles dir
# Set primary dir - not used
DOTFILES="$HOME/.local/dotfiles/OS"

export dotfilesDirectory="$DOTFILES"
export srcdir="$dotfilesDirectory/src"
export macosdir="$srcdir/os/mac"
export backupsdir="$HOME/.local/backups/dotfiles/macos"

export NONINTERACTIVE=1
export HOMEBREW_NO_AUTO_UPDATE=true
export HOMEBREW_INSTALL_BADGE="☕️ 🐸"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

export SUDO_PROMPT="$(printf "\033[1;36m")  • [sudo]$(printf "\033[0m") password for %p: "

##### for when I'm forgetful
if [ -z "$dotfilesDirectory" ]; then printf "\n${RED}   *** dotfiles directory not specified ***${NC}\n"; fi
if [ -z "$srcdir" ]; then printf "\n${RED}   *** dotfiles src directory not specified ***${NC}\n"; fi
if [ -z "$macosdir" ]; then printf "\n${RED}   *** dotfiles macos directory not specified ***${NC}\n"; fi
#####
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Define colors
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
RED='\033[0;31m'
GREEN='\033[32m'
NC='\033[0m'
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if [[ ! "$OSTYPE" =~ ^darwin ]]; then
  printf "\n\t\t${RED}   This script is for MacOS ${NC}\n\n"
  exit 1
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Grab the OS detection script if it doesn't exist script

if [ -f "$srcdir/os/osdetect.sh" ] && [ -f "$srcdir/os/utils.sh" ]; then
  source "$srcdir/os/utils.sh"
  source "$srcdir/os/osdetect.sh"
else
  curl -Lsq "https://$GITREPO/raw/main/src/os/utils.sh" -o /tmp/utils.sh
  curl -Lsq "https://$GITREPO/raw/main/src/os/osdetect.sh" -o /tmp/osdetect.sh
  if [ -f "/tmp/osdetect.sh" ] && [ -f "/tmp/utils.sh" ]; then
    source /tmp/utils.sh
    source /tmp/osdetect.sh
    rm -Rf /tmp/utils.sh /tmp/osdetect.sh
  else
    clear
    printf "\n\n\n\n${BLUE}   Could not source the files needed ${NC}\n\n\n\n"
    exit 1
  fi
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if [ -f "$HOME/.config/dotfiles/env" ]; then
  source "$HOME/.config/dotfiles/env"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Automatic linux install
####################################################################################################
clear                                                                                       #
printf "\n\n\n\n\n${BLUE}   *** Initializing the installer please wait *** ${NC} \n\n\n\n " #
[ "$TRAVIS" ] || say 'Initializing the installer please wait!'                              #
####################################################################################################
if (sudo -vn && sudo -ln) 2>&1 | grep -v 'may not' >/dev/null; then
  printf "\n${RED}   • Getting root privileges •${NC}\n" &&
    ask_for_sudo && SUDO_USER="true"
  if [ "$?" -eq 0 ]; then
    printf "${GREEN}   • Received root privileges •${NC}\n"
  else
    printf "${GREEN}   • Can not get access to sudo •${NC}\n"
    exit 1
  fi
else
  printf "${GREEN}   • Can not get access to sudo •${NC}\n\n"
  exit 1
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Welcome message
clear
wait_time=10 # seconds
temp_cnt=${wait_time}
printf "\n\n\n\n\n${GREEN}   *** ${RED}•${GREEN} Welcome to my dotfiles Installer for MacOS ${RED}•${GREEN} ***${NC}\n"
while [[ ${temp_cnt} -gt 0 ]]; do
  printf "\r${GREEN}   *** ${RED}•${GREEN} You have %2d second(s) remaining: Press Ctrl+C to cancel ${RED}•${GREEN} ***" ${temp_cnt}
  sleep 1
  ((temp_cnt--))
done
printf "${NC}\n\n"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if [ ! -f "$(command -v brew)" ]; then
  execute "echo | /bin/bash -c $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" "Installing brew"
fi
# no sudo can't continue
SUDU=$(command -v sudo 2>/dev/null)
if ! (sudo true && sudo -ln) 2>&1 | grep -v 'may not' >/dev/null; then
  if [[ -z "$SUDU" ]] && [[ -z "$UPDATE" ]]; then
    printf "\n${GREEN}   *** ${RED}•${GREEN} UPDATE=yes bash -c "$(curl -LsS https://github.com/casjay-systems/macos/raw/main/src/os/setup.sh)" ${RED}•${GREEN} ***${NC}\n"
    printf "\n${GREEN}   *** ${RED}•${GREEN} to install just the dotfiles ${RED}•${GREEN} ***${NC}\n"
    printf "\n${RED}   *** ${RED}•${GREEN} No sudo or root privileges ${RED}•${GREEN} ***${NC}\n\n"
    exit
  fi
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ -z "$UPDATE" ]; then
  if ! (sudo true && sudo -ln) 2>&1 | grep -v 'may not' >/dev/null; then
    printf "${RED}\n   • Please run one of the following commands as root:${NC}\n"
    printf "${GREEN}   You can just do${RED} su -c $srcdir/os/mac/pkgs/lists/mac-sys.sh${NC}\n${RED}then come back to this installer ${NC}\n\n"
    exit
  fi
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Lets check for git, curl, wget
GIT=$(command -v git 2>/dev/null)
CURL=$(command -v curl 2>/dev/null)
WGET=$(command -v wget 2>/dev/null)
VIM=$(command -v vim 2>/dev/null)
TMUX=$(command -v tmux 2>/dev/null)
ZSH=$(command -v zsh 2>/dev/null)
FISH=$(command -v fish 2>/dev/null)
SUDO=$(command -v sudo 2>/dev/null)
BREW=$(command -v brew 2>/dev/null)
JQ=$(command -v jq 2>/dev/null)

unset MISSING
if [[ ! "$GIT" ]]; then MISSING="$MISSING git"; fi
if [[ ! "$CURL" ]]; then MISSING="$MISSING curl"; fi
if [[ ! "$WGET" ]]; then MISSING="$MISSING wget"; fi
if [[ ! "$VIM" ]]; then MISSING="$MISSING vim"; fi
if [[ ! "$TMUX" ]]; then MISSING="$MISSING tmux"; fi
if [[ ! "$ZSH" ]]; then MISSING="$MISSING zsh"; fi
if [[ ! "$FISH" ]]; then MISSING="$MISSING fish"; fi
if [[ ! "$SUDO" ]]; then MISSING="$MISSING sudo"; fi
if [[ ! "$BREW" ]]; then MISSING="$MISSING brew"; fi
if [[ ! "$JQ" ]]; then MISSING="$MISSING jq"; fi

if [ -z "$BREW" ]; then
  printf "${RED}   *** • Failed to install brew • ***${NC}\n"
  printf "${BLUE}   *** • /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" • ***${NC}\n\n\n"
  exit 1
fi

if [ -z "$GIT" ] || [ -z "$CURL" ] || [ -z "$WGET" ] || [ -z "$VIM" ] || [ -z "$TMUX" ] || [ -z "$ZSH" ] || [ -z "$FISH" ] || [ -z "$SUDO" ] || [ -z "$JQ" ]; then
  printf "\n${RED}   *** • The following are needed: • ***${NC}\n"
  printf "${RED}   *** • ${MISSING} • ***${NC}\n"
  if (sudo true && sudo -ln) 2>&1 | grep -v 'may not' >/dev/null; then
    execute "brew install -f $MISSING" "Attempting to install the missing package[s]"
  else
    printf "${RED}   *** • I can't get root access You will have to manually install the missing programs • ***${NC}\n"
    printf "${RED}   *** • ${MISSING} • ***${NC}\n\n\n"
    exit
  fi
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Grab the OS detection script if it doesn't exist script
if [ -f "$srcdir/os/osdetect.sh" ]; then
  source "$srcdir/os/osdetect.sh"
else
  curl -Lsq https://raw.githubusercontent.com/casjay-systems/macos/master/src/os/osdetect.sh -o "/tmp/osdetect.sh"
  source "/tmp/osdetect.sh"
  rm -Rf "/tmp/osdetect.sh"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Set version from git
CURDOTFVERSION="$(echo "$(curl -Lsq https://github.com/casjay-systems/macos/raw/main/version.txt | grep -v "#" | head -n 1)")"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Print distro info
printf "\n\n${PURPLE}   *** • Your Distro is a Mac and is based on BSD • ***${NC}\n"
printf "${GREEN}   *** • git, curl, wget, vim, tmux, zsh, fish, sudo are present • ***${NC}\n"
printf "${GREEN}   *** • Installing version $CURDOTFVERSION • ***${NC}\n"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Setup the dotfiles Directory
printf "\n${PURPLE}   • Setting up the git repo${NC}\n"
if [ -d "$dotfilesDirectory"/.git ]; then
  cd "$srcdir/os" && source "utils.sh"
  execute \
    "git -C $dotfilesDirectory pull --recurse-submodules -fq" \
    "Updating $dotfilesDirectory"
  NEWVERSION="$(tail -n 1 "$dotfilesDirectory/version.txt")"
  REVER="$(git -C $dotfilesDirectory rev-parse --short HEAD)"
  printf "${GREEN}   [✔] Updated to $NEWVERSION - revision: $REVER${NC}\n"
else
  rm -Rf "$dotfilesDirectory"
  execute \
    "git clone --depth=1 -q --recursive https://github.com/casjay-systems/macos.git $dotfilesDirectory >/dev/null 2>&1" \
    "clone https://github.com/casjay-systems/macos.git  → $dotfilesDirectory"
  NEWVERSION="$(tail -n 1 "$dotfilesDirectory/version.txt")"
  REVER="$(git -C $dotfilesDirectory rev-parse --short HEAD)"
  printf "${GREEN}   [✔] downloaded version $NEWVERSION - revision: $REVER${NC}\n"
  cd "$srcdir/os" && source "utils.sh"
fi
printf "${PURPLE}   • Setting up the git repo completed${NC}\n\n"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Make Directories and fix permissions
mkdir -p "$HOME"/.gnupg "$HOME"/.ssh 2>/dev/null
find "$HOME" -xtype l -delete 2>/dev/null
find "$HOME"/.gnupg "$HOME"/.ssh -type f -exec chmod 600 {} \; 2>/dev/null
find "$HOME"/.gnupg "$HOME"/.ssh -type d -exec chmod 700 {} \; 2>/dev/null
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Check for then get root permissions
if [ -z "$UPDATE" ] || [ "$1" = "--force" ]; then
  if (sudo true && sudo -ln) 2>&1 | grep -v 'may not' >/dev/null; then
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # Install Packages
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # MacOS setup
    printf "\n${PURPLE} • Setting up for MacOS $get_os_version ${NC}\n"
    if [[ ! -f /usr/local/Homebrew/.srcinstall ]] || [ "$1" = "--force" ]; then
      printf "${GREEN}   *** • This May take awhile please be patient...${NC}\n"
      printf "${GREEN}   *** • Possibly 20+ Minutes.. ${NC}\n"
      printf "${GREEN}   *** • So go have a nice cup of coffee!${NC}\n"
      "$macosdir/pkgs/lists/mac-sys.sh"
    fi
    printf "\n${PURPLE}   • Done Setting up for the Mac${NC}\n\n"
  fi
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install additional
print_in_purple "\n   • Installing additional tools\n"
if [ -f "$(command -v dfmgr 2>/dev/null)" ]; then
  execute "dfmgr install misc"
fi
print_in_purple "   • Installing additional tools completed\n\n"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Create user directories
print_in_purple "\n   • Creating directories\n"
"$macosdir/create_directories.sh"
print_in_purple "   • Creating directories completed\n\n"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install additional system files if root
if (sudo true && sudo -ln) 2>&1 | grep -v 'may not' >/dev/null; then
  print_in_purple "\n   • Installing system files\n"
  sudo "$macosdir/install_system_files.sh"
  print_in_purple "   • Installing system files completed\n\n"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Create user themes/fonts/icons or install to system if root
print_in_purple "\n   • Installing Customizations\n"
"$macosdir/install_customizations.sh"
print_in_purple "   • Installing Customizations completed\n\n"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Create user .local files
print_in_purple "\n   • Create local config files\n"
"$macosdir/create_local_config_files.sh"
print_in_purple "   • Create local config files completed\n\n"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Create user dotfile symlinks
print_in_purple "\n   • Create user files\n"
"$macosdir/create_symbolic_links.sh"
print_in_purple "   • Create user files completed\n"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Create and Setup git
GIT=$(command -v git 2>/dev/null)
if [ -z "$GIT" ]; then print_in_red "\n • The git package is not installed\n\n"; else
  print_in_purple "\n   • Installing GIT\n"
  "$macosdir/install_git.sh"
  print_in_purple "   • Installing GIT completed\n\n"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Create and Setup vim
VIM=$(command -v vim 2>/dev/null)
if [ -z "$VIM" ]; then print_in_red "\n • The vim package is not installed\n\n"; else
  print_in_purple "\n   • Installing vim with plugins\n"
  "$macosdir/install_vim.sh"
  print_in_purple "   • Installing vim with plugins completed\n\n"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Create and Setup tmux
TMUX=$(command -v tmux 2>/dev/null)
if [ -z "$TMUX" ]; then print_in_red "\n • The tmux package is not installed\n\n"; else
  print_in_purple "\n   • Installing tmux plugins\n"
  "$macosdir/install_tmux.sh"
  print_in_purple "   • Installing tmux plugins completed\n\n"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Create and Setup zsh
ZSH=$(command -v zsh 2>/dev/null)
if [ -z "$ZSH" ]; then print_in_red "\n • The zsh package is not installed\n\n"; else
  print_in_purple "\n   • Installing zsh with plugins\n"
  "$macosdir/install_ohmyzsh.sh"
  print_in_purple "   • Installing zsh with plugins completed\n\n"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Create and Setup fish
FISH=$(command -v fish 2>/dev/null)
if [ -z "$FISH" ]; then print_in_red "\n • The fish package is not installed\n\n"; else
  print_in_purple "\n   • Installing fish shell and plugins\n"
  "$macosdir/install_ohmyfish.sh"
  print_in_purple "   • Installing fish shell and plugins completed\n"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Create and Setup Visual Studio code
CODE=$(command -v code 2>/dev/null)
if [ -z "$CODE" ]; then print_in_red "\n • The Visual Studio code package is not installed\n\n"; else
  print_in_purple "\n   • Installing Visual Studio code and plugins\n"
  "$macosdir/install_vscode.sh"
  print_in_purple "   • Installing Visual Studio code shell and plugins completed\n"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ -f "$(command -v pip3 2>/dev/null) " ]; then
  PIP="python3 -mpip install"
  if [ -z "$(command -v shodan 2>/dev/null)" ] || [ -z "$(command -v ytmdl 2>/dev/null)" ] || [ -z "$(command -v toot 2>/dev/null)" ] ||
    [ -z "$(command -v castero 2>/dev/null)" ] || [ -z "$(command -v rainbowstream 2>/dev/null)" ]; then
    print_in_purple "\n   • Installing terminal tools\n"
    for PIPTOOLS in git+https://github.com/sixohsix/python-irclib shodan ytmdl toot castero rainbowstream; do
      if "(sudo -vn && sudo -ln)" 2>&1 | grep -v 'may not' >/dev/null; then
        __am_i_online && execute \
          "sudo sh -c $PIP install $PIPTOOLS >/dev/null 2>&1" \
          "Installing pip package: $PIPTOOLS"
      else
        __am_i_online && execute \
          "sh -c $PIP install --user $PIPTOOLS >/dev/null 2>&1" \
          "Installing pip package: $PIPTOOLS"
      fi
    done
    print_in_purple "   • Installing terminal tools completed\n\n"
  fi
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Go home
cd "$HOME"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Fix permissions again
find "$HOME" -xtype l -delete find "$HOME" -xtype l -delete 2>/dev/null
find "$HOME"/.gnupg "$HOME"/.ssh -type f -exec chmod 600 {} \; 2>/dev/null
find "$HOME"/.gnupg "$HOME"/.ssh -type d -exec chmod 700 {} \; 2>/dev/null
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Create env file
GIT=$(command -v git 2>/dev/null)
CURL=$(command -v curl 2>/dev/null)
WGET=$(command -v wget 2>/dev/null)
VIM=$(command -v vim 2>/dev/null)
TMUX=$(command -v tmux 2>/dev/null)
ZSH=$(command -v zsh 2>/dev/null)
FISH=$(command -v fish 2>/dev/null)
SUDO=$(command -v sudo 2>/dev/null)
BREW=$(command -v brew 2>/dev/null)
DISTRO="$(sw_vers -productName) $(sw_vers -productVersion)"
CODENAME="$(sed -nE '/SOFTWARE LICENSE AGREEMENT FOR/s/([A-Za-z]+ ){5}|\\$//gp' /System/Library/CoreServices/Setup\ Assistant.app/Contents/Resources/en.lproj/OSXSoftwareLicense.rtf | awk '{print $2}')"
if [ ! -d "$HOME"/.config/dotfiles ]; then mkdir -p "$HOME"/.config/dotfiles; fi
if [ ! -f "$HOME"/.config/dotfiles/env ]; then
  echo "" >"$HOME"/.config/dotfiles/env
  echo "UPDATE="yes"" >>"$HOME"/.config/dotfiles/env
  echo "dotfilesDirectory="$dotfilesDirectory"" >>"$HOME/.config/dotfiles/env"
  echo "srcdir="$dotfilesDirectory/src"" >>"$HOME/.config/dotfiles/env"
  echo "macosdir="$srcdir/os/mac"" >>"$HOME/.config/dotfiles/env"
  echo "INSTALLEDVER="$NEWVERSION"" >>"$HOME/.config/dotfiles/env"
  echo "DISTRO="$DISTRO"" >>"$HOME/.config/dotfiles/env"
  echo "CODENAME="$CODENAME"" >>"$HOME/.config/dotfiles/env"
  echo "GIT="$GIT"" >>"$HOME/.config/dotfiles/env"
  echo "CURL="$CURL"" >>"$HOME/.config/dotfiles/env"
  echo "WGET="$WGET"" >>"$HOME/.config/dotfiles/env"
  echo "VIM="$VIM"" >>"$HOME/.config/dotfiles/env"
  echo "TMUX="$TMUX"" >>"$HOME/.config/dotfiles/env"
  echo "ZSH="$ZSH"" >>"$HOME/.config/dotfiles/env"
  echo "FISH="$FISH"" >>"$HOME/.config/dotfiles/env"
  echo "BREW="$BREW"" >>"$HOME/.config/dotfiles/env"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# run clean up
print_in_purple "\n   • Running cleanup\n"
if (sudo true && sudo -ln) 2>&1 | grep -v 'may not' >/dev/null; then
  execute "brew cleanup"
fi
print_in_purple "\n   • Running cleanup complete\n"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if (sudo true && sudo -ln) 2>&1 | grep -v 'may not' >/dev/null; then
  sudo touch /usr/local/Homebrew/.srcinstall
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Print installed version
NEWVERSION="$(tail -n 1 "$dotfilesDirectory/version.txt")"
# End Install
#RESULT=$?
printf "\n${GREEN}   *** 😃 installation of dotfiles completed 😃 *** ${NC}\n"
printf "${GREEN}   *** 😃 You now have version number: "$NEWVERSION" 😃 *** ${NC}\n\n"
printf "${RED}   *** For the configurations to take effect *** ${NC} \n "
printf "${RED}   *** you should logoff or reboot your system *** ${NC} \n\n\n\n "
##################################################################################################
[ "$TRAVIS" ] || say 'installation of dotfiles completed! You should now reboot your system!'
##################################################################################################
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
