local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

vim.opt_local.colorcolumn = "80"
vim.highlight.create("ColorColumn", {guibg="yellow"}, false)
vim.opt_local.wrap = false
vim.opt_local.cursorcolumn = true

PYTHON = augroup("PYTHON", { clear = true })

