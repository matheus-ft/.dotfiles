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
alias ls='exa -lahF --color=auto --icons'
alias dir='exa --color=auto --icons'
alias tree='exa -aT --level=3 --icons'
alias lt='tree --long --icons'
alias l.='exa -a --icons | egrep "^\."' # find dotfiles
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'


# DANGEROUS (putting -i flag asks for confirmation)
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'


# Git bare alias to manage dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

