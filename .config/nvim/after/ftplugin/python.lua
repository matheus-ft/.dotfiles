local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

vim.opt_local.colorcolumn = "80"
vim.highlight.create("ColorColumn", {guibg="yellow"}, false)
vim.opt_local.wrap = false
vim.opt_local.cursorcolumn = true

PYTHON = augroup("PYTHON", { clear = true })

-- this formats all python files in the current vim session
-- make sure your virtual environment is called .env
autocmd({"BufWritePost"}, {
        pattern = "*.py",
        command = "!source .env/bin/activate && docformatter -ir . && black .",
        group = PYTHON
  })

