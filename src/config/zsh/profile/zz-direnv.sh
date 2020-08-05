#direnv
if [[ -f "$(command -v direnv)" ]]; then
    eval "$(direnv hook zsh 2>/dev/null)"
fi
