lua require('matheus')

nnoremap <leader>pf :lua require('matheus.telescope-config').project_files()<CR>
nnoremap <leader>ps :lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>pu :lua require('telescope.builtin').grep_string { search = vim.fn.expand('<cword>') }<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>a  :lua require('telescope.builtin').help_tags()<CR>

