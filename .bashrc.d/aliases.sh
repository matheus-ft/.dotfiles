# Programming
alias python=python3
alias py3=python3
alias gpp=g++
alias nvim=~/Applications/nvim.appimage
alias vim=nvim
alias v=nvim


# General
alias ls='exa -lahF --color=auto'
alias dir='exa --color=auto'
alias tree='exa --tree --level=3 -F'
alias ltree='tree --long'
alias lt=ltree
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias clean='sudo apt autoremove && sudo apt autoclean'
alias update='sudo apt update && sudo apt upgrade'
alias upgrade='update && clean'
alias full-update='sudo apt update && sudo apt dist-upgrade'
alias full-upgrade='full-update && clean'


# Apps
alias ff='firefox &'


# DANGEROUS (putting -i flag asks for confirmation)
alias mv='mv -i'
alias rm='rm -i'


# Git bare alias to manage dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'


# View the calender by typing the first three letters of the month.
alias jan='cal -m 01'
alias feb='cal -m 02'
alias mar='cal -m 03'
alias apr='cal -m 04'
alias may='cal -m 05'
alias jun='cal -m 06'
alias jul='cal -m 07'
alias aug='cal -m 08'
alias sep='cal -m 09'
alias oct='cal -m 10'
alias nov='cal -m 11'
alias dec='cal -m 12'

