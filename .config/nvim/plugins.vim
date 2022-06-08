call plug#begin()

" Useful aesthetics
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'

" Git
"Plug 'airblade/vim-gitgutter'
Plug 'lewis6991/gitsigns.nvim'

" Python
Plug 'davidhalter/jedi-vim'
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }

" Octave
Plug 'https://github.com/McSinyx/vim-octave.git', {'for': 'octave'}

" Themes
Plug 'joshdick/onedark.vim'
Plug 'Mofiqul/dracula.nvim'
Plug 'gruvbox-community/gruvbox'

call plug#end()

filetype plugin indent on

source ~/.config/nvim/vim/airline.vim
source ~/.config/nvim/vim/nerdtree.vim
source ~/.config/nvim/lua/git.lua
source ~/.config/nvim/vim/python.vim
source ~/.config/nvim/vim/themes.vim

