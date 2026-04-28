require('mini.icons').setup {}

vim.keymap.set('n', '-', '<cmd>Oil<CR>', { desc = 'Open parent directory in Oil' })

require('oil').setup {}
