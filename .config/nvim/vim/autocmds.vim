filetype plugin indent on

augroup MATHEUS_FT
    autocmd!
    autocmd BufWritePre *       :call TrimWhitespace()
    autocmd Filetype python     source ~/.config/nvim/vim/languages/python.vim
    autocmd FileType c,c++      source ~/.config/nvim/vim/languages/cpp.vim
augroup END

fun! TrimWhitespace()
    " trims all trailing whitespaces on save
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

