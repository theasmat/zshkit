# Tool initialisation (each guarded, so missing tools never break the shell)

command -v starship >/dev/null && eval "$(starship init zsh)"
command -v zoxide   >/dev/null && eval "$(zoxide init zsh)"

# fzf >= 0.48 ships its own zsh integration
if command -v fzf >/dev/null && fzf --zsh >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

# mise: per-project tool versions and env vars (replaces nvm / direnv)
command -v mise >/dev/null && eval "$(mise activate zsh)"

# atuin loads last so it owns Ctrl+R
command -v atuin >/dev/null && eval "$(atuin init zsh --disable-up-arrow)"
