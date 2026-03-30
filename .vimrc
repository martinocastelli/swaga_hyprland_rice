set autoindent
set tabstop=4
set shiftwidth=4
set autoindent
set number
set relativenumber
set mouse=a
colorscheme default
set list lcs=tab:\|\   
set wrap
set conceallevel=2
set concealcursor=nc

command W w
command Q q
command WQ wq
command Wq wq

autocmd BufWritePost *.c,*.cpp,*.h silent! !ctags -R &

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
Plug 'Yggdroot/indentLine'
Plug 'lervag/vimtex'
Plug 'ubaldot/vim-outline'

call plug#end()

hi ErrorMsg ctermfg=red ctermbg=black
hi Error ctermfg=red ctermbg=black

nnoremap <C-t> :NERDTreeToggle<CR>

filetype plugin indent on
autocmd FileType c setlocal commentstring=//\ %s

"Fonts for the Status Line
let g:airline_theme='simple'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.readonly = '∥'
let g:airline_symbols.whitespace = 'Ξ'

let g:indentLine_char = '|'
let g:indentLine_first_char = '|'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setConceal = 0
let g:indentLine_color_term = 122 " magic number i don't know what does it mean

let g:vimtex_view_method = 'zathura'

nnoremap <C-k> :OutlineToggle<CR>

let g:ycm_enable_semantic_highlighting=1
let g:ycm_enable_diagnostic_highlighting=0
let g:ycm_min_num_of_chars_for_completion=2
let g:ycm_auto_trigger = 1
imap <c-d> <plug>(YCMComplete)

