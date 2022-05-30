" Disable compatibility with vi which can cause unexpected issues
set nocompatible

" Enable plugins, load plugin for the detected file type and load an indent file for the detected file type 
filetype off
filetype plugin indent on  " to ignore plugin indent, remove `indent`

set clipboard=unnamedplus  " Copy/paste between vim and other programs

" Turn syntax highlighting on
syntax enable

" Display line numbers
set number

" Set tabs as 4 spaces
set expandtab
set shiftwidth=4
set tabstop=4

set nobackup  " Do not save backup files

" Ignore capital letters during search - unless searching specifically for capital letters
set ignorecase
set smartcase

" Enable auto completion menu after pressing TAB.
set wildmenu

set laststatus=2  " Always show statusline
set showmode  " Show the mode you are on the last line.

let g:lightline = {
    \ 'colorscheme': 'dracula',
    \ }

