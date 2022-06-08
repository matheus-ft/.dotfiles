call plug#begin()

" Git
"Plug 'airblade/vim-gitgutter'
Plug 'lewis6991/gitsigns.nvim'

" Python
Plug 'davidhalter/jedi-vim'
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }

" Octave
Plug 'https://github.com/McSinyx/vim-octave.git', {'for': 'octave'}

" Fuzzy finder 
Plug 'ctrlpvim/ctrlp.vim'

" Useful aesthetics
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'

" Themes
Plug 'joshdick/onedark.vim'
Plug 'Mofiqul/dracula.nvim'
Plug 'gruvbox-community/gruvbox'

call plug#end()

filetype plugin indent on

source ~/.config/nvim/lua/git.lua
source ~/.config/nvim/vim/python.vim
source ~/.config/nvim/vim/finder.vim
source ~/.config/nvim/vim/autopairs.vim
source ~/.config/nvim/vim/airline.vim
source ~/.config/nvim/vim/nerdtree.vim
source ~/.config/nvim/vim/themes.vim

