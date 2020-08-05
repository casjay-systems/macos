#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Variables - Distro specific
if [ -f /usr/bin/pacman ]; then
    distpkmgr="/usr/bin/pacman"
     alias pacman="sudo $distpkmgr"                      #
     alias pacmani="sudo $distpkmgr -S"                  #
     alias pacmanr="sudo $distpkmgr -R"                  #
     alias pacmans="sudo $distpkmgr -Q"                  #
     alias pacmanu="sudo $distpkmgr -Syyu --noconfirm"   #
     alias apt="$distpkmgr"
     alias yum="$distpkmgr"
     alias dnf="$distpkmgr"
     alias unlock="sudo rm /var/lib/pacman/db.lck"
     alias update="sudo /usr/bin/pacman -Syyu"
     alias pksyua="yay -Syu --noconfirm"
     alias upall="yay -Syu --noconfirm"
     alias yayskip='yay -S --mflags --skipinteg'
     alias trizenskip="trizen -S --skipinteg"
     alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
     alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
     alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
     alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"
     alias npacman="sudo vim /etc/pacman.conf"
     alias nmirrorlist="sudo vim /etc/pacman.d/mirrorlist"
elif [ -f /usr/bin/apt ]; then
    distpkmgr=/usr/bin/apt
     alias apt="sudo $distpkmgr"
     alias apti="sudo $distpkmgr install"
     alias aptr="sudo $distpkmgr remove"
     alias apts="sudo $distpkmgr search"
     alias aptu="sudo $distpkmgr update && sudo $distpkmgr dist-upgrade -y"
     alias pacman="$distpkmgr"
     alias dnf="$distpkmgr"
     alias yum="$distpkmgr"
elif [ -f /usr/bin/dnf ]; then
    distpkmgr=/usr/bin/dnf
     alias dnf="sudo $distpkmgr"
     alias dnfi="sudo $distpkmgr install"
     alias dnfr="sudo $distpkmgr remove"
     alias dnfs="sudo $distpkmgr search"
     alias dnfu="sudo $distpkmgr update -y"
     alias pacman="$distpkmgr"
     alias apt="$distpkmgr"
     alias yum="$distpkmgr"
elif [ -f /usr/bin/yum ]; then
    distpkmgr=/usr/bin/yum
     alias yum="sudo $distpkmgr"
     alias yumi="sudo $distpkmgr install"
     alias yumr="sudo $distpkmgr remove"
     alias yums="sudo $distpkmgr search"
     alias yumu="sudo $distpkmgr update -y"
     alias pacman="$distpkmgr"
     alias dnf="$distpkmgr"
     alias apt="$distpkmgr"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
