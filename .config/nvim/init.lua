--------------------------------------------------------------------------------------
-- Plugins
--------------------------------------------------------------------------------------
local Plug = vim.fn["plug#"]

vim.call("plug#begin")
    -- Useful things
    Plug 'windwp/nvim-autopairs'        -- automatically add the pairing char for surroundign chars
    Plug "tpope/vim-surround"           -- to change surrounding characters easily
    Plug "numToStr/Comment.nvim"        -- toggle comments easily
    Plug "numToStr/FTerm.nvim"          -- floating terminal
    Plug "vim-airline/vim-airline"      -- status line
    Plug "preservim/nerdtree"           -- file tree

    -- Git
    Plug "lewis6991/gitsigns.nvim"
    Plug "tpope/vim-fugitive"

    -- LSP and autocomplete stuff
    Plug "neovim/nvim-lspconfig"
    Plug "hrsh7th/nvim-cmp"
    Plug "hrsh7th/cmp-nvim-lsp"
    Plug "hrsh7th/cmp-buffer"
    Plug "hrsh7th/cmp-path"
    Plug "saadparwaiz1/cmp_luasnip"
    Plug "L3MON4D3/LuaSnip"

    -- Sintax highlighting
    Plug ("nvim-treesitter/nvim-treesitter", { ["do"] = vim.fn[":TSUpdate"] })
    Plug "romgrk/nvim-treesitter-context"

    -- Octave (neovim treesitter don support matlab-like languages apparently)
    Plug "jvirtanen/vim-octave"
    Plug "tpope/vim-endwise" -- useful for other languages too (i guess...)

    -- Lua
    Plug "hrsh7th/cmp-nvim-lua"

    -- Markdown, latex, etc.
    Plug ("iamcco/markdown-preview.nvim", { ["do"] = vim.fn["cd app && yarn install"] })

    -- Telescope
    Plug "nvim-lua/plenary.nvim" -- dependency
    Plug "nvim-telescope/telescope.nvim"
    Plug "nvim-telescope/telescope-fzy-native.nvim" -- sorts the findings
    -- also install "github.com/BurntSushi/ripgrep" to use live_grep func

    -- Themes
    Plug "gruvbox-community/gruvbox"
    Plug "navarasu/onedark.nvim"
vim.call("plug#end")

vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")
require("nvim-treesitter.configs").setup({ highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }})

--------------------------------------------------------------------------------------
-- Remaps
--------------------------------------------------------------------------------------
vim.g.mapleader = " "

local noremap = { noremap = true }

vim.keymap.set("n", "<leader><leader>", ":", noremap)

-- Make splits
vim.keymap.set("n", "<leader>v", "<C-w>v", noremap)
vim.keymap.set("n", "<leader>s", "<C-w>s", noremap)
vim.keymap.set("n", "<leader>o", "<C-w>o", noremap)

-- Splits navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", noremap)
vim.keymap.set("n", "<C-j>", "<C-w>j", noremap)
vim.keymap.set("n", "<C-k>", "<C-w>k", noremap)
vim.keymap.set("n", "<C-l>", "<C-w>l", noremap)

-- Buffer handling
vim.keymap.set("n", "<A-h>",         ":bprevious<CR>",  noremap)
vim.keymap.set("n", "<A-l>",         ":bnext<CR>",      noremap)
vim.keymap.set("n", "<leader>c",     ":bdelete<CR>",    noremap)
vim.keymap.set("n", "<leader><S-c>", ":bdelete!<CR>",   noremap)
vim.keymap.set("n", "<leader><S-q>", ":q!<CR>",         noremap)
vim.keymap.set("n", "<leader>q",     ":q<CR>",          noremap)
vim.keymap.set("n", "<leader>w",     ":w<CR>",          noremap)
vim.keymap.set("n", "<leader>e",     ":edit<Space>",    noremap)

-- vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", noremap)
-- vim.keymap.set("n", "<leader>bn", ":bnext<CR>",     noremap)
-- vim.keymap.set("n", "<leader>bd", ":bdelete<CR>",   noremap)

-- Replacing
vim.keymap.set("n", "<leader>r", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", noremap)

-- indent/unindent with tab/shift-tab
vim.keymap.set("n", "<Tab>",    ">>",       noremap)
vim.keymap.set("n", "<S-tab>",  "<<",       noremap)
vim.keymap.set("i", "<S-Tab>",  "<Esc><<i", noremap)
vim.keymap.set("v", "<Tab>",    ">gv",      noremap)
vim.keymap.set("v", "<S-Tab>",  "<gv",      noremap)

-- Move the page but not the cursor with the arrow keys
vim.keymap.set("n", "<Down>", "<C-e>", noremap)
vim.keymap.set("n", "<Up>",   "<C-y>", noremap)

-- Opens line below or above the current line
vim.keymap.set("i", "<S-CR>", "<C-O>o", noremap)
vim.keymap.set("i", "<C-CR>", "<C-O>O", noremap)

-- Move lines up and down
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", noremap)
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", noremap)
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv",    noremap)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv",    noremap)

--------------------------------------------------------------------------------------
-- Auto commands
--------------------------------------------------------------------------------------
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

MATHEUS = augroup("MATHEUS", { clear = true })

-- trims all trailing whitespaces on save
autocmd({"BufWritePre"}, { pattern = "*", command = "%s/\\s\\+$//e", group = MATHEUS })

