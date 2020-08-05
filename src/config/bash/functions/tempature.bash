#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.com
# @File        : Tempature.bash
# @Created     : Mon, Dec 31, 2019, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : tempature conversion
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set functions

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

celsius2f(){
    tf=$(echo "scale=2;((9/5) * $1) + 32" |bc)
    echo $tf
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

f2celcius() {
    tc=$(echo "scale=2;(5/9)*($1-32)"|bc)
    echo $tc
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
