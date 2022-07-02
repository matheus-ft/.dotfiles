""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()
    " Useful things
    Plug 'vim-airline/vim-airline' " status line
    Plug 'preservim/nerdtree' " file tree
    Plug 'jiangmiao/auto-pairs' " automatically add the pairing char for surroundign chars
    Plug 'numToStr/FTerm.nvim' " floating terminal
    Plug 'numToStr/Comment.nvim' " toggle comments easily
    Plug 'tpope/vim-surround' " to change surrounding characters easily

    " Git
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'tpope/vim-fugitive'

    " Language server protocol stuff
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'

    " Sintax highlighting
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " after, relaunch nvim and, for each language, do :TSInstall <language>
    Plug 'romgrk/nvim-treesitter-context' " show context (function, class, conditional, etc.) scope in the top of the file

    " Octave (neovim treesitter don support matlab-like languages apparently)
    Plug 'jvirtanen/vim-octave'
    Plug 'tpope/vim-endwise' " useful for other languages too

    " Markdown, latex, etc.
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

    " Telescope
    Plug 'nvim-lua/plenary.nvim' " dependency
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim' " sorts the findings
    " also install 'github.com/BurntSushi/ripgrep' to use live_grep func

    " Themes
    Plug 'navarasu/onedark.nvim'
    Plug 'gruvbox-community/gruvbox'
call plug#end()

lua require('matheus')

syntax on
filetype plugin indent on
lua require('nvim-treesitter.configs').setup({ highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }})

let g:mkdp_auto_start = 1  " so markdown preview always opens if the filetype is markdown and closes when changing buffers

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remaps
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ' '

" Make splits
nnoremap <leader>v      <C-w>v
nnoremap <leader>s      <C-w>s
nnoremap <leader>o      <C-w>o

" Splits navigation
nnoremap <C-h>          <C-w>h
nnoremap <C-j>          <C-w>j
nnoremap <C-k>          <C-w>k
nnoremap <C-l>          <C-w>l

" Buffer handling
nnoremap <A-h>          :bprevious<CR>
nnoremap <A-l>          :bnext<CR>
nnoremap <leader>c      :bdelete<CR>
nnoremap <leader><S-c>  :bdelete!<CR>
nnoremap <leader><S-q>  :q!<CR>
nnoremap <leader>q      :q<CR>
nnoremap <leader>w      :w<CR>
nnoremap <leader>e      :edit<Space>

" nnoremap <leader>bp     :bprevious<CR>
" nnoremap <leader>bn     :bnext<CR>
" nnoremap <leader>bd     :bdelete<CR>

" Replacing
nnoremap <leader>r      :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

nnoremap <leader><leader> :

" indent/unindent with tab/shift-tab
nnoremap <Tab>          >>
nnoremap <S-tab>        <<
inoremap <S-Tab>        <Esc><<i
vnoremap <Tab>          >gv
vnoremap <S-Tab>        <gv

" Move the page but not the cursor with the arrow keys
nnoremap <Down>  <C-e>
nnoremap <Up>    <C-y>

" Opens line below or above the current line
inoremap <S-CR>  <C-O>o
inoremap <C-CR>  <C-O>O

" Move lines up and down
inoremap <A-j>   <Esc>:m .+1<CR>==gi
inoremap <A-k>   <Esc>:m .-2<CR>==gi
vnoremap <A-j>   :m '>+1<CR>gv=gv
vnoremap <A-k>   :m '<-2<CR>gv=gv

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup MATHEUS_FT
    autocmd!

    " trims all trailing whitespaces on save
    autocmd BufWritePre * %s/\s\+$//e
augroup END

