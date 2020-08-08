#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : osdetect.sh
# @Created     : Mon, Dec 31, 2019, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description :  os detection
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set functions

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set OS TYPE

detectos() {
  OS="$(uname)"
  case $OS in
  'Linux')
    OS='Linux'
    ;;
  'FreeBSD')
    OS='FreeBSD'
    ;;
  'WindowsNT')
    OS='Windows'
    ;;
  'Darwin')
    OS='Mac'
    ;;
  'SunOS')
    OS='Solaris'
    ;;
  'AIX') ;;
  *) ;;
  esac
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#Set OS Detection

detectostype() {
  arch=$(uname -m)
  kernel=$(uname -r)
  if [ -n "$(command -v lsb_release)" ]; then
    distroname=$(lsb_release -s -d)
  elif [ -f "/etc/os-release" ]; then
    distroname=$(grep PRETTY_NAME /etc/os-release | sed 's/PRETTY_NAME=//g' | tr -d '="')
  elif [ -f "/etc/debian_version" ]; then
    distroname="Debian $(cat /etc/debian_version)"
  elif [ -f "/etc/redhat-release" ]; then
    distroname=$(cat /etc/redhat-release)
  else
    distroname="$(uname -s) $(uname -r)"
  fi

  #Various Arch Distros
  if [[ "$distroname" =~ "ArcoLinux" ]] || [[ "$distroname" =~ "Arch" ]] || [[ "$distroname" =~ "BlackArch" ]]; then
    DISTRO=Arch
  #Raspberry pi
  elif [[ "$distroname" =~ "Raspbian" ]]; then
    DISTRO=Raspbian
  #Various RedHat Distros
  elif [[ "$distroname" =~ "Scientific" ]] || [[ "$distroname" =~ "RedHat" ]] || [[ "$distroname" =~ "CentOS" ]] || [[ "$distroname" =~ "Casjay" ]]; then
    DISTRO=RHEL
  #Various Debian Distros
  elif [[ "$distroname" =~ "Kali" ]] || [[ "$distroname" =~ "Parrot" ]] || [[ "$distroname" =~ "Debian" ]]; then
    DISTRO=Debian
    if [[ "$distroname" =~ "Debian" ]]; then
      CODENAME=$(lsb_release -a 2>/dev/null | grep Code | sed 's#Codename:##g' | awk '{print $1}')
    fi
    if [[ "$distroname" =~ "Kali" ]]; then
      CODENAME=kali
    fi
    if [[ "$distroname" =~ "Parrot" ]]; then
      CODENAME=parrot
    fi
  elif [[ "$distroname" =~ "Ubuntu" ]] || [[ "$distroname" =~ "Mint" ]] || [[ "$distroname" =~ "Elementary" ]] || [[ "$distroname" =~ "KDE neon" ]]; then
    DISTRO=Ubuntu
    CODENAME=$(lsb_release -a 2>/dev/null | grep Code | sed 's#Codename:##g' | awk '{print $1}')
  elif [[ "$distroname" =~ "Fedora" ]]; then
    DISTRO=Fedora
  fi

  if [ -f /etc/os-release ]; then
    DISTROID="$(grep ID_LIKE /etc/os-release | sed 's/^.*=//')"
  fi

}

# - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

detectos
detectostype
unset -f detectos detectostype
