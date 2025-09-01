return {
  'folke/tokyonight.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    require('tokyonight').setup {
      styles = {
        comments = { italic = false }, -- Disable italics in comments
      },
    }

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
  end,
}
