" fzf in currend director
nnoremap <leader>ff :Files<CR>  
" fzf in history
nnoremap <leader>fo :History<CR> 
" fzf in help menu
nnoremap <leader>fh :Helptags<CR>
" Grep input string (fzf prompt)
nnoremap <leader>fg :Rg<Space>
" Grep word under cursor
nnoremap <leader>fs :Rg <C-r><C-w><CR>
" Find files in your Vim config
nnoremap <leader>fc :Files ~/vim<CR>
