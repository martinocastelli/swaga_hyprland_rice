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
set concealcursor=c
set showmatch

syntax on

" to generate tags file for C and Cpp files
autocmd BufWritePost *.c,*.cpp,*.h silent! !ctags -R &


hi ErrorMsg ctermfg=red ctermbg=black
hi Error ctermfg=red ctermbg=black
hi Search ctermfg=black
