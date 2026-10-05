# zshkit master loader (sourced from ~/.zshrc)
ZSHKIT_ROOT="${0:A:h}"
ZSHKIT_HOME="${ZSHKIT_ROOT:h}"

source "$ZSHKIT_ROOT/options.zsh"
source "$ZSHKIT_ROOT/env.zsh"

# Plugins: antidote (git install or Homebrew) compiles plugins.txt into plugins.zsh
_zk_antidote=""
for _zk_c in "$HOME/.antidote/antidote.zsh" \
             "${HOMEBREW_PREFIX:-/opt/homebrew}/opt/antidote/share/antidote/antidote.zsh"; do
  if [[ -r $_zk_c ]]; then _zk_antidote=$_zk_c; break; fi
done
if [[ -n $_zk_antidote ]]; then
  source "$_zk_antidote"
  _zk_txt="$ZSHKIT_ROOT/plugins.txt"
  _zk_zsh="$ZSHKIT_ROOT/plugins.zsh"
  if [[ ! -s $_zk_zsh || $_zk_txt -nt $_zk_zsh ]]; then
    antidote bundle < "$_zk_txt" >| "$_zk_zsh"
  fi
  source "$_zk_zsh"
fi
unset _zk_antidote _zk_c _zk_txt _zk_zsh

# Completion: full rebuild at most once per 24h, cached otherwise
_zshkit_compinit() {
  emulate -L zsh
  setopt extended_glob
  local dump="${XDG_CACHE_HOME:-$HOME/.cache}/zshkit/zcompdump"
  mkdir -p "${dump:h}"
  autoload -Uz compinit
  if [[ -n $dump(#qN.mh+24) ]]; then
    compinit -d "$dump"
  else
    compinit -C -d "$dump"
  fi
}
_zshkit_compinit
unfunction _zshkit_compinit

source "$ZSHKIT_ROOT/tools.zsh"
source "$ZSHKIT_ROOT/aliases.zsh"

# Personal overrides (git-ignored)
[[ -r "$ZSHKIT_HOME/custom.zsh" ]] && source "$ZSHKIT_HOME/custom.zsh"
