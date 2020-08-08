#!/usr/bin/env fish

# Ensure oh-my-fish is installed
if test ! -d ~/.local/share/fish/oh-my-fish/.git
    curl -LSsq https://get.oh-my.fish > ~/.config/fish/omf-install
    fish ~/.config/fish/omf-install --path=~/.local/share/fish/oh-my-fish --config=~/.config/fish/omf --noninteractive --yes
    fish ~/.config/fish/plugins.fish
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
