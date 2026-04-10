return {
    'catppuccin/nvim',
    name = 'catppuccin',
    enabled = false,
    priority = 1000,
    config = function()
        require('catppuccin').setup({
            flavour = 'mocha', -- darkest variant
            no_italic = true,
            custom_highlights = function(colors)
                return {
                    -- Dim unused variables (like WebStorm)
                    DiagnosticUnnecessary = { fg = colors.overlay0 },
                }
            end,
        })
        vim.cmd('colorscheme catppuccin')
    end,
}
