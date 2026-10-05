# zshkit

A small, git-managed zsh setup for macOS. No Oh My Zsh, no app, no custom CLI: a clone, one idempotent install script, and a few plain config files.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/theasmat/zshkit/main/install.sh | bash
```

Core tools only:

```bash
curl -fsSL https://raw.githubusercontent.com/theasmat/zshkit/main/install.sh | ZSHKIT_MINIMAL=1 bash
```

Homebrew is optional. The script backs up your existing `~/.zshrc`, clones this repo to `~/.config/zshkit`, and points `~/.zshrc` at `config/zshkit.zsh`. Re-running it is safe.

## How tools get installed

The script checks each tool first and skips anything already on your machine, however you installed it. Missing tools are installed with the method each project recommends in its own docs:

| Tool | Job | Install method used | Written in |
| :--- | :--- | :--- | :--- |
| [Starship](https://starship.rs) | Prompt | official install script (to `~/.local/bin`) | Rust |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | Smarter `cd` | official install script | Rust |
| [mise](https://mise.jdx.dev) | Tool versions and env vars | `mise.run` installer, which its docs prefer over Homebrew | Rust |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder | Homebrew if present, else git clone with `install --bin` | Go |
| [Antidote](https://getantidote.github.io) | Plugin manager | git clone to `~/.antidote` | zsh |
| [Atuin](https://atuin.sh) (optional) | Shell history | official release installer, without it editing `~/.zshrc` | Rust |

Optional extras, installed with Homebrew only when it is present: eza, bat, fd, ripgrep, delta. Aliases for eza and bat are only set when installed.

Plugins: zsh-completions, zsh-autosuggestions, zsh-syntax-highlighting.

Also included: Homebrew and PATH setup, plus automatic Android SDK detection (`ANDROID_HOME`, `platform-tools`, `emulator`, `cmdline-tools`, latest `build-tools`).

## Options

| Variable | Effect |
| :--- | :--- |
| `ZSHKIT_MINIMAL=1` | Install core tools only |
| `ZSHKIT_METHOD=brew` | Use `brew install` for every tool instead of official installers |
| `ZSHKIT_HOME` | Install location (default `~/.config/zshkit`) |
| `ZSHKIT_REPO` | Git URL to clone from (useful for forks) |

The variable goes before `bash`, not before `curl`.

## Security note

The script runs each vendor's own installer via `curl | sh`. Read `install.sh` first if you prefer, or use `ZSHKIT_METHOD=brew`.

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
antidote update
mise self-update
exec zsh
```

Update the other tools the way you installed them (for example `brew upgrade`).

## Measure startup

```bash
hyperfine --warmup 3 'zsh -i -c exit'
```

Startup time depends on your machine and extra tools, so run this yourself and compare against your old setup.

## Uninstall

Restore the backup `~/.zshrc.pre-zshkit-*` and delete `~/.config/zshkit`.

## License

MIT
