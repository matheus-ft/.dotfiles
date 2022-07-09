vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")
require("nvim-treesitter.configs").setup({ highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }})

