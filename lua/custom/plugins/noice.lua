require('noice').setup {
  cmdline = {
    enabled = true,
    view = 'cmdline_popup',
    format = {
      cmdline = { pattern = '^:', icon = '', lang = 'vim' },
      search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
      search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
      filter = { pattern = '^:%s*!', icon = '$', lang = 'bash' },
      lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = '', lang = 'lua' },
      help = { pattern = '^:%s*he?l?p?%s+', icon = '?' },
    },
  },

  messages = {
    enabled = true,
    view = 'notify',
    view_error = 'notify',
    view_warn = 'notify',
    view_history = 'messages',
    view_search = 'virtualtext',
  },

  popupmenu = {
    enabled = true,
    backend = 'nui',
  },

  lsp = {
    progress = {
      enabled = false,
    },
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = false,
    },
    hover = {
      enabled = true,
      silent = false,
    },
    signature = {
      enabled = true,
      auto_open = {
        enabled = true,
        trigger = true,
        luasnip = true,
        throttle = 50,
      },
    },
    message = {
      enabled = true,
      view = 'notify',
    },
  },

  notify = {
    enabled = true,
    view = 'notify',
  },

  presets = {
    bottom_search = false,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = true,
  },

  throttle = 1000 / 30,

  routes = {
    {
      filter = {
        event = 'msg_show',
        kind = '',
        find = 'written',
      },
      opts = { skip = true },
    },
    {
      filter = {
        event = 'msg_show',
        min_height = 10,
      },
      view = 'split',
    },
  },

  views = {
    cmdline_popup = {
      position = { row = 5, col = '50%' },
      size = { width = 60, height = 'auto' },
      border = { style = 'rounded' },
    },
    popupmenu = {
      relative = 'editor',
      position = { row = 8, col = '50%' },
      size = { width = 60, height = 10 },
      border = { style = 'rounded' },
    },
  },
}

vim.keymap.set({ 'i', 'n', 's' }, '<c-f>', function()
  if not require('noice.lsp').scroll(4) then
    return '<c-f>'
  end
end, { silent = true, expr = true, desc = 'Scroll Forward (Docs)' })

vim.keymap.set({ 'i', 'n', 's' }, '<c-b>', function()
  if not require('noice.lsp').scroll(-4) then
    return '<c-b>'
  end
end, { silent = true, expr = true, desc = 'Scroll Backward (Docs)' })

vim.keymap.set('n', '<leader>nd', function() require('noice').cmd 'dismiss' end, { desc = 'Dismiss All Notifications' })
vim.keymap.set('n', '<leader>nh', function() require('noice').cmd 'history' end, { desc = 'Noice History' })
vim.keymap.set('n', '<leader>nl', function() require('noice').cmd 'last' end, { desc = 'Noice Last Message' })
vim.keymap.set('n', '<leader>ne', function() require('noice').cmd 'errors' end, { desc = 'Noice Errors' })
