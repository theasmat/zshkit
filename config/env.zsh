# Environment: Homebrew, PATH, Bun, Android SDK

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

typeset -U path PATH
path=("$HOME/.local/bin" $path)
[[ -r "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"

# Bun
export BUN_INSTALL="${BUN_INSTALL:-$HOME/.bun}"
[[ -d "$BUN_INSTALL/bin" ]] && path=("$BUN_INSTALL/bin" $path)

# Android SDK: first existing location wins
_zshkit_android() {
  emulate -L zsh
  setopt numeric_glob_sort
  local root c d
  for c in "$ANDROID_HOME" "$HOME/Library/Android/sdk" "$HOME/.android/sdk" \
           "$HOME/.local/share/android/sdk" "$HOME/Android/Sdk"; do
    if [[ -n $c && -d $c ]]; then root=$c; break; fi
  done
  [[ -z $root ]] && return 0

  export ANDROID_HOME="$root" ANDROID_SDK_ROOT="$root"

  local -a add latest
  latest=( "$root"/build-tools/*(N/on[-1]) )
  for d in "$root/platform-tools" "$root/emulator" \
           "$root/cmdline-tools/latest/bin" "$root/cmdline-tools/bin" $latest; do
    [[ -d $d ]] && add+=("$d")
  done
  path=($add $path)
}
_zshkit_android
unfunction _zshkit_android
