require'FTerm'.setup({
    -- Transparency of the floating window. See `:h winblend`
    blend = 15,  -- default: 0

    -- Object containing the terminal window dimensions.
    -- The value for each field should be between `0` and `1`
    dimensions = {
        height = 0.8, -- Height of the terminal window
        width = 0.8, -- Width of the terminal window
        x = 0.5, -- X axis of the terminal window
        y = 0.5, -- Y axis of the terminal window
    }
})

vim.api.nvim_create_user_command('FTermOpen', require('FTerm').open, { bang = true })
vim.api.nvim_create_user_command('FTermClose', require('FTerm').close, { bang = true }) -- this "minimizes" the terminal pop-up
vim.api.nvim_create_user_command('FTermExit', require('FTerm').exit, { bang = true }) -- this finishes the terminal session
vim.api.nvim_create_user_command('FTermToggle', require('FTerm').toggle, { bang = true })

vim.keymap.set('n', '<leader>tt', '<CMD>FTermOpen<CR>')
vim.keymap.set('n', '<A-t>', '<CMD>FTermToggle<CR>')
vim.keymap.set('t', '<A-t>', '<C-\\><C-n><CMD>FTermToggle<CR>')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n><CMD>FTermExit<CR>')

