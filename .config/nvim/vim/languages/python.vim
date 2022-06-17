" General settings
setlocal colorcolumn=80
:hi colorcolumn guibg='yellow'
setlocal nowrap

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Jedi settings

" Keybindings
nnoremap <leader>o <C-o>
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#documentation_command = "<leader>k"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"

" opens a new tab when going to definitions
let g:jedi#use_tabs_not_buffers = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Semshi settings

" Personalized syntax highlighting
"function MyCustomHighlights()
    " custom settings
"endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto commands

augroup PYTHON
    autocmd!
    autocmd FileType python let b:AutoPairs = AutoPairsDefine({"f'" : "'", "r'" : "'", "b'" : "'"})
    "autocmd FileType python call MyCustomHighlights()
    "autocmd ColorScheme * call MyCustomHighlights()
augroup END

