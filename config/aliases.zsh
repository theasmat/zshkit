alias reload='exec zsh'
alias c='clear'
alias zshconfig='cd "${ZSHKIT_HOME:-$HOME/.config/zshkit}"'

alias gs='git status -sb'
alias gl='git log --oneline --graph --decorate -20'
alias gd='git diff'

if command -v eza >/dev/null; then
  alias ls='eza --group-directories-first'
  alias ll='eza -lah --git --group-directories-first'
fi
command -v bat >/dev/null && alias cat='bat --paging=never'
