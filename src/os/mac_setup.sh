#!/usr/bin/env bash

# Define colors
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
RED='\033[0;31m'
GREEN='\033[32m'
NC='\033[0m'
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if [ -f ~/.config/dotfiles/env ]; then
  source ~/.config/dotfiles/env
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Automatic linux install

####################################################################################################
clear                                                                                             #
printf "\n\n\n\n\n   ${BLUE}      *** Initializing the installer please wait *** ${NC} \n\n\n\n " #
####################################################################################################

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Welcome message

clear

wait_time=10 # seconds
temp_cnt=${wait_time}
printf "\n\n\n\n\n${GREEN}         *** ${RED}•${GREEN} Welcome to my dotfiles Installer for MacOS ${RED}•${GREEN} ***${NC}\n"
while [[ ${temp_cnt} -gt 0 ]]; do
  printf "\r  ${GREEN}*** ${RED}•${GREEN} You have %2d second(s) remaining to hit Ctrl+C to cancel ${RED}•${GREEN} ***" ${temp_cnt}
  sleep 1
  ((temp_cnt--))
done
printf "${NC}\n\n"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Dependency check

dotfilesDirectory="$HOME/.local/dotfiles/desktops"
srcdir="$dotfilesDirectory/src"
macosdir="$srcdir/os/mac"

##### for when I'm forgetful
if [ -z $dotfilesDirectory ]; then printf "\n${RED}  *** dotfiles directory not specified ***${NC}\n"; fi
if [ -z $srcdir ]; then printf "\n${RED}  *** dotfiles src directory not specified ***${NC}\n"; fi
if [ -z $macosdir ]; then printf "\n${RED}  *** dotfiles macos directory not specified ***${NC}\n"; fi
#####
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

GIT=$(which git 2>/dev/null)
CURL=$(which curl 2>/dev/null)
WGET=$(which wget 2>/dev/null)
VIM=$(which vim 2>/dev/null)
TMUX=$(which tmux 2>/dev/null)
ZSH=$(which zsh 2>/dev/null)
FISH=$(which fish 2>/dev/null)
SUDO=$(which sudo 2>/dev/null)
BREW=$(which brew 2>/dev/null)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# no sudo can't continue
SUDU=$(which sudo 2>/dev/null)
if ! (sudo true && sudo -ln) 2>&1 | grep -v 'may not' >/dev/null; then
  if [[ -z "$SUDU" ]] && [[ -z "$UPDATE" ]]; then
    printf "\n${GREEN} *** ${RED}•${GREEN} UPDATE=yes bash -c "$(curl -LsS https://github.com/casjay-systems/macos/raw/master/src/os/setup.sh)" ${RED}•${GREEN} ***${NC}\n"
    printf "\n${GREEN}  *** ${RED}•${GREEN} to install just the dotfiles ${RED}•${GREEN} ***${NC}\n"
    printf "\n${RED}  *** ${RED}•${GREEN} No sudo or root privileges ${RED}•${GREEN} ***${NC}\n\n"
    exit
  fi
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ -z "$UPDATE" ]; then
  if ! (sudo true && sudo -ln) 2>&1 | grep -v 'may not' >/dev/null; then
    printf "
  ${RED}\n • Please run one of the following commands as root:${NC}
  ${GREEN}You can just do${RED} su -c $srcdir/os/mac/pkgs/lists/mac-sys.sh${NC}
             \n${RED}then come back to this installer ${NC}\n\n"
    exit
  fi
fi

# Lets check for git, curl, wget
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

if [ -z "$GIT" ] || [ -z "$CURL" ] || [ -z "$WGET" ] || [ -z "$VIM" ] || [ -z "$TMUX" ] || [ -z "$ZSH" ] || [ -z "$FISH" ] || [ -z "$SUDO" ] || [ -z "$BREW" ]; then
  printf "\n${RED}  *** • The following are needed: • ***${NC}\n"
  printf "\n${RED}  *** • ${MISSING} • ***${NC}\n"
  printf "\n${RED}  *** • Attempting to install the missing package[s]• ***${NC}\n\n"
  if (sudo true && sudo -ln) 2>&1 | grep -v 'may not' >/dev/null; then
    if [ -z "$BREW" ]; then
      bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi
    sudo brew install -f ${MISSING} >/dev/null 2>&1 >/dev/null 2>&1
  else
    printf "${RED}  *** • I can't get root access You will have to manually install the missing programs • ***${NC}\n"
    printf "${RED}  *** • ${MISSING} • ***${NC}\n\n\n"
    exit
  fi
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Grab the OS detection script if it doesn't exist script

