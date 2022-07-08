require('onedark').setup {
    style = 'cool', -- Options: 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    toggle_style_key = '<leader>ts', -- Default keybinding to toggle

    -- Options are italic, bold, underline, none. You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'italic',
        variables = 'none'
    },
}

require('onedark').load()

