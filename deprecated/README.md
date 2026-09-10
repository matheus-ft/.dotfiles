# Deprecated

Kept for reference, not stowed anywhere.

## bash

Bash is no longer used interactively, so its config is parked here rather than
maintained. `.bash_aliases` and `.bashrc.d/finish.sh` were the distro-agnostic
loader pair (Ubuntu reads the file, Fedora reads the directory), and
`starship.toml` was the bash prompt -- zsh uses Powerlevel10k instead, which is
why starship never applied on this machine.

The shell-agnostic half of the old bash package was *not* deprecated: it moved to
the `shell` package at the repo root and is still sourced by zsh.

To bring bash back:

```bash
stow --dir=~/.dotfiles/deprecated --target=~ bash
```
