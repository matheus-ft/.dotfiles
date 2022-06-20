nnoremap <leader>f      :call FindFiles()<CR>
nnoremap <leader>ps     <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>pu     :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader><Tab>  <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>hh     <cmd>lua require('telescope.builtin').help_tags()<cr>

fun! FindFiles()
    silent! !git rev-parse --is-inside-work-tree
    if v:shell_error == 0
        lua require('telescope.builtin').git_files()
    else
        lua require('telescope.builtin').find_files()
    endif
endfun

