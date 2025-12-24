return {
  'epwalsh/obsidian.nvim',
  version = '*',
  lazy = true,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    workspaces = {
      {
        name = 'notes',
        path = '~/notes',
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
      -- Keep note names readable instead of using timestamps
      if title ~= nil then
        return title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
      else
        return tostring(os.time())
      end
    end,
    ui = {
      enable = false, -- Let render-markdown.nvim handle visuals
    },
  },
  keys = {
    { '<leader>on', '<cmd>ObsidianNew<cr>', desc = 'New note' },
    { '<leader>oo', '<cmd>ObsidianQuickSwitch<cr>', desc = 'Open note' },
    { '<leader>os', '<cmd>ObsidianSearch<cr>', desc = 'Search notes' },
    { '<leader>ot', '<cmd>ObsidianToday<cr>', desc = 'Today daily note' },
    { '<leader>oy', '<cmd>ObsidianYesterday<cr>', desc = 'Yesterday daily note' },
    { '<leader>ob', '<cmd>ObsidianBacklinks<cr>', desc = 'Backlinks' },
    { '<leader>ol', '<cmd>ObsidianLinks<cr>', desc = 'Links in note' },
    { '<leader>op', '<cmd>ObsidianPasteImg<cr>', desc = 'Paste image' },
    { '<leader>so', '<cmd>ObsidianSearch<cr>', desc = 'Search Obsidian' },
  },
}
