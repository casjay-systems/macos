#!/usr/bin/env bash

SCRIPTNAME="$(basename $0)"
SCRIPTDIR="$(dirname "${BASH_SOURCE[0]}")"
USER="${SUDO_USER:-${USER}}"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author          : Jason
# @Contact         : casjaysdev@casjay.com
# @File            : install.sh
# @Created         : Sun, Feb 23, 2020, 01:00 EST
# @License         : WTFPL
# @Copyright       : Copyright (c) CasjaysDev
# @Description     : installer script for zsh
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set functions

SCRIPTSFUNCTURL="${SCRIPTSFUNCTURL:-https://github.com/casjay-dotfiles/scripts/raw/master/functions}"
SCRIPTSFUNCTDIR="${SCRIPTSFUNCTDIR:-/usr/local/share/CasjaysDev/scripts}"
SCRIPTSFUNCTFILE="${SCRIPTSFUNCTFILE:-app-installer.bash}"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if [ -f "../functions/$SCRIPTSFUNCTFILE" ]; then
    . "../functions/$SCRIPTSFUNCTFILE"
elif [ -f "$SCRIPTSFUNCTDIR/functions/$SCRIPTSFUNCTFILE" ]; then
    . "$SCRIPTSFUNCTDIR/functions/$SCRIPTSFUNCTFILE"
else
    curl -LSs "$SCRIPTSFUNCTURL/$SCRIPTSFUNCTFILE" -o "/tmp/$SCRIPTSFUNCTFILE" || exit 1
    . "/tmp/$SCRIPTSFUNCTFILE"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Make sure the scripts repo is installed

scripts_check

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Defaults

APPNAME="zsh"
PLUGNAME="oh-my-zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# git repos

PLUGINREPO="https://github.com/robbyrussell/oh-my-zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Version

APPVERSION="$(curl -LSs ${DOTFILESREPO:-https://github.com/casjay-dotfiles}/$APPNAME/raw/master/version.txt)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# if installing system wide - change to system_installdirs

user_installdirs

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set options

APPDIR="$CONF/$APPNAME"
PLUGDIR="$SHARE/$APPNAME/${PLUGNAME:-plugins}"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Script options IE: --help

show_optvars "$@"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Requires root - no point in continuing

#sudoreq  # sudo required
#sudorun  # sudo optional

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# end with a space

APP="$APPNAME direnv thefuck "
PERL=""
PYTH=""
PIPS=""
CPAN=""
GEMS=""

# install packages - useful for package that have the same name on all oses
install_packages $APP

# install required packages using file
install_required $APP

# check for perl modules and install using system package manager
install_perl $PERL

# check for python modules and install using system package manager
install_python $PYTH

# check for pip binaries and install using python package manager
install_pip $PIPS

# check for cpan binaries and install using perl package manager
install_cpan $CPAN

# check for ruby binaries and install using ruby package manager
install_gem $GEMS

# Other dependencies
dotfilesreq git
dotfilesreqadmin

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Ensure directories exist

ensure_dirs
ensure_perms

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Main progam

if [ -d "$APPDIR/.git" ]; then
    execute \
        "git_update $APPDIR" \
        "Updating $APPNAME configurations"
else
    execute \
        "backupapp && \
         git_clone -q $REPO/$APPNAME $APPDIR" \
        "Installing $APPNAME configurations"
fi

# exit on fail
failexitcode

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Plugins

if [ "$PLUGNAME" != "" ]; then
if [ -d "$PLUGDIR"/.git ]; then
    execute \
          "git_update $PLUGDIR" \
          "Updating plugin $PLUGNAME"
else
    execute \
          "git_clone $PLUGINREPO $PLUGDIR" \
          "Installing plugin $PLUGNAME"
fi

if [ -d "$PLUGDIR/custom/plugins/zsh-syntax-highlighting/.git" ]; then
    execute \
          "git_update $PLUGDIR/custom/plugins/zsh-syntax-highlighting" \
          "Updating zsh-syntax-highlighting"
else
    execute \
          "git_clone https://github.com/zsh-users/zsh-syntax-highlighting $PLUGDIR/custom/plugins/zsh-syntax-highlighting" \
          "Installing zsh-syntax-highlighting"
fi

if [ -d "$PLUGDIR/custom/themes/powerlevel9k/.git" ]; then
    execute \
          "git_update $PLUGDIR/custom/themes/powerlevel9k" \
          "Updating powerlevel9k"
else
    execute \
          "git_clone https://github.com/bhilburn/powerlevel9k.git $PLUGDIR/custom/themes/powerlevel9k" \
          "Installing powerlevel9k"
fi

if [ -d "$PLUGDIR/custom/themes/powerlevel10k/.git" ]; then
    execute \
          "git_update $PLUGDIR/custom/themes/powerlevel10k" \
          "Updating powerlevel10k"
else
    execute \
          "git_clone https://github.com/romkatv/powerlevel10k.git $PLUGDIR/custom/themes/powerlevel10k" \
          "Installing powerlevel10k"
fi
fi

# exit on fail
failexitcode

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# run post install scripts

run_postinst() {
    run_postinst_global
    ln_sf "$APPDIR/zshrc" "$HOME/.zshrc"

}

   execute \
       "run_postinst" \
       "Running post install scripts"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# create version file

install_version

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# exit
run_exit

# end
# vim: ts=2 sw=2 et noai :
