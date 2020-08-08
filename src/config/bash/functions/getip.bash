#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : getip.bash
# @Created     : Mon, Dec 31, 2019, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : get ip address
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

__getip() {
unset -f IFCONFIG NETDEV IFISONLINE CURRIP4 CURRIP6 CURRIP4WAN CURRIP6WAN
IFCONFIG="$(command -v ifconfig 2> /dev/null)"
if [ ! -z "$IFCONFIG" ]; then
   NETDEV="$(ip route | grep default | sed -e "s/^.*dev.//" -e "s/.proto.*//")"
   CURRIP4="$(/sbin/ifconfig $NETDEV | grep -E "venet|inet" | grep -v "127.0.0." | grep inet | grep -v 'inet6' | awk '{print $2}' | sed 's#addr:##g' | head -n1)"
   CURRIP6="$(/sbin/ifconfig $NETDEV | grep -E "venet|inet" | grep -v "docker" | grep inet6 |  grep -i 'global' | awk '{print $2}' | head -n1)"
 IFISONLINE="$(timeout 0.2 ping -c1 8.8.8.8 &> /dev/null ; echo $?)"
  if [ "$IFISONLINE" -eq "0" ]; then
    CURRIP4WAN="$(curl -I4qs 2>/dev/null ifconfig.co/ip | head -1 | grep 404 >/dev/null && if [ $? == 0 ] ; then curl -4qs ifconfig.co/ip 2>/dev/null; fi)"
    CURRIP6WAN="$(curl -I6qs 2>/dev/null ifconfig.co/ip | head -1 | grep 404 >/dev/null && if [ $? == 0 ] ; then curl -6qs ifconfig.co/ip 2>/dev/null; fi)"
  fi
unset -f IFCONFIG NETDEV IFISONLINE
fi
}
__getip

#---------------------------------------------------------------------------------------

# end
#/* vim: set expandtab ts=4 noai
