#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# System Aliases
alias q="exit"                                  #vim
alias :q="exit"                                 #vim
alias :q!="exit"                                #vim
alias c="clear"                                 #clear screen
alias ch="history -c && > ~/.bash_history"      #clear history
alias e="/usr/bin/vim --"                       #
alias g="git"                                   #git
alias ll="ls -l"                                #ls list
alias la="ls -a"                                #ls all
alias m="man"                                   #man page
alias map="xargs -n1"                           #map
alias n="npm"                                   #npm
alias path='printf "%b\n" "${PATH//:/\\n}"'     #
alias t="tmux"                                  #tmux
alias bashrc="clear && source ~/.bashrc"        #re-source bashrc
alias inputrc="bind -f ~/.inputrc"              #re-source inputrc
alias tailf="tail -f"                           #tail follow
alias ipconfig="ifconfig"                       #windows fix
alias systemctl="sudo systemctl"                #always sudo systemctl
alias mount='mount -l'                          #mount lists
alias h='history'                               #show history
alias j='jobs -l'                               #list background jobs
alias now='date +"%T"'                          #time now
alias nowtime=now                               #alias for now
alias nowdate='date +"%m-%d-%Y"'                #todays date
alias wget='wget -c'                            #wget continue
alias df='df -H'                                #
alias du='du -ch'                               #disk usuage
alias docker='sudo docker'                      #start docker with sudo
alias dockerrun='sudo docker run --rm --network host -it $1'    #run temporary
alias setver='date +"%m%d%Y%H%M-git"'                           #my versioning to console
alias setverfile='date +"%m%d%Y%H%M-git" > version.txt'         #my versioning to file
alias ssh="ssh -X"                              #ssh with display
alias userlist="cut -d: -f1 /etc/passwd"        #list system users
alias muttsync="__muttsync"                     #sync mail
alias mutt="neomutt"                            #neomutt email
alias histcheck="history|awk '{print \$4}'|sort|uniq -c|sort -n"
alias histcheckarg="history|awk '{print \$4\" \"\$5\" \"\$6\" \"\$7\" \"\$8\" \"\$9\" \"\$10}'|sort|uniq -c|sort -n"
alias sort="LC_ALL=C sort"
alias uniq="LC_ALL=C uniq"
alias lynx="lynx -cfg=$HOME/.config/lynx/lynx.cfg -lss=$HOME/.config/lynx/lynx.lss"

alias ll="ls -l --color=auto" 2>/dev/null
alias l.="ls -d .* --color=auto" 2>/dev/null
alias ls="ls --color=auto" 2>/dev/null
alias grep="grep --color=auto" 2>/dev/null
alias egrep="egrep --color=auto" 2>/dev/null
alias fgrep="fgrep --color=auto" 2>/dev/null

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
