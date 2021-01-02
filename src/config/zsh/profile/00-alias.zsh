#!/usr/bin/env zsh

# System Aliases
alias q="exit"
alias :q="exit"
alias :q!="exit"
alias c="clear"
alias ch="history -c && > ~/.bash_history"
alias g="git"
alias m="man"
alias map="xargs -n1"
alias n="npm"
alias path="printf "%b\n" "${PATH//:/\\n}""
alias t="tmux"
alias bashrc="clear && source ~/.bashrc"
alias inputrc="bind -f ~/.inputrc"
alias tailf="tail -f"
alias ipconfig="ifconfig"
alias systemctl="sudo systemctl"
alias mount="mount -l"
alias h="history"
alias j="jobs -l"
alias nowtime="date +"%T""
alias nowdate="date +"%m-%d-%Y""
alias wget="wget -c"
alias df="df -H"
alias du="du -ch"
alias docker="sudo docker"
alias dockerrun="sudo docker run --rm --network host -it"
alias setver="date +"%m%d%Y%H%M-git""
alias setverfile="date +"%m%d%Y%H%M-git" > version.txt"
alias ssh="ssh -X"
alias userlist="cut -d: -f1 /etc/passwd"
alias muttsync="__muttsync"
alias mutt="neomutt"
alias histcheck="history|awk "{print \$4}"|sort|uniq -c|sort -n"
alias histcheckarg="history|awk "{print \$4\" \"\$5\" \"\$6\" \"\$7\" \"\$8\" \"\$9\" \"\$10}"|sort|uniq -c|sort -n"
alias sort="LC_ALL=C sort"
alias uniq="LC_ALL=C uniq"
alias lynx="lynx -cfg=$HOME/.config/lynx/lynx.cfg -lss=$HOME/.config/lynx/lynx.lss"
alias grep="grep --color=auto 2>/dev/null"
alias egrep="egrep --color=auto 2>/dev/null"
alias fgrep="fgrep --color=auto 2>/dev/null"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if [ "$MYOSTYPE" == "Linux" ]; then
    alias ll="ls -l --color=auto 2>/dev/null"
    alias l.="ls -d .* --color=auto 2>/dev/null"
    alias ls="ls --color=auto 2>/dev/null"
    alias ll="ls -l"
    alias la="ls -a"
elif [ "$MYOSTYPE" == "Darwin" ]; then
    alias ls="ls -G 2>/dev/null"
    alias ll="ls -lG 2>/dev/null"
    alias l.="ls -dG .* 2>/dev/null"
    alias readlink="greadlink 2>/dev/null"
    alias dircolors="gdircolors 2>/dev/null"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# CD Aliases
alias ~="cd $HOME"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias cd..="cd .."

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#Set vim as default
if [ "$MYOSTYPE" == "Linux" ]; then
    alias vi="/usr/bin/vim"
    alias vim="/usr/bin/vim"
    alias vis="/usr/bin/vim +set si"
    alias svi="sudo /usr/bin/vim"
elif [ "$MYOSTYPE" == "Darwin" ]; then
    alias vi="/usr/local/bin/vim"
    alias vim="/usr/local/bin/vim"
    alias vis="/usr/local/bin/vim +set si"
    alias svi="sudo /usr/local/bin/vim"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#Set neovim
if [ "$MYOSTYPE" == "Linux" ]; then
    alias nvim="/usr/bin/nvim -u $HOME/.config/neovim/init.vim"
elif [ "$MYOSTYPE" == "Darwin" ]; then
    alias nvim="/usr/local/bin/nvim -u $HOME/.config/neovim/init.vim"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Empty trash.
if [ "$MYOSTYPE" == "Linux" ]; then
    alias empty-trash="rm -rf ~/.local/share/Trash/files/*"
    alias desktop-icons-hide="gsettings set org.gnome.desktop.background show-desktop-icons false"
    alias desktop-icons-hide="gsettings set org.gnome.desktop.background show-desktop-icons true"
elif [ "$MYOSTYPE" == "Darwin" ]; then
    alias empty-trash="sudo rm -frv /Volumes/*/.Trashes; sudo rm -frv ~/.Trash; sudo rm -frv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* "delete from LSQuarantineEvent""
    alias desktop-icons-hide="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
    alias desktop-icons-hide="defaults write com.apple.finder CreateDesktop -bool true  && killall Finder"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Flush dns
if [ "$MYOSTYPE" == "Linux" ]; then
    alias flushdns"sudo systemd-resolve --flush-caches"
elif [ "$MYOSTYPE" == "Darwin" ]; then
    alias flushdns="dscacheutil -flushcache && killall -HUP mDNSResponder"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Lock Screen
if [ "$MYOSTYPE" == "Linux" ]; then
    alias afk="gnome-screensaver-command --lock"
elif [ "$MYOSTYPE" == "Darwin" ]; then
    alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Open command
if [ "$MYOSTYPE" == "Linux" ]; then
    alias o="xdg-open"
elif [ "$MYOSTYPE" == "Darwin" ]; then
    alias o="open"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Clipboard copy
if [ "$MYOSTYPE" == "Linux" ]; then
    alias putclip="xclip -i -sel c"
elif [ "$MYOSTYPE" == "Darwin" ]; then
    alias putclip="tr -d "\n" | pbcopy"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Clipboard paste
if [ "$MYOSTYPE" == "Linux" ]; then
    alias printclip="xclip -o -s"
elif [ "$MYOSTYPE" == "Darwin" ]; then
    alias printclip="tr -d "\n" | pbpaste"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#youtube-dl
if [ -n "$(command -v youtube-dl 2>/dev/null)" ]; then
    alias nightcorea="youtube-dl --extract-audio --audio-format mp3 --embed-thumbnail --add-metadata --audio-quality 320k --config-location $HOME/.config/youtube-dl/nightcorea "
    alias nightcorev="youtube-dl -f bestvideo+bestaudio --config-location $HOME/.config/youtube-dl/nightcorev "
    alias ytv-best="youtube-dl -f bestvideo+bestaudio --config-location $HOME/.config/youtube-dl/music "
    alias yta-aac="youtube-dl --extract-audio --audio-format aac --config-location $HOME/.config/youtube-dl/music "
    alias yta-best="youtube-dl --extract-audio --audio-format best --config-location $HOME/.config/youtube-dl/music "
    alias yta-flac="youtube-dl --extract-audio --audio-format flac --config-location $HOME/.config/youtube-dl/music "
    alias yta-m4a="youtube-dl --extract-audio --audio-format m4a --config-location $HOME/.config/youtube-dl/music "
    alias yta-mp3="youtube-dl --extract-audio --audio-format mp3 --config-location $HOME/.config/youtube-dl/music "
    alias yta-opus="youtube-dl --extract-audio --audio-format opus --config-location $HOME/.config/youtube-dl/music "
    alias yta-vorbis="youtube-dl --extract-audio --audio-format vorbis --config-location $HOME/.config/youtube-dl/music "
    alias yta-wav="youtube-dl --extract-audio --audio-format wav --config-location $HOME/.config/youtube-dl/music "
    alias ytda="youtube-dl -f bestaudio  --extract-audio --audio-format mp3 --config-location $HOME/.config/youtube-dl/music "
    alias ytdv="youtube-dl -f bestvideo+bestaudio --config-location $HOME/.config/youtube-dl/videos "
    alias ytstream="ytstream "
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Media
if [ -n "$(command -v castero 2>/dev/null)" ]; then
    alias podcasts="castero"
fi
if [ -n "$(command -v spotifyd 2>/dev/null)" ]; then
    alias spotify="spotifyd"
fi
if [ -n "$(command -v pianobar 2>/dev/null)" ]; then
    alias pandora="pianobar"
fi
if [ -n "$(command -v tizonia 2>/dev/null)" ]; then
    alias cloudplayer="tizonia"
fi
if [ -n "$(command -v youtube-viewer 2>/dev/null)" ]; then
    alias youtube="youtube-viewer"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# android dev
alias fastboot="sudo fastboot"
alias adb="sudo adb"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Get local IP.
alias myip-local4="myip local 4"
alias myip-local6="myip local 6"
alias myip-public4="myip public 4"
alias myip-public6="myip public 6"
alias myip4="myip 4"
alias myip6=" myip 6"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# netstat aliases
alias ports="sudo netstat -taupln | grep LISTEN"
alias netstat="sudo netstat"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# list functions
alias list-my-functions="typeset -F | less"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#Fun alias
alias tw="rainbowstream -iot"
alias twitter="twitter"
alias mylatlong="mylocation | grep -E "LAT | LON""
alias emj="emojis"
