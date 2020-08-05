#  -*- shell-script -*-

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# export editor

if [ -f "$(command -v vim 2>/dev/null)" ]; then
  EDITOR="$(command -v vim 2>/dev/null)"
elif [ -f "$(command -v nvim 2>/dev/null)" ]; then
  EDITOR="$(command -v nvim 2>/dev/null)"
elif [ -f "$(command -v geany 2>/dev/null)" ]; then
  EDITOR="$(command -v geany 2>/dev/null)"
elif [ -f "$(command -v gedit 2>/dev/null)" ]; then
  EDITOR="$(command -v gedit 2>/dev/null)"
elif [ -f "$(command -v vscode 2>/dev/null)" ]; then
  EDITOR="$(command -v vscode 2>/dev/null)"
elif [ -f "$(command -v atom 2>/dev/null)" ]; then
  EDITOR="$(command -v atom 2>/dev/null)"
elif [ -f "$(command -v brackets 2>/dev/null)" ]; then
  EDITOR="$(command -v brackets 2>/dev/null)"
elif [ -f "$(command -v emacs 2>/dev/null)" ]; then
  EDITOR="$(command -v emacs 2>/dev/null)"
elif [ -f "$(command -v mousepad 2>/dev/null)" ]; then
  EDITOR="$(command -v mousepad 2>/dev/null)"
elif [ -f "$(command -v nano 2>/dev/null)" ]; then
  EDITOR="$(command -v nano 2>/dev/null)"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
