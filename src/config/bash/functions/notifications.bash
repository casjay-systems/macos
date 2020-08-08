#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : notifications.bash
# @Created     : Mon, Dec 31, 2019, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : send notifications via notify-send
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

notifications() { 
    [ -z "$1" ] && [ -z "$2" ] && printf_help 'Usage: notifications "title" "message"'
    local title="$1" ; shift 1
    local msg="$@" ; shift
    cmd_exists notify-send && notify-send -u normal -i "notification-message-IM" "$title" "$msg" || return 0
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# end
#/* vi: set expandtab ts=4 noai
