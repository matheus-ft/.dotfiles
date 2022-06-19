""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()
    " Git
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'tpope/vim-fugitive'

    " Python
    Plug 'davidhalter/jedi-vim'
    Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }

    " Octave
    Plug 'jvirtanen/vim-octave'

    " C/C++
    Plug 'bfrg/vim-cpp-modern'

    " Fuzzy finder
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    " Useful aesthetics
    Plug 'jiangmiao/auto-pairs'
    Plug 'vim-airline/vim-airline'
    Plug 'preservim/nerdtree'

    " Themes
    Plug 'navarasu/onedark.nvim'
    Plug 'gruvbox-community/gruvbox'
call plug#end()

syntax on
filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remaps
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ' '

" To move between splits
nnoremap <leader>h    <C-w>h
nnoremap <leader>j    <C-w>j
nnoremap <leader>k    <C-w>k
nnoremap <leader>l    <C-w>l
nnoremap <C-h>        <C-w>h
nnoremap <C-j>        <C-w>j
nnoremap <C-k>        <C-w>k
nnoremap <C-l>        <C-w>l

" To make splits
nnoremap <leader>s    <C-w>s
nnoremap <leader>v    <C-w>v

" There are remaps in ./plugin/nerdtree.vim for the file tree
" There are remaps in ./plugin/python.vim for code navigation

" Tab navigation and exiting
nnoremap <silent><leader><Tab> :tabnext<CR>
nnoremap <leader>tn            :tabnew<Space>
nnoremap <leader>tq            :tabclose<CR>
nnoremap <leader><S-q>         :q!<CR>
nnoremap <leader>q             :q<CR>
nnoremap <leader>z             :wq<CR>
nnoremap <leader>w             :w<CR>

" VS Code like shortcuts for searching, replacing, and cutting
nnoremap <leader>f    /
nnoremap <leader>r    :%s/
vnoremap <leader>x    c<Esc>

" VS Code shortcuts
" Saving
nnoremap <C-s>    :w<CR>
inoremap <C-s>    <Esc>:w<CR>
vnoremap <C-s>    <Esc>:w<CR>
" Undoing
nnoremap <C-z>    :u<CR>
inoremap <C-z>    <Esc>:u<CR>i
vnoremap <C-z>    <Esc>:u<CR>v
" Searching
nnoremap <C-f>    /
inoremap <C-f>    <Esc>/
vnoremap <C-f>    <Esc>/
" Cut - copy/pasteed with clipboard+=unnamedplus in ./vim/sets.vim
vnoremap <C-x>    c<Esc>

" indent/unindent with tab/shift-tab
nnoremap <Tab>      >>
nnoremap <S-tab>    <<
inoremap <S-Tab>    <Esc><<i
vnoremap <Tab>      >gv
vnoremap <S-Tab>    <gv

nnoremap <leader>ff <cmd>Telescope find_files<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup MATHEUS_FT
    autocmd!

    " trims all trailing whitespaces on save
    autocmd BufWritePre * %s/\s\+$//e
augroup END

