# Sourced by every zsh, interactive or not. Keep it to environment setup that
# must exist before .zprofile/.zshrc run, and keep every line guarded -- this
# file is shared with machines where these tools are not installed.

# rust toolchain (also puts ~/.cargo/bin on PATH)
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# bob-managed neovim
[ -f "$HOME/.local/share/bob/env/env.sh" ] && . "$HOME/.local/share/bob/env/env.sh"
