return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    -- any other setup options can go here
  },
  init = function()
    -- Keymap to open Oil in the current directory
    vim.keymap.set('n', '-', '<cmd>Oil<CR>', { desc = 'Open parent directory in Oil' })
  end,
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  lazy = false,
}
