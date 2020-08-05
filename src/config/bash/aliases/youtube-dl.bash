#!/usr/bin/env bash

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
