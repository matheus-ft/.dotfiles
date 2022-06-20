""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()
    " Git
    Plug 'lewis6991/gitsigns.nvim'

    " TPOPE
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-endwise'
    Plug 'tpope/vim-commentary'

    " Floating terminal
    Plug 'numToStr/FTerm.nvim'

    " Text: markdown, latex
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
    "Plug 'lervag/vimtex'

    " Python
    Plug 'davidhalter/jedi-vim'

    " Octave
    Plug 'jvirtanen/vim-octave'

    " C/C++
    Plug 'bfrg/vim-cpp-modern'

    " Neovim Tree sitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/playground'
    Plug 'romgrk/nvim-treesitter-context'
    " after, relaunch nvim and, for each language, do :TSInstall <language>

    " Telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'
    " also install 'github.com/BurntSushi/ripgrep'

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
lua require('nvim-treesitter.configs').setup({ highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }})
let g:mkdp_auto_start = 1  " so markdown preview always opens if the filetype is markdown and closes when changing buffers

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remaps
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ' '

" There are remaps in ./plugin/telescope.vim for fuzzy finding
" There are remaps in ./plugin/nerdtree.vim for the file tree
" There are remaps in ./plugin/python.vim for code navigation

" Splits navigation
nnoremap <leader>s      <C-w>s<C-w>j
nnoremap <leader>v      <C-w>v<C-w>l
nnoremap <leader>h      <C-w>h
nnoremap <leader>j      <C-w>j
nnoremap <leader>k      <C-w>k
nnoremap <leader>l      <C-w>l
nnoremap <C-h>          <C-w>h
nnoremap <C-j>          <C-w>j
nnoremap <C-k>          <C-w>k
nnoremap <C-l>          <C-w>l
nnoremap <leader>so     <C-w>o

" Tab navigation
nnoremap <leader>tn     :tabnew<Space>
nnoremap <leader>tq     :tabclose<CR>
nnoremap <leader>to     :tabonly<CR>

" Buffer navigation
nnoremap <leader>o      <C-o>
nnoremap <leader>e      :edit<Space>
nnoremap <leader>c      :bd<CR>
nnoremap <leader><S-c>  :bd!<CR>
nnoremap <leader><S-q>  :q!<CR>
nnoremap <leader>q      :q<CR>
nnoremap <leader>z      :w<CR>
nnoremap <leader>w      :w<CR>

nnoremap <leader>bb     <C-o>
nnoremap <leader>bd     :bd<CR>

" Replacing
nnoremap <leader>r      :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" indent/unindent with tab/shift-tab
nnoremap <Tab>      >>
nnoremap <S-tab>    <<
inoremap <S-Tab>    <Esc><<i
vnoremap <Tab>      >gv
vnoremap <S-Tab>    <gv

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup MATHEUS_FT
    autocmd!

    " trims all trailing whitespaces on save
    autocmd BufWritePre * %s/\s\+$//e
augroup END

