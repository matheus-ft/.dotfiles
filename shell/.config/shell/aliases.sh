# Shell-agnostic aliases, sourced by every shell via ~/.config/shell/

# Programming
alias gpp=g++
alias python=python3
alias activate='source ./.env/bin/activate' # make sure your python venv is call .env

# if using kitty, this should make ssh better
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

# Text editor
alias vim=nvim
# vi is the alias for the pre-installed 'tiny-vim'
alias v=vim


# General
alias so='source'

# eza is the maintained fork of exa, which was archived in 2023
alias ls='eza -lahF --color=auto --icons=auto'
alias dir='eza --color=auto --icons=auto'
alias tree='eza -aT --level=3 --icons=auto'
alias lt='tree --long'
alias l.='eza -a --icons=auto | grep -E "^\."' # find dotfiles
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'


# DANGEROUS (putting -i flag asks for confirmation)
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
