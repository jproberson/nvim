return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    -- Optional: better looking notifications
    -- Uncomment if you want fancy notifications:
    -- 'rcarriga/nvim-notify',
  },
  opts = {
    -- Replace the cmdline with a popup
    cmdline = {
      enabled = true,
      view = 'cmdline_popup', -- 'cmdline_popup' or 'cmdline' (bottom)
      format = {
        cmdline = { pattern = '^:', icon = '', lang = 'vim' },
        search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
        search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
        filter = { pattern = '^:%s*!', icon = '$', lang = 'bash' },
        lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = '', lang = 'lua' },
        help = { pattern = '^:%s*he?l?p?%s+', icon = '?' },
      },
    },

    -- Messages shown in the popup
    messages = {
      enabled = true,
      view = 'notify', -- default view for messages
      view_error = 'notify', -- view for errors
      view_warn = 'notify', -- view for warnings
      view_history = 'messages', -- view for :messages
      view_search = 'virtualtext', -- view for search count messages
    },

    -- Popupmenu - let blink.cmp handle completion
    popupmenu = {
      enabled = true,
      backend = 'nui', -- 'nui' or 'cmp' - nui is fine, blink.cmp uses its own menu
    },

    -- LSP integration
    lsp = {
      -- Disable LSP progress since fidget.nvim handles this
      -- If you want noice to handle LSP progress instead, set enabled = true
      -- and disable fidget.nvim in lspconfig.lua
      progress = {
        enabled = false,
      },
      -- Override markdown rendering for hover/signature
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = false, -- not using nvim-cmp
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
      -- Show message when no hover info available
      message = {
        enabled = true,
        view = 'notify',
      },
    },

    -- Notification settings
    notify = {
      enabled = true,
      view = 'notify',
    },

    -- Presets for quick configuration
    presets = {
      bottom_search = false, -- use popup for search
      command_palette = true, -- position cmdline and popupmenu together
      long_message_to_split = true, -- long messages go to split
      inc_rename = false, -- enable if using inc-rename.nvim
      lsp_doc_border = true, -- add border to hover docs and signature help
    },

    -- Throttle settings to reduce noise
    throttle = 1000 / 30, -- 30fps

    -- Routes to filter/redirect certain messages
    routes = {
      -- Hide "written" messages
      {
        filter = {
          event = 'msg_show',
          kind = '',
          find = 'written',
        },
        opts = { skip = true },
      },
      -- Hide search count virtualtext (optional - comment out if you want it)
      -- {
      --   filter = { event = 'msg_show', kind = 'search_count' },
      --   opts = { skip = true },
      -- },
      -- Route long messages to split
      {
        filter = {
          event = 'msg_show',
          min_height = 10,
        },
        view = 'split',
      },
    },

    -- Views configuration
    views = {
      cmdline_popup = {
        position = {
          row = 5,
          col = '50%',
        },
        size = {
          width = 60,
          height = 'auto',
        },
        border = {
          style = 'rounded',
        },
      },
      popupmenu = {
        relative = 'editor',
        position = {
          row = 8,
          col = '50%',
        },
        size = {
          width = 60,
          height = 10,
        },
        border = {
          style = 'rounded',
        },
      },
    },
  },
  keys = {
    -- Scroll LSP hover/signature docs (official noice recommendation)
    -- Falls back to normal <c-f>/<c-b> when no doc window is open
    {
      '<c-f>',
      function()
        if not require('noice.lsp').scroll(4) then
          return '<c-f>'
        end
      end,
      silent = true,
      expr = true,
      desc = 'Scroll Forward (Docs)',
      mode = { 'i', 'n', 's' },
    },
    {
      '<c-b>',
      function()
        if not require('noice.lsp').scroll(-4) then
          return '<c-b>'
        end
      end,
      silent = true,
      expr = true,
      desc = 'Scroll Backward (Docs)',
      mode = { 'i', 'n', 's' },
    },
    -- Noice commands (official recommendation uses <leader>n prefix)
    {
      '<leader>nd',
      function()
        require('noice').cmd 'dismiss'
      end,
      desc = 'Dismiss All Notifications',
    },
    {
      '<leader>nh',
      function()
        require('noice').cmd 'history'
      end,
      desc = 'Noice History',
    },
    {
      '<leader>nl',
      function()
        require('noice').cmd 'last'
      end,
      desc = 'Noice Last Message',
    },
    {
      '<leader>ne',
      function()
        require('noice').cmd 'errors'
      end,
      desc = 'Noice Errors',
    },
  },
}
