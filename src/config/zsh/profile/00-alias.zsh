# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# CD Aliases
alias ~="cd $HOME"       #cd home
alias ..="cd .."         #cd fix
alias ...="cd ../.."     #cd fix
alias ....="cd ../../.." #cd fix
alias cd..="cd .."       #cd fix

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# System Aliases
alias q="exit"                                               #vim
alias :q="exit"                                              #vim
alias :q!="exit"                                             #vim
alias c="clear"                                              #clear screen
alias ch="history -c && > ~/.bash_history"                   #clear history
alias e="/usr/bin/vim --"                                    #
alias g="git"                                                #git
alias ll="ls -l"                                             #ls list
alias la="ls -a"                                             #ls all
alias m="man"                                                #man page
alias map="xargs -n1"                                        #map
alias n="npm"                                                #npm
alias path='printf "%b\n" "${PATH//:/\\n}"'                  #
alias t="tmux"                                               #tmux
alias bashrc="clear && source ~/.bashrc"                     #re-source bashrc
alias inputrc="bind -f ~/.inputrc"                           #re-source inputrc
alias tailf="tail -f"                                        #tail follow
alias ipconfig="ifconfig"                                    #windows fix
alias systemctl="sudo systemctl"                             #always sudo systemctl
alias mount='mount -l'                                       #mount lists
alias h='history'                                            #show history
alias j='jobs -l'                                            #list background jobs
alias now='date +"%T"'                                       #time now
alias nowtime=now                                            #alias for now
alias nowdate='date +"%m-%d-%Y"'                             #todays date
alias wget='wget -c'                                         #wget continue
alias df='df -H'                                             #
alias du='du -ch'                                            #disk usuage
alias docker='sudo docker'                                   #start docker with sudo
alias dockerrun='sudo docker run --rm --network host -it $1' #run temporary
alias setver='date +"%m%d%Y%H%M-git"'                        #my versioning to console
alias setverfile='date +"%m%d%Y%H%M-git" > version.txt'      #my versioning to file
alias ssh="ssh -X"                                           #ssh with display
alias userlist="cut -d: -f1 /etc/passwd"                     #list system users
alias muttsync="__muttsync"                                  #sync mail
alias mutt="neomutt"                                         #neomutt email
alias histcheck="history|awk '{print \$4}'|sort|uniq -c|sort -n"
alias histcheckarg="history|awk '{print \$4\" \"\$5\" \"\$6\" \"\$7\" \"\$8\" \"\$9\" \"\$10}'|sort|uniq -c|sort -n"
alias sort="LC_ALL=C sort"
alias uniq="LC_ALL=C uniq"
alias lynx="lynx -cfg=$HOME/.config/lynx/lynx.cfg -lss=$HOME/.config/lynx/lynx.lss"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#Set vim as default
alias vi="/usr/local/bin/vim"          #vim
alias vim="/usr/local/bin/vim"         #vim
alias svi="sudo /usr/local/bin/vim"    #start vim with sudo
alias vis="/usr/bin/local/vim +set si" #

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#Set neovim
alias nvim="/usr/local/bin/nvim -u $HOME/.config/neovim/init.vim"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Lock screen.
alias afk="gnome-screensaver-command --lock" #lock screen

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

# Empty trash.
alias empty-trash="rm -rf ~/.local/share/Trash/files/*" #Delete old files

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Hide/Show desktop icons.
alias desktop-icons-hide="gsettings set org.gnome.desktop.background show-desktop-icons false"
alias desktop-icons-show="gsettings set org.gnome.desktop.background show-desktop-icons true"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Open from the terminal.
alias o="xdg-open"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# netstat aliases
alias ports="sudo netstat -taupln | grep LISTEN"
alias netstat="sudo netstat"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#Andriod adb/fastboot
alias fastboot="sudo fastboot"
alias adb="sudo adb"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
