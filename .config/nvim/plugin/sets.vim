" indentation
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set number
set relativenumber  " to easily jump vertically in the file

set hidden  " keeps edited buffers in the background, so there's no need to always save before navigating away from it
set noswapfile
set nobackup

" for searching
set ignorecase smartcase
set incsearch

set scrolloff=8

set signcolumn=yes  " add sidecolumn for git gutter and stuff

set clipboard+=unnamedplus  " to copy and paste easily

set wildmenu

set completeopt=menuone,noinsert,noselect,preview

set title  " to show file name in titlebar

set cmdheight=2  " more space to display messages
