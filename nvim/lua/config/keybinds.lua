vim.g.mapleader = " "

local map = vim.keymap.set
map("n", "<leader>cd", vim.cmd.Ex)

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-left>", "<C-w>h")
map("n", "<C-down>", "<C-w>j")
map("n", "<C-up>", "<C-w>k")
map("n", "<C-right>", "<C-w>l")

map("ca", "W", "w")
map("ca", "Q", "q")
map("ca", "WQ", "wq")
map("ca", "Wq", "wq")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- swap line up and down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz") -- Keep cursor in place while moving up/down page
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")       -- center screen when looping search results
vim.keymap.set("n", "N", "Nzzzv")


