# Shell-agnostic environment, sourced by every shell via ~/.config/shell/

export LS_COLORS="di=1;35"  # directories bold purple -- eza reads this too

export EDITOR=nvim
# neovide is a GUI client and is not always installed
if command -v neovide >/dev/null 2>&1; then
    export VISUAL=neovide
else
    export VISUAL="$EDITOR"
fi

# Prepend to PATH only when the directory exists and is not already listed.
# The guard matters because .zshenv sources cargo's and bob's own env scripts,
# which add some of these first; without it every login doubles the entries.
_path_prepend() {
    case ":${PATH}:" in
        *":$1:"*) ;;
        *) [ -d "$1" ] && PATH="$1:$PATH" ;;
    esac
}

# some of this borrowed from Distro Tube
_path_prepend "$HOME/.local/bin"
_path_prepend "$HOME/.local/share/bob/nvim-bin"
_path_prepend "$HOME/Applications"
_path_prepend "$HOME/.cargo/bin"

unset -f _path_prepend

### SETTING OTHER ENVIRONMENT VARIABLES
if [ -z "$XDG_CONFIG_HOME" ] ; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi
if [ -z "$XDG_DATA_HOME" ] ; then
    export XDG_DATA_HOME="$HOME/.local/share"
fi
if [ -z "$XDG_CACHE_HOME" ] ; then
    export XDG_CACHE_HOME="$HOME/.cache"
fi
