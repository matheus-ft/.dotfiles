# sources the shell agnostic configs
if [ -d ~/.config/shell ]; then
    for rc in ~/.config/shell/*; do
        if [ -f "$rc" ]; then
            source "$rc"
        fi
    done
fi

# zsh can hint the vim mode, so this is very practical
bindkey -v

# next level tab completion
autoload -U compinit
compinit

SHELL=/usr/bin/zsh # this is here just so that nvim opens zsh

