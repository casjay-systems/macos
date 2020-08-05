#  -*- shell-script -*-

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# export browser

if [ -z "$BROWSER" ]; then
    if [ -f "$(command -v garcon-url-handler 2>/dev/null)" ]; then
        export BROWSER="$(command -v garcon-url-handler) --url $@"
    elif [ -f "$(command -v firefox 2>/dev/null)" ]; then
        export BROWSER="$(command -v firefox 2>/dev/null)"
    elif [ -f "$(command -v chromium 2>/dev/null)" ]; then
        export BROWSER="$(command -v chromium 2>/dev/null)"
    elif [ -f "$(command -v google-chrome 2>/dev/null)" ]; then
        export BROWSER="$(command -v google-chrome 2>/dev/null)"
    elif [ -f "(command -v opera)" ]; then
        export BROWSER="(command -v opera)"
    elif [ -f "$(command -v epiphany-browser 2>/dev/null)" ]; then
        export BROWSER="(command -v epiphany-browser)"
    elif [ -f "$(command -v falkon 2>/dev/null)" ]; then
        export BROWSER="(command -v falkon)"
    elif [ -f "$(command -v midori 2>/dev/null)" ]; then
        export BROWSER="(command -v midori)"
    elif [ -f "$(command -v netsurf 2>/dev/null)" ]; then
        export BROWSER="(command -v netsurf)"
    elif [ -f "$(command -v surf 2>/dev/null)" ]; then
        export BROWSER="(command -v surf)"
    elif [ -f "$(command -v arora 2>/dev/null)" ]; then
        export BROWSER="(command -v arora)"
    elif [ -f "$(command -v lynx 2>/dev/null)" ]; then
        export BROWSER="(command -v lynx)"
    elif [ -f "$(command -v links 2>/dev/null)" ]; then
        export BROWSER="(command -v links)"
    fi
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
