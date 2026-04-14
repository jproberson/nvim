require('obsidian').setup {
  workspaces = {
    {
      name = 'work notes',
      path = '~/vaults/work/',
    },
  },
  completion = {
    nvim_cmp = false,
    min_chars = 2,
  },
  mappings = {
    ['gf'] = {
      action = function()
        return require('obsidian').util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
    ['<leader>oc'] = {
      action = function()
        return require('obsidian').util.toggle_checkbox()
      end,
      opts = { buffer = true },
    },
  },
  daily_notes = {
    folder = 'daily',
  },
  note_id_func = function(title)
    if title ~= nil then
      return title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
    else
      return tostring(os.time())
    end
  end,
  ui = {
    enable = false,
  },
}

vim.keymap.set('n', '<leader>on', '<cmd>ObsidianNew<cr>', { desc = 'New note' })
vim.keymap.set('n', '<leader>oo', '<cmd>ObsidianQuickSwitch<cr>', { desc = 'Open note' })
vim.keymap.set('n', '<leader>os', '<cmd>ObsidianSearch<cr>', { desc = 'Search notes' })
vim.keymap.set('n', '<leader>ot', '<cmd>ObsidianToday<cr>', { desc = 'Today daily note' })
vim.keymap.set('n', '<leader>oy', '<cmd>ObsidianYesterday<cr>', { desc = 'Yesterday daily note' })
vim.keymap.set('n', '<leader>ob', '<cmd>ObsidianBacklinks<cr>', { desc = 'Backlinks' })
vim.keymap.set('n', '<leader>ol', '<cmd>ObsidianLinks<cr>', { desc = 'Links in note' })
vim.keymap.set('n', '<leader>op', '<cmd>ObsidianPasteImg<cr>', { desc = 'Paste image' })
vim.keymap.set('n', '<leader>so', '<cmd>ObsidianSearch<cr>', { desc = 'Search Obsidian' })
