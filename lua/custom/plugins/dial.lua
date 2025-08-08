return {
  'monaqa/dial.nvim',
  config = function()
    local dial = require 'dial.map'
    vim.keymap.set('n', '<C-a>', dial.inc_normal(), { noremap = true })
    vim.keymap.set('n', '<C-x>', dial.dec_normal(), { noremap = true })
    vim.keymap.set('v', '<C-a>', dial.inc_visual(), { noremap = true })
    vim.keymap.set('v', '<C-x>', dial.dec_visual(), { noremap = true })
  end,
}
