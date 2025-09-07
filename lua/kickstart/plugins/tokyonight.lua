-- Previous tokyonight configuration (kept for reference)
return {
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
        -- Set to true for custom muted theme, false for original tokyonight
        local use_custom_theme = true
        
        local setup_config = {
            styles = {
                comments = { italic = false }, -- Disable italics in comments
            },
        }
        
        if use_custom_theme then
            setup_config.on_colors = function(colors)
                colors.bg = '#1a1a1a' -- Match wezterm background color
            end
            setup_config.on_highlights = function(highlights, colors)
                -- Main UI elements with soft muted backgrounds
                highlights.NormalFloat = { bg = '#161616' } -- Soft dark gray for floating windows
                highlights.NeoTreeNormal = { bg = '#161616' } -- Soft dark gray for sidebar
                highlights.NeoTreeNormalNC = { bg = '#161616' }
                -- Status line - comprehensive override to eliminate all blue elements
                highlights.StatusLine = { fg = colors.fg, bg = '#161616' }
                highlights.StatusLineNC = { fg = colors.fg_dark, bg = '#161616' }
                highlights.StatusLineTerm = { fg = colors.fg, bg = '#161616' }
                highlights.StatusLineTermNC = { fg = colors.fg_dark, bg = '#161616' }
                -- Override any mode-specific status line colors
                highlights.StatusLineInsert = { fg = colors.fg, bg = '#161616' }
                highlights.StatusLineVisual = { fg = colors.fg, bg = '#161616' }
                highlights.StatusLineReplace = { fg = colors.fg, bg = '#161616' }
                highlights.StatusLineCommand = { fg = colors.fg, bg = '#161616' }
                highlights.StatusLineNormal = { fg = colors.fg, bg = '#161616' }
                
                -- Lualine overrides (if using lualine)
                highlights.lualine_a_normal = { fg = colors.fg, bg = '#161616' }
                highlights.lualine_b_normal = { fg = colors.fg_dark, bg = '#181818' }
                highlights.lualine_c_normal = { fg = colors.fg_dark, bg = '#161616' }
                highlights.lualine_a_insert = { fg = colors.fg, bg = '#161616' }
                highlights.lualine_a_visual = { fg = colors.fg, bg = '#161616' }
                highlights.lualine_a_replace = { fg = colors.fg, bg = '#161616' }
                highlights.lualine_a_command = { fg = colors.fg, bg = '#161616' }
                
                -- Mini.statusline overrides - different modes with muted theme colors
                highlights.MiniStatuslineModeNormal = { fg = colors.fg, bg = '#2d2d2d' }    -- Normal mode - medium gray
                highlights.MiniStatuslineModeInsert = { fg = colors.fg, bg = '#2a3d2a' }    -- Insert mode - muted green
                highlights.MiniStatuslineModeVisual = { fg = colors.fg, bg = '#3d2d2a' }    -- Visual mode - muted orange
                highlights.MiniStatuslineModeReplace = { fg = colors.fg, bg = '#3d2a2a' }   -- Replace mode - muted red
                highlights.MiniStatuslineModeCommand = { fg = colors.fg, bg = '#2a2a3d' }   -- Command mode - muted purple
                highlights.MiniStatuslineModeOther = { fg = colors.fg, bg = '#2d2d2d' }     -- Other modes - medium gray
                highlights.MiniStatuslineDevinfo = { fg = colors.fg_dark, bg = '#1c1c1c' } -- Dev info - darker
                highlights.MiniStatuslineFilename = { fg = colors.fg_dark, bg = '#161616' } -- Filename - darkest
                highlights.MiniStatuslineFileinfo = { fg = colors.fg_dark, bg = '#1c1c1c' } -- File info - darker
                highlights.MiniStatuslineInactive = { fg = colors.fg_dark, bg = '#141414' } -- Inactive - very dark
                
                -- Tab line to match the soft theme
                highlights.TabLine = { fg = colors.fg_dark, bg = '#161616' }
                highlights.TabLineFill = { bg = '#141414' }
                highlights.TabLineSel = { fg = colors.fg, bg = '#1a1a1a' }
                
                -- Cursor line and visual selection - softer than defaults
                highlights.CursorLine = { bg = '#1c1c1c' }
                highlights.Visual = { bg = '#2d2d2d' }
                
                -- Line numbers with muted appearance  
                highlights.LineNr = { fg = '#4a4a4a', bg = 'NONE' }
                highlights.CursorLineNr = { fg = '#7a7a7a', bg = 'NONE' }
                
                -- Completion menu with soft backgrounds
                highlights.Pmenu = { fg = colors.fg_dark, bg = '#161616' }
                highlights.PmenuSel = { fg = colors.fg, bg = '#2d2d2d' }
                highlights.PmenuSbar = { bg = '#181818' }
                highlights.PmenuThumb = { bg = '#2d2d2d' }
                
                -- Search highlighting - less jarring
                highlights.Search = { fg = colors.bg, bg = '#5a5a5a' }
                highlights.IncSearch = { fg = colors.bg, bg = '#7a7a7a' }
                
                -- Telescope backgrounds - soft darker grays maintaining that gentle feel
                highlights.TelescopeNormal = { bg = '#161616' }
                highlights.TelescopeBorder = { bg = '#161616' }
                highlights.TelescopePromptNormal = { bg = '#181818' }
                highlights.TelescopePromptBorder = { bg = '#181818' }
                highlights.TelescopeResultsNormal = { bg = '#161616' }
                highlights.TelescopeResultsBorder = { bg = '#161616' }
                highlights.TelescopePreviewNormal = { bg = '#161616' }
                highlights.TelescopePreviewBorder = { bg = '#161616' }
                highlights.TelescopeSelection = { bg = '#2d2d2d' }
                
                -- Which-key with soft muted background - override all blue elements
                highlights.WhichKeyFloat = { bg = '#161616' }
                highlights.WhichKeyBorder = { fg = '#4a4a4a', bg = '#161616' }
                highlights.WhichKeyNormal = { bg = '#161616' }
                highlights.WhichKey = { fg = colors.fg, bg = '#161616' }
                highlights.WhichKeyGroup = { fg = colors.fg_dark, bg = '#161616' }
                highlights.WhichKeyDesc = { fg = colors.fg_dark, bg = '#161616' }
                highlights.WhichKeySeparator = { fg = '#4a4a4a', bg = '#161616' }
            end
        end
        
        require('tokyonight').setup(setup_config)

        -- Load the colorscheme here
        vim.cmd.colorscheme 'tokyonight-night'

        -- Override highlights after the scheme is applied
        -- GitSigns
        vim.cmd [[
        highlight GitSignsAdd    guifg=#00ff00 guibg=NONE
        highlight GitSignsChange guifg=#ffaa00 guibg=NONE
        highlight GitSignsDelete guifg=#ff0000 guibg=NONE
        ]]

        -- Optional: make comments a bit more greenish and distinct
        vim.cmd [[
        highlight Comment guifg=#5faf5f ctermfg=107
        ]]
        
        -- Toggle between custom muted theme and original tokyonight
        vim.keymap.set('n', '<leader>ut', function()
            use_custom_theme = not use_custom_theme
            
            local new_config = {
                styles = {
                    comments = { italic = false },
                },
            }
            
            if use_custom_theme then
                new_config.on_colors = function(colors)
                    colors.bg = '#1a1a1a'
                end
                new_config.on_highlights = function(highlights, colors)
                    -- All your custom highlights here (abbreviated for space)
                    highlights.NormalFloat = { bg = '#161616' }
                    highlights.NeoTreeNormal = { bg = '#161616' }
                    highlights.NeoTreeNormalNC = { bg = '#161616' }
                    highlights.StatusLine = { fg = colors.fg, bg = '#161616' }
                    highlights.StatusLineNC = { fg = colors.fg_dark, bg = '#161616' }
                    highlights.TabLine = { fg = colors.fg_dark, bg = '#161616' }
                    highlights.TabLineFill = { bg = '#141414' }
                    highlights.TabLineSel = { fg = colors.fg, bg = '#1a1a1a' }
                    highlights.CursorLine = { bg = '#1c1c1c' }
                    highlights.Visual = { bg = '#2d2d2d' }
                    highlights.LineNr = { fg = '#4a4a4a', bg = 'NONE' }
                    highlights.CursorLineNr = { fg = '#7a7a7a', bg = 'NONE' }
                    highlights.Pmenu = { fg = colors.fg_dark, bg = '#161616' }
                    highlights.PmenuSel = { fg = colors.fg, bg = '#2d2d2d' }
                    highlights.PmenuSbar = { bg = '#181818' }
                    highlights.PmenuThumb = { bg = '#2d2d2d' }
                    highlights.Search = { fg = colors.bg, bg = '#5a5a5a' }
                    highlights.IncSearch = { fg = colors.bg, bg = '#7a7a7a' }
                    highlights.TelescopeNormal = { bg = '#161616' }
                    highlights.TelescopeBorder = { bg = '#161616' }
                    highlights.TelescopePromptNormal = { bg = '#181818' }
                    highlights.TelescopePromptBorder = { bg = '#181818' }
                    highlights.TelescopeResultsNormal = { bg = '#161616' }
                    highlights.TelescopeResultsBorder = { bg = '#161616' }
                    highlights.TelescopePreviewNormal = { bg = '#161616' }
                    highlights.TelescopePreviewBorder = { bg = '#161616' }
                    highlights.TelescopeSelection = { bg = '#2d2d2d' }
                    highlights.WhichKeyFloat = { bg = '#161616' }
                    highlights.WhichKeyBorder = { fg = '#4a4a4a', bg = '#161616' }
                    highlights.WhichKeyNormal = { bg = '#161616' }
                    highlights.WhichKey = { fg = colors.fg, bg = '#161616' }
                    highlights.WhichKeyGroup = { fg = colors.fg_dark, bg = '#161616' }
                    highlights.WhichKeyDesc = { fg = colors.fg_dark, bg = '#161616' }
                    highlights.WhichKeySeparator = { fg = '#4a4a4a', bg = '#161616' }
                    -- Mini.statusline
                    highlights.MiniStatuslineModeNormal = { fg = colors.fg, bg = '#2d2d2d' }
                    highlights.MiniStatuslineModeInsert = { fg = colors.fg, bg = '#2a3d2a' }
                    highlights.MiniStatuslineModeVisual = { fg = colors.fg, bg = '#3d2d2a' }
                    highlights.MiniStatuslineModeReplace = { fg = colors.fg, bg = '#3d2a2a' }
                    highlights.MiniStatuslineModeCommand = { fg = colors.fg, bg = '#2a2a3d' }
                    highlights.MiniStatuslineModeOther = { fg = colors.fg, bg = '#2d2d2d' }
                    highlights.MiniStatuslineDevinfo = { fg = colors.fg_dark, bg = '#1c1c1c' }
                    highlights.MiniStatuslineFilename = { fg = colors.fg_dark, bg = '#161616' }
                    highlights.MiniStatuslineFileinfo = { fg = colors.fg_dark, bg = '#1c1c1c' }
                    highlights.MiniStatuslineInactive = { fg = colors.fg_dark, bg = '#141414' }
                end
            end
            
            require('tokyonight').setup(new_config)
            vim.cmd.colorscheme 'tokyonight-night'
            
            -- Reapply custom highlights
            vim.cmd [[
            highlight GitSignsAdd    guifg=#00ff00 guibg=NONE
            highlight GitSignsChange guifg=#ffaa00 guibg=NONE
            highlight GitSignsDelete guifg=#ff0000 guibg=NONE
            highlight Comment guifg=#5faf5f ctermfg=107
            ]]
            
            print(use_custom_theme and "Switched to custom muted theme" or "Switched to original tokyonight")
        end, { desc = 'Toggle theme (custom/tokyonight)' })
    end,
}

-- Load the custom theme instead of tokyonight
-- return require('kickstart.plugins.custom-theme')
