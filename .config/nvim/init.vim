""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()
    " Useful things
    Plug 'vim-airline/vim-airline' " status line
    Plug 'preservim/nerdtree' " file tree
    Plug 'jiangmiao/auto-pairs' " automatically add the pairing char for surroundign chars
    Plug 'numToStr/Comment.nvim' " toggle comments eadily
    Plug 'tpope/vim-surround' " to change surroundign characters easily
    Plug 'numToStr/FTerm.nvim' " floating terminal

    " Git
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'tpope/vim-fugitive'

    " Language server protocol
    Plug 'neovim/nvim-lspconfig'

    " Neovim Tree sitter - sintax highlighting
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " after, relaunch nvim and, for each language, do :TSInstall <language>
    Plug 'romgrk/nvim-treesitter-context' " show context (function, class, conditional, etc.) scope in the top of the file

    " Octave (tree shitter don support matlab-like languages apparently)
    Plug 'jvirtanen/vim-octave'
    Plug 'tpope/vim-endwise' " useful for other languages too

    " Markdown, latex, etc.
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

    " Telescope
    Plug 'nvim-lua/plenary.nvim' " dependency
    Plug 'nvim-telescope/telescope.nvim' " best fuzzy finder ever
    Plug 'nvim-telescope/telescope-fzy-native.nvim' " sorts the findings
    " also install 'github.com/BurntSushi/ripgrep' to use live_grep func

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
nnoremap <leader>bo     <C-w>o

" Buffer navigation
nnoremap <leader>o      <C-o>
nnoremap <leader>e      :edit<Space>
nnoremap <leader>c      :bd<CR>
nnoremap <leader><S-c>  :bd!<CR>
nnoremap <leader><S-q>  :q!<CR>
nnoremap <leader>q      :q<CR>
nnoremap <leader>w      :w<CR>

nnoremap <leader>bd     :bdelete<CR>
nnoremap <leader>bn     :bnext<CR>
nnoremap <leader>bp     :bprevious<CR>

" Tab navigation
nnoremap <leader>tN     :tabnew<Space>
nnoremap <leader>tq     :tabclose<CR>
nnoremap <leader>to     :tabonly<CR>
nnoremap <leader>tn     :tabnext<CR>
nnoremap <leader>tp     :tabprevious<CR>

" Replacing
nnoremap <leader>r      :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" indent/unindent with tab/shift-tab
nnoremap <Tab>          >>
nnoremap <S-tab>        <<
inoremap <S-Tab>        <Esc><<i
vnoremap <Tab>          >gv
vnoremap <S-Tab>        <gv

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup MATHEUS_FT
    autocmd!

    " trims all trailing whitespaces on save
    autocmd BufWritePre * %s/\s\+$//e
augroup END