if [ -f $srcdir/os/osdetect.sh ]; then
  source $srcdir/os/osdetect.sh
else
  curl -Lsq https://raw.githubusercontent.com/casjay-systems/macos/master/src/os/osdetect.sh -o /tmp/osdetect.sh
  source /tmp/osdetect.sh
  rm -Rf /tmp/osdetect.sh
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Set version from git

CURDOTFVERSION="$(echo $(curl -Lsq https://github.com/casjay-systems/macos/raw/master/src/os/version.txt | grep -v "#" | tail -n 1))"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Print distro info

printf "\n\n${PURPLE}  *** • Your Distro is a Mac and is based on BSD • ***${NC}\n\n"
printf "${GREEN}  *** • git, curl, wget, vim, tmux, zsh, fish, sudo are present • ***${NC}\n\n"
printf "${GREEN}  *** • Installing version $CURDOTFVERSION • ***${NC}\n\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Setup the dotfiles Directory

if [ -d $dotfilesDirectory/.git ]; then
  printf "\n${PURPLE} • Updating the git repo - $dotfilesDirectory${NC}\n\n"
  cd "$srcdir/os" && source "utils.sh"

  echo ""
  execute \
    "cd $dotfilesDirectory && \
  git pull --recurse-submodules -fq && \
  cd ~" \
    "Updating dotfiles"
  NEWVERSION="$(echo $(cat $srcdir/os/version.txt | tail -n 1))"
  REVER="$(cd $dotfilesDirectory && git rev-parse --short HEAD)"
  printf "${GREEN}   [✔] Updated to $NEWVERSION - revision: $REVER${NC}\n\n"

else

  printf "\n${PURPLE} • Cloning the git repo - $dotfilesDirectory${NC}\n"
  rm -Rf $dotfilesDirectory
  git clone --depth=1 -q --recursive https://github.com/casjay-systems/macos.git $dotfilesDirectory >/dev/null 2>&1
  printf "\n${GREEN}   [✔] clone https://github.com/casjay-systems/macos.git  → $dotfilesDirectory \n"
  NEWVERSION="$(echo $(cat $srcdir/os/version.txt | tail -n 1))"
  REVER="$(cd $dotfilesDirectory && git rev-parse --short HEAD)"
  printf "${GREEN}   [✔] downloaded version $NEWVERSION - revision: $REVER${NC}\n\n"
  cd "$srcdir/os" && source "utils.sh"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Make Directories and fix permissions

mkdir -p ~/.gnupg ~/.ssh 2>/dev/null
find "$HOME" -xtype l -delete 2>/dev/null
find ~/.gnupg ~/.ssh -type f -exec chmod 600 {} \; 2>/dev/null
find ~/.gnupg ~/.ssh -type d -exec chmod 700 {} \; 2>/dev/null

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Check for then get root permissions
if [ -z $UPDATE ]; then
  if (sudo true && sudo -ln) 2>&1 | grep -v 'may not' >/dev/null; then
    printf "\n${RED} • Getting root privileges${NC}\n\n"
    ask_for_sudo
    printf "\n${GREEN} • Received root privileges${NC}\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # Install Packages
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # MacOS setup
    printf "\n${PURPLE} • Setting up for MacOS $get_os_version ${NC}\n\n"
    if [[ ! -f /usr/local/Homebrew/.srcinstall ]]; then
      echo ""
      execute \
        "$macosdir/pkgs/lists/mac-sys.sh 2> /dev/null &&
       sudo touch /usr/local/Homebrew/.srcinstall" \
        "Installing Packages..... This May take awhile please be patient... Possibly 20+ Minutes"
    fi
    printf "${PURPLE}\n • Done Setting up for the Mac${NC}\n\n"
  fi
fi
###################################################################
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install additional system files if root
if (sudo true && sudo -ln) 2>&1 | grep -v 'may not' >/dev/null; then
  print_in_purple "\n • Installing system files\n\n"
  sudo $macosdir/install_system_files.sh
  print_in_purple "\n • Installing system files completed\n\n"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Create user themes/fonts/icons or install to system if root
print_in_purple "\n • Installing Customizations\n\n"
$macosdir/install_customizations.sh
print_in_purple "\n • Installing Customizations completed\n\n"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Create user directories
print_in_purple "\n • Creating directories\n"
$macosdir/create_directories.sh
print_in_purple "\n • Creating directories completed\n\n"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Create user .local files
print_in_purple "\n • Create local config files\n\n"
$macosdir/create_local_config_files.sh
print_in_purple "\n • Create local config files completed\n\n"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Create user dotfile symlinks
print_in_purple "\n • Create user files\n\n"
$macosdir/create_symbolic_links.sh
print_in_purple "\n • Create user files completed\n\n"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Create and Setup git
GIT=$(which git 2>/dev/null)
if [ -z "$GIT" ]; then print_in_red "\n • The git package is not installed\n\n"; else
  print_in_purple "\n • Installing GIT\n\n"
  $macosdir/install_git.sh
  print_in_purple "\n • Installing GIT completed\n\n"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Create and Setup vim
