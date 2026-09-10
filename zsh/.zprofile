# Login shells only.

# Homebrew. macOS/Apple Silicon path; the guard keeps this inert on Linux.
[ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv zsh)"
