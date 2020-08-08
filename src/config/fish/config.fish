#!/usr/bin/env fish
#
# Ensure oh-my-fish is installed
#if test ! -d ~/.local/share/fish/oh-my-fish/.git
#    curl -LSsq https://get.oh-my.fish > ~/.config/fish/omf-install
#    fish ~/.config/fish/omf-install --path=~/.local/share/fish/oh-my-fish --config=~/.config/fish/omf --noninteractive --yes
#end

# create dirs

mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/nvm"
mkdir -p "$HOME/.local/log"

if test -f "$HOME/.sudo"
    rm -Rf "$HOME/.sudo"
end

# Useful functions {{{
function fish_greeting
#  echo "I'm completely operational, and all my circuits are functioning perfectly."
end

# }}}
# Abbreviations {{{

if test -f "$HOME/.config/fish/profile/00-aliases.fish"
    . "$HOME/.config/fish/profile/00-aliases.fish"
end

# }}}
# Completions {{{

function make_completion --argument alias command
    complete -c $alias -xa "(
        set -l cmd (commandline -pc | sed -e 's/^ *\S\+ *//' );
        complete -C\"$command \$cmd\";
    )"
end

complete -c s -w ssh
complete -c cw -w which
complete -c ew -w which
complete -c gw -w which

# Bind Keys {{{

# Backwards compatibility?  Screw that, it's more important that our function
# names have underscores so they look pretty.
function jesus_fucking_christ_bind_the_fucking_keys_fish
    bind \cn accept-autosuggestion
    bind \cw backward-kill-word
end

function fish_user_keybindings
    jesus_fucking_christ_bind_the_fucking_keys_fish
end

function fish_user_key_bindings
    jesus_fucking_christ_bind_the_fucking_keys_fish
end

# Environment variables {{{

function prepend_to_path -d "Prepend the given dir to PATH if it exists and is not already in it"
    if test -d $argv[1]
        if not contains $argv[1] $PATH
            set -gx PATH "$argv[1]" $PATH
        end
    end
end

set -g -x EDITOR vim
set -g -x COMMAND_MODE unix2003
set -g -x RUBYOPT rubygems
set -g -x PAGER 'less -X'
set -g -x MAVEN_OPTS "-Xmx2048m -Xss2M -XX:ReservedCodeCacheSize=128m"
set -g -x _JAVA_OPTIONS "-Djava.awt.headless=true"
set -g -x NVM_DIR "$HOME/.local/share/nvm"
set -g -x NVM_BIN "$HOME/.local/bin"

set -g -x GPG_TTY (tty)

# Less Colors for Man Pages
set -g -x LESS_TERMCAP_mb (printf '\e[01;31m')       # begin blinking
set -g -x LESS_TERMCAP_md (printf '\e[01;38;5;74m')  # begin bold
set -g -x LESS_TERMCAP_me (printf '\e[0m')           # end mode
set -g -x LESS_TERMCAP_se (printf '\e[0m')           # end standout-mode
set -g -x LESS_TERMCAP_so (printf '\e[38;5;246m')    # begin standout-mode - info box
set -g -x LESS_TERMCAP_ue (printf '\e[0m')           # end underline
set -g -x LESS_TERMCAP_us (printf '\e[04;38;5;146m') # begin underline

# }}}

# Go {{{

set -g -x GOPATH "$HOME/.go"

# }}}

# }}}
# Z {{{

. ~/.config/fish/z.fish

# }}}

# Theme {{{
set -x VIRTUAL_ENV_DISABLE_PROMPT 1
set -g theme_display_git yes
set -g theme_display_git_dirty yes
set -g theme_display_git_untracked yes
set -g theme_display_git_ahead_verbose yes
set -g theme_display_git_dirty_verbose yes
set -g theme_display_git_stashed_verbose yes
set -g theme_display_git_master_branch yes
set -g theme_git_worktree_support yes
set -g theme_use_abbreviated_branch_name no
set -g theme_display_vagrant yes
set -g theme_display_docker_machine yes
set -g theme_display_k8s_context yes
set -g theme_display_hg yes
#set -g theme_display_virtualenv yes
set -g theme_display_ruby yes
#set -g theme_display_nvm yes
set -g theme_display_user yes
set -g theme_display_hostname yes
set -g theme_display_vi yes
set -g theme_display_date yes
set -g theme_display_cmd_duration yes
set -g theme_title_display_process yes
set -g theme_title_display_path yes
set -g theme_title_display_user yes
set -g theme_title_use_abbreviated_path no
set -g theme_date_format "+%a %H:%M"
set -g theme_avoid_ambiguous_glyphs yes
set -g theme_powerline_fonts yes
set -g theme_nerd_fonts yes
set -g theme_show_exit_status no
set -g theme_display_jobs_verbose no
set -g default_user your_normal_user
set -g theme_color_scheme dark
set -g fish_prompt_pwd_dir_length 0
set -g theme_project_dir_length 0
set -g theme_newline_cursor yes
set -g theme_newline_prompt ' ><((°>)) 🐧 '

# direnv
direnv hook fish | source

# sxhkd fix
set -U SXHKD_SHELL sh

# local {{{
if test -f "$HOME/.config/local/fish.local"
    . "$HOME/.config/local/fish.local"
end

if test -f "$HOME/.config/local/fish.(hostname -s).local"
    . "$HOME/.config/local/fish.(hostname -s).local"
end
# }}}

true
