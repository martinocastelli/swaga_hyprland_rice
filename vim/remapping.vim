let mapleader = " "

" navigating tabs
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-left> <C-w>h
map <C-down> <C-w>j
map <C-up> <C-w>k
map <C-right> <C-w>l

" Open netrw with <leader>cd
nnoremap <leader>cd :Ex<CR>

" commands for save and exit
nnoremap <leader>w :wa<CR>
nnoremap <leader>q :q<CR>

" Center on next/previous search result
nnoremap n nzzzv
nnoremap N Nzzzv

" swap line with top/bottom
nnoremap K :m -2<CR>
nnoremap J :m +1<CR>
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

" Make kj behave like <Esc> in insert mode
inoremap kj <Esc>

" remove visual mode keybinding
noremap Q <Nop>

""" C
" create c function body from prototype
nnoremap gch A<BS><BS>;<ESC>
nnoremap gcf A<BS> {<CR>}<ESC>

" closing and saving
command W w
command Q q
command WQ wq
command Wq wq

" to generate tags file for C and Cpp files (not needed)
" autocmd BufWritePost *.c,*.cpp,*.h silent! !ctags -R &

" removing arrow keys for movements
nnoremap <left> <Nop>
nnoremap <right> <Nop>
nnoremap <up> <Nop>
nnoremap <down> <Nop>
vnoremap <left> <Nop>
vnoremap <right> <Nop>
vnoremap <up> <Nop>
vnoremap <down> <Nop>
inoremap <left> <Nop>
inoremap <right> <Nop>
" for lsp completition
" inoremap <down> <Nop>
" inoremap <up> <Nop>

