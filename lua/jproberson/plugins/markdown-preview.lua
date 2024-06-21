-- Plugin setup for markdown-preview
return {{
    'iamcco/markdown-preview.nvim',
    cmd = {'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop'},
    ft = {'markdown'},
    build = function()
        vim.fn['mkdp#util#install']()
    end,
    config = function()
        -- It's a good idea to place your keymap definition inside the config function of the plugin
        -- This ensures the keymap is set after the plugin is loaded
        vim.api.nvim_set_keymap('n', '<leader>md', ':MarkdownPreviewToggle<CR>', {
            noremap = true,
            silent = true
        })
    end
}}
