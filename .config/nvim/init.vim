set exrc 

" indentation
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
map <S-Tab> <<

set number

set hidden  " hides recovery menu or sth like that

" for searching
set ignorecase smartcase
set incsearch

set scrolloff=8

set signcolumn=yes  " add sidecolumn for git gutter and stuff

" control line length
set nowrap
set colorcolumn=80

set clipboard+=unnamedplus  " to copy and paste easily

set completeopt=menuone,noinsert,noselect,preview

set title  " to show file name in titlebar

" Syntax
filetype plugin indent on
syntax on

" plugins - using Vim-plug
call plug#begin()
" Useful aesthetics
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'

" Languages
Plug 'davidhalter/jedi-vim'

" Themes
Plug 'joshdick/onedark.vim'
Plug 'Mofiqul/dracula.nvim'
Plug 'gruvbox-community/gruvbox'
call plug#end()

map <F5> :NERDTreeToggle<CR>
map <F6> :NERDTree<CR>

" to see git changes asap
let g:gitgutter_realtime=1
let g:gitgutter_eager=1

" changes the gitgutter signs (using unicode)
let g:gitgutter_sign_added = '🟩'
let g:gitgutter_sign_modified = '🟦'
let g:gitgutter_sign_removed = '🔻'
let g:gitgutter_sign_modified_removed = '🟪'

colorscheme onedark

