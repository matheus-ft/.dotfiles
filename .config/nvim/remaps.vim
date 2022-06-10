let mapleader = " "

" To move between splits in vim
nnoremap <leader>h  <C-w>h
nnoremap <leader>j  <C-w>j
nnoremap <leader>k  <C-w>k
nnoremap <leader>l  <C-w>l
nnoremap <C-h>      <C-w>h
nnoremap <C-j>      <C-w>j
nnoremap <C-k>      <C-w>k
nnoremap <C-l>      <C-w>l


" There are remaps in ./vim/nerdtree.vim for the file tree

" There are remaps in ./vim/python.vim for code navigation

" There are remaps in ./vim/finder.vim for CtrlP

" Tab navigation
nnoremap <silent> <leader><Tab> :tabnext<CR>
nnoremap <leader>t              :tabnew<Space>
nnoremap <leader><S-q>          :tabclose<CR>

"Exiting and saving
nnoremap <leader>q  :q<CR>
nnoremap <S-q>      :q!<CR>
nnoremap <C-q>      :wq<CR>
inoremap <C-q>      <Esc>:wq<CR>
vnoremap <C-q>      <Esc>:wq<CR>
nnoremap <C-s>      :w<CR>
inoremap <C-s>      <Esc>:w<CR>
vnoremap <C-s>      <Esc>:w<CR>

" Undoing
nnoremap <C-z>      :u<CR>
inoremap <C-z>      <Esc>:u<CR>i
vnoremap <C-z>      <Esc>:u<CR>v

" indent/unindent with tab/shift-tab
nnoremap <Tab>      >>
nnoremap <S-tab>    <<
inoremap <S-Tab>    <Esc><<i
vnoremap <Tab>      >gv
vnoremap <S-Tab>    <gv

" Cut - copy/paste enabled with clipboard+=unnamedplus in ./sets.vim
vnoremap <C-x> c<Esc>

" Searching
nnoremap <C-f> /
inoremap <C-f> <Esc>/
vnoremap <C-f> <Esc>/

