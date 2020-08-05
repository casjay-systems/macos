#  -*- shell-script -*-

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# export torrent client

if [ -f "$(command -v transmission-remote-gtk 2>/dev/null)" ]; then
  export TORRENT="$(command -v transmission-remote-gtk 2>/dev/null)"
elif [ -f "$(command -v transmission-remote-cli 2>/dev/null)" ]; then
  export TORRENT="$(command -v transmission-remote-cli 2>/dev/null)"
elif [ -f "$(command -v transmission-gtk 2>/dev/null)" ]; then
  export TORRENT="$(command -v transmission-gtk 2>/dev/null)"
elif [ -f "$(command -v transmission-qt 2>/dev/null)" ]; then
  export TORRENT="$(command -v transmission-qt 2>/dev/null)"
elif [ -f "$(command -v deluge 2>/dev/null)" ]; then
  export TORRENT="$(command -v deluge 2>/dev/null)"
elif [ -f "$(command -v vuze 2>/dev/null)" ]; then
  export TORRENT="$(command -v vuze 2>/dev/null)"
elif [ -f "(command -v qbittorrent)" ]; then
  export TORRENT="(command -v qbittorrent 2>/dev/null)"
elif [ -f "$(command -v ktorrent 2>/dev/null)" ]; then
  export TORRENT="(command -v ktorrent 2>/dev/null)"
elif [ -f "$(command -v ctorrent 2>/dev/null)" ]; then
  export TORRENT="(command -v ctorrent 2>/dev/null)"
elif [ -f "$(command -v unworkable 2>/dev/null)" ]; then
  export TORRENT="(command -v unworkable 2>/dev/null)"
elif [ -f "$(command -v rtorrent 2>/dev/null)" ]; then
  export TORRENT="(command -v rtorrent 2>/dev/null)"
elif [ -f "$(command -v bitstormlite 2>/dev/null)" ]; then
  export TORRENT="(command -v bitstormlite 2>/dev/null)"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
