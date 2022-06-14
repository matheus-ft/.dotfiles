let mapleader = ' ' 

" To move between splits in vim
nnoremap <leader>h  <C-w>h
nnoremap <leader>j  <C-w>j
nnoremap <leader>k  <C-w>k
nnoremap <leader>l  <C-w>l
nnoremap <C-h>      <C-w>h
nnoremap <C-j>      <C-w>j
nnoremap <C-k>      <C-w>k
nnoremap <C-l>      <C-w>l


" There are remaps in ./vim/plugins/nerdtree.vim for the file tree

" There are remaps in ./vim/plugins/python.vim for code navigation

" There are remaps in ./vim/plugins/finder.vim for CtrlP

" Tab navigation and exiting
nnoremap <silent> <leader><Tab> :tabnext<CR>
nnoremap <leader>t              :tabnew<Space>
nnoremap <leader><S-q>          :tabclose<CR>
nnoremap <leader>q              :q<CR>
nnoremap <S-q>                  :q!<CR>

" VS Code like shortcuts
" Saving
nnoremap <C-s>      :w<CR>
inoremap <C-s>      <Esc>:w<CR>
vnoremap <C-s>      <Esc>:w<CR>
" Undoing
nnoremap <C-z>      :u<CR>
inoremap <C-z>      <Esc>:u<CR>i
vnoremap <C-z>      <Esc>:u<CR>v
" Cut - copy/paste enabled with clipboard+=unnamedplus in ./vim/sets.vim
vnoremap <C-x>      c<Esc>
" Searching
nnoremap <C-f>      /
inoremap <C-f>      <Esc>/
vnoremap <C-f>      <Esc>/

" indent/unindent with tab/shift-tab
nnoremap <Tab>      >>
nnoremap <S-tab>    <<
inoremap <S-Tab>    <Esc><<i
vnoremap <Tab>      >gv
vnoremap <S-Tab>    <gv

