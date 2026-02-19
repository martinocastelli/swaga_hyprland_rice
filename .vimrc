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

