#  -*- shell-script -*-

# set umask

#umask 022

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# disable blank screen

xset s off >/dev/null 2>&1
xset -dpms >/dev/null 2>&1
xset s off -dpms >/dev/null 2>&1

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# create dirs

mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/nvm"
mkdir -p "$HOME/.local/log"
mkdir -p "$HOME/.local/share/gem/bin"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# set profile as sourced

export SRCBASHRC="$HOME/.bash_profile"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# configure display

if cat /proc/version | grep -iq chromium && [ ! -z $DISPLAY ] && [ ! -z $DISPLAY_LOW_DENSITY ]; then
  export DISPLAY="$DISPLAY_LOW_DENSITY"
fi

export RESOLUTION="$(xrandr --current | grep  '*' | uniq | awk '{print $1}')"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# enable control alt backspace

export XKBOPTIONS="terminate:ctrl_alt_bksp"
setxkbmap -model pc104 -layout us -option "terminate:ctrl_alt_bksp"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# setup modifiers

if [ -f "$(command -v ibus)" ]; then
  export XMODIFIERS=@im=ibus
  export GTK_IM_MODULE=ibus
  export QT_IM_MODULE=ibus
elif [ -f "$(command -v fcitx)" ]; then
  export XMODIFIERS=@im=fcitx
  export GTK_IM_MODULE=fcitx
  export QT_IM_MODULE=fcitx
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# xserver settings

if [ ! -f ~/.Xdefaults ]; then
    touch ~/.Xdefaults
else
    xrdb ~/.Xdefaults 2>/dev/null
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# xserver settings

if [ ! -f ~/.Xresources ]; then
    touch ~/.Xresources
  else
    xrdb ~/.Xresources 2>/dev/null
    xrdb -merge ~/.Xresources 2>/dev/null
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# ensure .gitconfig exists

if [ -f ~/.config/local/gitconfig.local ] && [ ! -f ~/.gitconfig ]; then
    cp -f ~/.config/local/gitconfig.local ~/.gitconfig
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# set user completion dir

export BASH_COMPLETION_USER_DIR="$HOME/.local/share/bash-completion/completions"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Ignore commands that start with spaces and duplicates.

export HISTCONTROL=ignoreboth

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Increase the maximum number of lines of history
# persisted in the history file (default value is 500).

export HISTFILESIZE=10000

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Don't add certain commands to the history file.

export HISTIGNORE="&:[bf]g:c:clear:history:exit:q:pwd:* --help"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Increase the maximum number of commands recorded
# in the command history (default value is 500).

export HISTSIZE=10000

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Sudo prompt

