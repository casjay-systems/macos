#  -*- shell-script -*-

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# export terminal

if [ -z "$TERMINAL" ]; then
    if [ -f "$(command -v termite 2>/dev/null)" ]; then
        TERMINAL="$(command -v termite 2>/dev/null)"
    elif [ -f "$(command -v terminology 2>/dev/null)" ]; then
        TERMINAL="$(command -v terminology 2>/dev/null)"
    elif [ -f "$(command -v xfce4-terminal 2>/dev/null)" ]; then
        TERMINAL="$(command -v xfce4-terminal 2>/dev/null)"
    elif [ -f "$(command -v qterminal-terminal 2>/dev/null)" ]; then
        TERMINAL="$(command -v qterminal-terminal 2>/dev/null)"
    elif [ -f "$(command -v qterminal-terminal 2>/dev/null)" ]; then
        TERMINAL="$(command -v qterminal-terminal 2>/dev/null)"
    elif [ -f "$(command -v xterm 2>/dev/null)" ]; then
        TERMINAL="$(command -v xterm 2>/dev/null)"
    elif [ -f "$(command -v uxterm 2>/dev/null)" ]; then
        TERMINAL="$(command -v uxterm 2>/dev/null)"
    fi
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
