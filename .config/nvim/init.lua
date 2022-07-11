--------------------------------------------------------------------------------------
-- Plugins
--------------------------------------------------------------------------------------
require('matheus.packer')

--------------------------------------------------------------------------------------
-- Remaps
--------------------------------------------------------------------------------------
vim.g.mapleader = ' '

local noremap = { noremap = true }

vim.keymap.set('n', '<leader><leader>', ':', noremap)
vim.keymap.set('n', '<C-c>', '<Esc>', noremap)

-- Make splits
vim.keymap.set('n', '<leader>v', '<C-w>v', noremap)
vim.keymap.set('n', '<leader>s', '<C-w>s', noremap)
vim.keymap.set('n', '<leader>o', '<C-w>o', noremap)

-- Splits navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', noremap)
vim.keymap.set('n', '<C-j>', '<C-w>j', noremap)
vim.keymap.set('n', '<C-k>', '<C-w>k', noremap)
vim.keymap.set('n', '<C-l>', '<C-w>l', noremap)

-- Buffer handling
vim.keymap.set('n', '<A-h>',         ':bprevious<CR>',  noremap)
vim.keymap.set('n', '<A-l>',         ':bnext<CR>',      noremap)
vim.keymap.set('n', '<leader>c',     ':bdelete<CR>',    noremap)
vim.keymap.set('n', '<leader><S-c>', ':bdelete!<CR>',   noremap)
vim.keymap.set('n', '<leader><S-q>', ':q!<CR>',         noremap)
vim.keymap.set('n', '<leader>q',     ':q<CR>',          noremap)
vim.keymap.set('n', '<leader>w',     ':w<CR>',          noremap)
vim.keymap.set('n', '<leader>e',     ':edit<Space>',    noremap)

-- vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', noremap)
-- vim.keymap.set('n', '<leader>bn', ':bnext<CR>',     noremap)
-- vim.keymap.set('n', '<leader>bd', ':bdelete<CR>',   noremap)

-- Replacing
vim.keymap.set('n', '<leader>r', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', noremap)

-- indent/unindent with tab/shift-tab
vim.keymap.set('n', '<Tab>',    '>>',       noremap)
vim.keymap.set('n', '<S-tab>',  '<<',       noremap)
vim.keymap.set('i', '<S-Tab>',  '<Esc><<i', noremap)
vim.keymap.set('v', '<Tab>',    '>gv',      noremap)
vim.keymap.set('v', '<S-Tab>',  '<gv',      noremap)

-- Move the page but not the cursor with the arrow keys
vim.keymap.set('n', '<Down>', '<C-e>', noremap)
vim.keymap.set('n', '<Up>',   '<C-y>', noremap)

-- Opens line below or above the current line
vim.keymap.set('i', '<S-CR>', '<C-O>o', noremap)
vim.keymap.set('i', '<C-CR>', '<C-O>O', noremap)

-- Move lines up and down
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi', noremap)
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi', noremap)
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv",    noremap)
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv",    noremap)

--------------------------------------------------------------------------------------
-- Auto commands
--------------------------------------------------------------------------------------
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

MATHEUS = augroup('MATHEUS', { clear = true })

-- trims all trailing whitespaces on save
autocmd('BufWritePre', { pattern = '*', command = '%s/\\s\\+$//e', group = MATHEUS })

-- highligths yanked text
autocmd('TextYankPost', {
  pattern  = '*',
  callback = function()
    vim.highlight.on_yank({ timeout=200, higroup='IncSearch' })
  end,
  group = MATHEUS
})

