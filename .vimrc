set autoindent
set tabstop=4
set shiftwidth=4
set autoindent
set number
set relativenumber
set mouse=a
colorscheme default
set list lcs=tab:\|\   

syntax on


let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()

Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'

call plug#end()

nnoremap <C-t> :NERDTreeToggle<CR>

filetype plugin indent on
autocmd FileType c setlocal commentstring=//\ %s

let g:airline_theme='deus'

