
let lspOpts = #{autoHighlightDiags: v:true}
autocmd User LspSetup call LspOptionsSet(lspOpts)

autocmd User LspSetup call LspAddServer([#{
			\	  name: 'clang',
			\	  filetype: ['c', 'cpp'],
			\	  path: '/usr/bin/clangd',
			\	  args: ['--background-index']
			\ }])
" autocmd User LspSetup call LspAddServer([#{name: 'bashls',
" 			\   filetype: 'sh',
" 			\   path: '/usr/bin/bash-language-server',
" 			\   args: ['start']
" 			\ }])
autocmd User LspSetup call LspAddServer([#{name: 'pylsp',
			\   filetype: 'python',
			\   path: '/usr/bin/pylsp',
			\   args: []
			\ }])

nnoremap <leader>gd :LspGotoDefinition<CR>
nnoremap <leader>go :LspHover<CR>
nnoremap <leader>gl :LspDiag current<CR>

inoremap <A-Tab> <C-n>
inoremap <S-Tab> <C-p>

autocmd User LspSetup call LspOptionsSet(#{
			\   diagSignErrorText: '✘',
			\   diagSignWarningText: '▲',
			\   diagSignInfoText: '»',
			\   diagSignHintText: '⚑',
			\ })
