# Useful functions {{{

function ef; vim ~/.config/fish/config.fish; end
function ew; vim (which $argv[1]); end
function cw; cat (which $argv[1]); end
function gw; gist (which $argv[1]); end
function eff; vim ~/.config/fish/functions; end
function eg; vim ~/.gitconfig; end
function ev; vim ~/.vimrc; end

function ..;    cd ..; end
function ...;   cd ../..; end
function ....;  cd ../../..; end
function .....; cd ../../../..; end

# I give up
alias :q exit
alias :qa exit

# }}}
# Abbreviations {{{


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

# }}}
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

# }}}
# Environment variables {{{

set -g -x NIX_LINK "$HOME/.nix-profile"

function prepend_to_path -d "Prepend the given dir to PATH if it exists and is not already in it"
    if test -d $argv[1]
        if not contains $argv[1] $PATH
            set -gx PATH "$argv[1]" $PATH
        end
    end
end

set -gx PATH "/sbin"
prepend_to_path "/snap/bin"
prepend_to_path "/usr/sbin"
prepend_to_path "/bin"
prepend_to_path "/usr/bin"
prepend_to_path "/usr/local/bin"
prepend_to_path "/usr/local/go/bin"
prepend_to_path "/usr/local/sbin"
prepend_to_path "/usr/games"
prepend_to_path "$HOME/.local/bin"

set BROWSER open

set -g -x fish_greeting ''
set -g -x EDITOR vim
set -g -x COMMAND_MODE unix2003
set -g -x RUBYOPT rubygems
set -g -x PAGER 'less -X'
set -g -x MAVEN_OPTS "-Xmx2048m -Xss2M -XX:ReservedCodeCacheSize=128m"
# set -g -x _JAVA_OPTIONS "-Djava.awt.headless=true"

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
# Python {{{

set -g -x PIP_DOWNLOAD_CACHE "$HOME/.pip/cache"
set -g -x PYTHONPATH ""
set PYTHONPATH "$PYTHONPATH"

# }}}
# Go {{{

set -g -x GOPATH "$HOME/.go"

# }}}
# Z {{{

. ~/.config/fish/z.fish

# }}}
# Prompt {{{

set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set cyan (set_color cyan)
set gray (set_color -o black)
set hg_promptstring "\
< on $magenta<branch>$normal>\
< at $cyan<bookmark>$normal>\
$green<status|modified|unknown><update>$normal\
" 2>/dev/null

function virtualenv_prompt
    if [ -n "$VIRTUAL_ENV" ]
        printf '(%s) ' (basename "$VIRTUAL_ENV")
    end
end

function hg_prompt
    hg prompt --angle-brackets $hg_promptstring 2>/dev/null
end

function git_prompt
    if git root >/dev/null 2>&1
        set_color normal
        printf ' on '
        set_color magenta
        printf '%s' (git current-branch ^/dev/null)
        set_color green
        git_prompt_status
        set_color normal
    end
end

function prompt_pwd --description 'Print the current working directory, shortend to fit the prompt'
    echo $PWD | sed -e "s|^$HOME|~|"
end

function fish_prompt
    set last_status $status

    echo

    set_color magenta
    printf '%s' (whoami)
    set_color normal
    printf ' at '

    set_color yellow
    printf '%s' (hostname|cut -d . -f 1)
    set_color normal
    printf ' in '

    set_color $fish_color_cwd
    printf '%s' (prompt_pwd)
    set_color normal

    hg_prompt
    git_prompt

    echo

    virtualenv_prompt

    if test $last_status -eq 0
        set_color white -o
        printf '><((°> '
    else
        set_color red -o
        printf '[%d] ><((ˣ> ' $last_status
    end

    set_color normal
end

# }}}
# Local {{{
if test -f $HOME/fish.local
    . $HOME/fish.local
end
# }}}

true
