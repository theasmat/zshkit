# zshkit

A small, git-managed zsh setup for macOS. No Oh My Zsh, no app, no custom CLI: a clone, one idempotent install script, and a few plain config files.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/theasmat/zshkit/main/install.sh | bash
```

Requires [Homebrew](https://brew.sh). Set `ZSHKIT_MINIMAL=1` to install only the core tools.

The script backs up your existing `~/.zshrc`, clones this repo to `~/.config/zshkit`, and points `~/.zshrc` at `config/zshkit.zsh`. Re-running it is safe.

## What you get

| Tool | Job | Written in |
| :--- | :--- | :--- |
| [Starship](https://starship.rs) | Prompt | Rust |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | Smarter `cd` | Rust |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder | Go |
| [Antidote](https://getantidote.github.io) | Plugin manager (compiles to a static file) | zsh |
| [mise](https://mise.jdx.dev) | Per-project tool versions and env vars | Rust |

Optional (skipped with `ZSHKIT_MINIMAL=1`): [atuin](https://github.com/atuinsh/atuin), eza, bat, fd, ripgrep, delta. Aliases for eza and bat are only set when installed.

Plugins: zsh-completions, zsh-autosuggestions, zsh-syntax-highlighting.

Also included: Homebrew and PATH setup, plus automatic Android SDK detection (`ANDROID_HOME`, `platform-tools`, `emulator`, `cmdline-tools`, latest `build-tools`).

## Layout

```text
install.sh            bootstrap
config/
  zshkit.zsh          master loader
  options.zsh         history and shell options
  env.zsh             PATH, Homebrew, Bun, Android SDK
  plugins.txt         Antidote manifest
  tools.zsh           starship, zoxide, fzf, mise, atuin
  aliases.zsh         shortcuts
custom.zsh            your overrides (git-ignored, created on install)
```

## Customise

Put personal aliases, tokens and functions in `~/.config/zshkit/custom.zsh`. It is git-ignored and sourced last, so `git pull` never conflicts.

## Update

```bash
cd ~/.config/zshkit && git pull
brew upgrade
antidote update
exec zsh
```

## Measure startup

```bash
brew install hyperfine
hyperfine --warmup 3 'zsh -i -c exit'
```

Startup time depends on your machine and extra tools, so run this yourself and compare against your old setup.

## Uninstall

Restore the backup `~/.zshrc.pre-zshkit-*` and delete `~/.config/zshkit`.

## License

MIT
