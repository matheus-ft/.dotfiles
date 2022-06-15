" This sources all files that configure Neovim via Vim Script
for file in split(glob('~/.config/nvim/vim/*.vim'), '\n')
    exe 'source' file
endfor

" This sources all files that configure Neovim via Lua
for file in split(glob('~/.config/nvim/lua/*.lua'), '\n')
    exe 'source' file
endfor

