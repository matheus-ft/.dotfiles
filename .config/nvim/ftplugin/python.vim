" General settings
setlocal colorcolumn=80
:hi colorcolumn guibg='yellow'
setlocal nowrap
let b:AutoPairs = AutoPairsDefine({"f'" : "'", "r'" : "'", "b'" : "'"})
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Jedi settings

" Keybindings
let b:jedi#goto_command = "<leader>d"
let b:jedi#goto_assignments_command = "<leader>g"
let b:jedi#documentation_command = "K"
let b:jedi#usages_command = "<leader>n"
let b:jedi#completions_command = "<C-Space>"
let b:jedi#rename_command = "<leader><S-r>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

