#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#Media players

if [ -n "$(command -v castero 2>/dev/null)" ]; then alias podcasts="castero" ; fi
if [ -n "$(command -v spotifyd 2>/dev/null)" ]; then alias spotify="spotifyd" ; fi
if [ -n "$(command -v pianobar 2>/dev/null)" ]; then alias pandora="pianobar" ; fi
if [ -n "$(command -v tizonia 2>/dev/null)" ]; then alias cloudplayer="tizonia" ; fi
if [ -n "$(command -v youtube-viewer 2>/dev/null)" ]; then alias youtube="youtube-viewer" ;fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