VIM=$(which vim 2>/dev/null)
if [ -z "$VIM" ]; then print_in_red "\n • The vim package is not installed\n\n"; else
  print_in_purple "\n • Installing vim with plugins\n\n"
  $macosdir/install_vim.sh
  print_in_purple "\n • Installing vim with plugins completed\n\n"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Create and Setup tmux
TMUX=$(which tmux 2>/dev/null)
if [ -z "$TMUX" ]; then print_in_red "\n • The tmux package is not installed\n\n"; else
  print_in_purple "\n • Installing tmux plugins\n\n"
  $macosdir/install_tmux.sh
  print_in_purple "\n • Installing tmux plugins completed\n\n"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Create and Setup zsh
ZSH=$(which zsh 2>/dev/null)
if [ -z "$ZSH" ]; then print_in_red "\n • The zsh package is not installed\n\n"; else
  print_in_purple "\n • Installing zsh with plugins\n\n"
  $macosdir/install_ohmyzsh.sh
  print_in_purple "\n • Installing zsh with plugins completed\n\n"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Create and Setup fish
FISH=$(which fish 2>/dev/null)
if [ -z "$FISH" ]; then print_in_red "\n • The fish package is not installed\n\n"; else
  print_in_purple "\n • Installing fish shell and plugins\n\n"
  $macosdir/install_ohmyfish.sh
  print_in_purple "\n • Installing fish shell and plugins completed\n\n"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install additional system files if root
##
##
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Go home
cd $HOME

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Fix permissions again
find "$HOME" -xtype l -delete find "$HOME" -xtype l -delete 2>/dev/null
find ~/.gnupg ~/.ssh -type f -exec chmod 600 {} \; 2>/dev/null
find ~/.gnupg ~/.ssh -type d -exec chmod 700 {} \; 2>/dev/null
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Create env file
if [ ! -d ~/.config/dotfiles ]; then mkdir -p ~/.config/dotfiles; fi
if [ ! -f ~/.config/dotfiles/env ]; then
  echo "" >~/.config/dotfiles/env
  echo "UPDATE="yes"" >>~/.config/dotfiles/env
  echo "dotfilesDirectory="$dotfilesDirectory"" >>~/.config/dotfiles/env
  echo "srcdir="$dotfilesDirectory/src"" >>~/.config/dotfiles/env
  echo "macosdir="$srcdir/os/macos"" >>~/.config/dotfiles/env
  echo "INSTALLEDVER="$NEWVERSION"" >>~/.config/dotfiles/env
  echo "DISTRO="$DISTRO"" >>~/.config/dotfiles/env
  echo "CODENAME="$CODENAME"" >>~/.config/dotfiles/env
  echo "GIT="$GIT"" >>~/.config/dotfiles/env
  echo "CURL="$CURL"" >>~/.config/dotfiles/env
  echo "WGET="$WGET"" >>~/.config/dotfiles/env
  echo "VIM="$VIM"" >>~/.config/dotfiles/env
  echo "TMUX="$TMUX"" >>~/.config/dotfiles/env
  echo "ZSH="$ZSH"" >>~/.config/dotfiles/env
  echo "FISH="$FISH"" >>~/.config/dotfiles/env
  echo "BREW="$BREW"" >>~/.config/dotfiles/env
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# run clean up
print_in_purple "\n • Running cleanup\n\n"
if (sudo true && sudo -ln) 2>&1 | grep -v 'may not' >/dev/null; then
  echo ""
#    execute \
#    "sudo echo "" \
#    "Clean up"
fi

print_in_purple "\n • Running cleanup complete\n\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Print installed version

NEWVERSION="$(echo $(cat $srcdir/os/version.txt | tail -n 1))"
# End Install
RESULT=$?
printf "\n${GREEN}       *** 😃 installation of dotfiles completed 😃 *** ${NC}\n"
printf "${GREEN}  *** 😃 You now have version number: $NEWVERSION 😃 *** ${NC}\n\n"
printf "\n   ${RED}  *** For the configurations to take effect *** ${NC} \n "
printf "\n   ${RED}   *** you should logoff or reboot your system *** ${NC} \n\n\n\n "
##################################################################################################

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
