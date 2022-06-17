call plug#begin()
    " Git
    "Plug 'airblade/vim-gitgutter'
    Plug 'lewis6991/gitsigns.nvim'

    " Python
    Plug 'davidhalter/jedi-vim'
    Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }

    " Octave
    Plug 'jvirtanen/vim-octave'

    " C/C++
    Plug 'bfrg/vim-cpp-modern'

    " Fuzzy finder
    Plug 'ctrlpvim/ctrlp.vim'

    " Useful aesthetics
    Plug 'jiangmiao/auto-pairs'
    Plug 'vim-airline/vim-airline'
    Plug 'preservim/nerdtree'

    " Themes
    Plug 'navarasu/onedark.nvim'
    Plug 'Mofiqul/dracula.nvim'
    Plug 'gruvbox-community/gruvbox'
call plug#end()

for file in split(glob('~/.config/nvim/vim/plugins/*.vim'), '\n')
    exe 'source' file
endfor

