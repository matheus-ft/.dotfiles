if [ -d ~/.config/shell ]; then
    for rc in ~/.config/shell/*; do
        if [ -f "$rc" ]; then
            source "$rc"
        fi
    done
fi

eval "$(starship init zsh)"
set -o vi # starship kinda hints the mode, so vim bindings are cool

