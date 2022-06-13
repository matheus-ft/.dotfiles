" CtrlP config

let g:ctrlp_by_filename = 1  " search for filename, not full path
let g:ctrlp_show_hidden = 1  " to also show dotfiles and dotfolders

" new keybindings
"   Enter || Double-click           -> opens the selected file in a new tab
"   Ctrl+Shift+T || Right-click     -> opens the selected file in the current buffer (replaces tab)
"   Ctrl+Shift+Y || Ctrl+Shift+V    -> opens the selected file in a vertical split
"   Ctrl+Shift+X || Ctrl+Shift+O    -> opens the selected file in a horizontal split
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("t")': ['<CR>', 'Enter', 'Return', '<2-LeftMouse>'],
    \ 'AcceptSelection("e")': ['<C><S-t>', '<RightMouse>'],
    \ 'AcceptSelection("v")': ['<C><S-y>', '<C><S-v>'],
    \ 'AcceptSelection("h")': ['<C><S-x>', '<C><S-o>']
    \ }

" Ctrl+Shift+P || Ctrl+P -> launches CtrlP
nnoremap <C><S-c> :CtrlP

