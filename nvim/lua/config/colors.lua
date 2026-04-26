vim.cmd.colorscheme "tokyonight"
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
require('lualine').setup {
	options = { theme = "tokyonight" },
}