export SUDO_PROMPT="$(printf "\t\t\033[1;36m")[sudo]$(printf "\033[0m") password for %p: "

if [ -e "/usr/local/bin/dmenupass" ] && [ ! -z "$DESKTOP_SESSION" ] ; then
  export SUDO_ASKPASS="${SUDO_ASKPASS:-/usr/local/bin/dmenupass}"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# basher

if [ -d "$HOME/.local/share/bash/basher" ]; then
  export BASHER_ROOT="$HOME"/.local/share/bash/basher
  export PATH="$HOME/.local/share/bash/basher/bin:$PATH"
  eval "$(basher init -)"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# export gpg tty

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="/run/user/$(id -u)/gnupg/S.gpg-agent.ssh"
eval $(gpg-agent --daemon 2>/dev/null)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Use custom `less` colors for `man` pages.

# Start blinking
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
# Start bold
export LESS_TERMCAP_md=$(tput bold; tput setaf 2) # green
# Start stand out
export LESS_TERMCAP_so=$(tput bold; tput setaf 3) # yellow
# End standout
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
# Start underline
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 1) # red
# End Underline
export LESS_TERMCAP_ue=$(tput sgr0)
# End bold, blinking, standout, underline
export LESS_TERMCAP_me=$(tput sgr0)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Don't clear the screen after quitting a `man` page.

export MANPAGER="less -X"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# add emacs to bin

if [ -d $HOME/.emacs.d/bin ]; then
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

export QA_RPATHS="$[ 0x0001|0x0010 ]"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# mpd name

export MPDSERVER="$(hostname -s)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# tizonia cloud player config

export TIZONIA_RC_FILE="$HOME/.config/tizonia/tizonia.conf"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# create a banner

export BANNER="echo"
if [ -n "$(command -v banner 2>/dev/null)" ]; then
    export BANNER="banner"
elif [ -n "$(command -v figlet 2>/dev/null)" ]; then
    export BANNER="figlet -f banner"
elif [ -n "$(command -v toilet 2>/dev/null)" ]; then
    export BANNER="toilet -f mono9.tlf"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Ruby Version Manager

export GEM_HOME="$HOME/.local/share/gem"
export rvm_ignore_gemrc_issues=1
export rvm_silence_path_mismatch_check_flag=1

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# node version manager

export NO_UPDATE_NOTIFIER="true"
export NVM_BIN="$HOME/.local/bin"
export NVM_DIR="$HOME/.local/share/nvm"
export NODE_REPL_HISTORY_SIZE=10000
if [ ! -d $HOME/.local/share/nvm ]; then mkdir -p $HOME/.local/share/nvm ; fi
if [ -s "$NVM_DIR/nvm.sh" ]; then source "$NVM_DIR/nvm.sh" ; fi
if [ -s "$NVM_DIR/bash_completion" ]; then source "$NVM_DIR"/bash_completion ; fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# export color

if [ -f "$HOME/.dircolors" ]; then
    export DIRCOLOR="$HOME"/.dircolors
else
    export DIRCOLOR="$HOME"/.config/dircolors/dracula
fi

if [ "$OSTYPE" = darwin* ];then
  export LSCOLORS=DxgxcxdxCxegedabagacad
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# lf file manager icons

export LF_ICONS="di=:fi=:ln=:or=:ex=:*.c=:*.cc=:*.clj=:*.coffee=:*.cpp=:*.css=:*.d=:*.dart=:*.erl=:*.exs=:*.fs=:*.go=:*.h=:*.hh=:*.hpp=:*.hs=:*.html=:*.java=:*.jl=:*.js=:*.json=:*.lua=:*.md=:*.php=:*.pl=:*.pro=:*.py=:*.rb=:*.rs=:*.scala=:*.ts=:*.vim=:*.cmd=:*.ps1=:*.sh=:*.bash=:*.zsh=:*.fish=:*.tar=:*.tgz=:*.arc=:*.arj=:*.taz=:*.lha=:*.lz4=:*.lzh=:*.lzma=:*.tlz=:*.txz=:*.tzo=:*.t7z=:*.zip=:*.z=:*.dz=:*.gz=:*.lrz=:*.lz=:*.lzo=:*.xz=:*.zst=:*.tzst=:*.bz2=:*.bz=:*.tbz=:*.tbz2=:*.tz=:*.deb=:*.rpm=:*.jar=:*.war=:*.ear=:*.sar=:*.rar=:*.alz=:*.ace=:*.zoo=:*.cpio=:*.7z=:*.rz=:*.cab=:*.wim=:*.swm=:*.dwm=:*.esd=:*.jpg=:*.jpeg=:*.mjpg=:*.mjpeg=:*.gif=:*.bmp=:*.pbm=:*.pgm=:*.ppm=:*.tga=:*.xbm=:*.xpm=:*.tif=:*.tiff=:*.png=:*.svg=:*.svgz=:*.mng=:*.pcx=:*.mov=:*.mpg=:*.mpeg=:*.m2v=:*.mkv=:*.webm=:*.ogm=:*.mp4=:*.m4v=:*.mp4v=:*.vob=:*.qt=:*.nuv=:*.wmv=:*.asf=:*.rm=:*.rmvb=:*.flc=:*.avi=:*.fli=:*.flv=:*.gl=:*.dl=:*.xcf=:*.xwd=:*.yuv=:*.cgm=:*.emf=:*.ogv=:*.ogx=:*.aac=:*.au=:*.flac=:*.m4a=:*.mid=:*.midi=:*.mka=:*.mp3=:*.mpc=:*.ogg=:*.ra=:*.wav=:*.oga=:*.opus=:*.spx=:*.xspf=:*.pdf="

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

if [ -z $TEMP ]; then
    export TEMP=/tmp
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# logging

export LOGDIR="$HOME/.local/log"
export DEFAULT_LOG_DIR="$LOGDIR"
export DEFAULT_LOG="scripts"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME"/.local/bin ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME"/.local/share/scripts/bin ]; then
    export PATH="$HOME/.local/share/scripts/bin:$PATH"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# cheat.sh settings
export CHTSH_HOME="$HOME/.config/cheat.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# export vdpau driver

if [ ! -z "$VDPAU_DRIVER" ]; then
  export VDPAU_DRIVER=va_gl
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# enviroment variables when uing a desktop

if [ ! -z $DISPLAY ]; then
  dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# passmgr default settings - copy to your bash.local and change for your setup

if [ -f "$HOME/.config/secure/passmgr.txt" ]; then
    source "$HOME/.config/secure/passmgr.txt"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# github default settings - copy to your bash.local and change for your setup

if [ -f "$HOME/.config/secure/github.txt" ]; then
    source "$HOME/.config/secure/github.txt"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# gitlab default settings - copy to your bash.local and change for your setup

if [ -f "$HOME/.config/secure/gitlab.txt" ]; then
    source "$HOME/.config/secure/gitlab.txt"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# your private git - copy to your bash.local and change for your setup

if [ -f "$HOME/.config/secure/gitpriv.txt" ]; then
    source "$HOME/.config/secure/gitpriv.txt"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Dotfiles base repo  - copy to your bash.local and change for your setup

if [ -f "$HOME/.config/secure/personal.txt" ]; then
    source "$HOME/.config/secure/personal.txt"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# APIKEYS  - copy to your bash.local and change for your setup

if [ -f "$HOME/.config/secure/apikeys.txt" ]; then
    source "$HOME/.config/secure/apikeys.txt"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# set variable for other scripts


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
