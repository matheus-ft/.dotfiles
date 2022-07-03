vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.nu = true
vim.opt.relativenumber = true  -- to easily jump vertically in the file

vim.opt.hidden = true  -- keeps edited buffers in the background, so there's no need to always save before navigating away from it
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.opt.ignorecase = true -- ignore case while searching...
vim.opt.smartcase = true -- ... unless there's a capital letter
vim.opt.incsearch = true
vim.opt.hlsearch = false

vim.opt.scrolloff = 10

vim.opt.signcolumn = "yes"  -- add sidecolumn for git gutter and stuff

vim.opt.clipboard:append { "unnamedplus" }  -- to copy and paste easily - but will change <C-c> and <C-v> from nvim to <C><S-c> and <C><S-v>

-- .llows for 'native fuzzy finding' if nvim is opened at project root
vim.opt.path:append { "**" }
vim.opt.wildmenu = true

vim.opt.completeopt = { "menuone", "preview", "noinsert"}

vim.opt.title = true -- to show file name in titlebar

vim.opt.cmdheight = 1

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.equalalways = false

vim.opt.cursorline = true
vim.opt.mouse = "niv"

