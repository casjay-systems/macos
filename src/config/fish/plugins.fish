#!/usr/bin/env fish

# Ensure oh-my-fish is installed
if test ! -f "$HOME/.config/fish/omf-install" && ! -d "$HOME/.local/share/fish/oh-my-fish"
    curl -LSs https://get.oh-my.fish >"$HOME/.config/fish/omf-install"
    fish "$HOME/.config/fish/omf-install" --noninteractive --yes
    fish -c "$HOME/.config/fish/plugins.fish"
end

fish -c "omf install \
local-config \
autovenv \
coffeeandcode \
fish_logo \
gitstatus \
bobthefish \
fonts \
foreign-env \
https://github.com/edc/bass \
https://github.com/jhillyerd/plugin-git \
https://github.com/h-matsuo/fish-color-scheme-switcher"

fish -c "fonts install --powerline Inconsolata"

fish -c "omf update"
exit 0
