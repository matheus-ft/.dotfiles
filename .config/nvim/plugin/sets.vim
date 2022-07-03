" indentation
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set number relativenumber  " to easily jump vertically in the file

set hidden  " keeps edited buffers in the background, so there's no need to always save before navigating away from it
set noswapfile
set nobackup
set undofile
set undodir=~/.vim/undodir

" for searching
set ignorecase smartcase
set incsearch
set nohlsearch

set scrolloff=8

set signcolumn=yes  " add sidecolumn for git gutter and stuff

set clipboard+=unnamedplus  " to copy and paste easily - but will change <C-c> and <C-v> from nvim to <C><S-c> and <C><S-v>

" allows for 'native fuzzy finding' if nvim is opened at project root
set path+=**
set wildmenu

set completeopt=menuone,preview,noinsert

set title  " to show file name in titlebar

set cmdheight=2  " more space to display messages

set splitbelow splitright

