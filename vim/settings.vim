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

hi ErrorMsg ctermfg=red ctermbg=black
hi Error ctermfg=red ctermbg=black
hi Search ctermfg=black ctermbg=white
hi SpellBad ctermfg=black ctermbg=red
hi SpellCap ctermbg=100

"TODO fix this
set fo=tq

" Keep cursor 4 lines from top/bottom
set scrolloff=4
