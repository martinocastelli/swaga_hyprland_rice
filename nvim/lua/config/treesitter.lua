require('nvim-treesitter').setup {
    highlight = { enable = true },
    indent = { enable = true},
    autotage = { enable = true},
    ensure_installed = {
        "lua",
        "c",
        "cpp",
        "css",
        "python",
    },
    autoinstall = true
}
