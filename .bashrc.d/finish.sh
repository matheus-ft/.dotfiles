if [ -d ~/.config/shell ]; then
    for rc in ~/.config/shell/*; do
        if [ -f "$rc" ]; then
            source "$rc"
        fi
    done
fi

eval "$(starship init bash)"
set -o vi

