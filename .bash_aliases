# Python e C/C++
alias python=python3
alias py3=python3
alias gpp=g++

# General
alias ls='exa -lahF --color=auto'  # change 'exa' to 'ls' if exa isn't installed
alias dir='exa --color=auto'
alias ..='cd ..'
alias clean='sudo apt autoremove && sudo apt autoclean'
alias update='sudo apt update && sudo apt upgrade'
alias upgrade='update && clean'

# Apps
alias ff=firefox
alias top=htop

# DANGEROUS (putting -i flag asks for confirmation)
alias mv='mv -i'
alias rm='rm -i'

# Git to manage dotfiles
alias config='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME' 
