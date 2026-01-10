-- lua/plugins/snacks-lazygit.lua
return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    lazygit = { enabled = true },
    terminal = { enabled = true }, -- Snacks.terminal is used under the hood
    toggle = { enabled = true },
    styles = {
      -- make lazygit full-screen (can set width/height to fractions like 0.9)
      lazygit = { width = 0, height = 0 },
    },
  },
  config = function(_, opts)
    local Snacks = require 'snacks'
    Snacks.setup(opts)

    -- Toggle: listchars
    Snacks.toggle({
      name = 'Listchars',
      get = function()
        return vim.opt.list:get()
      end,
      set = function(state)
        vim.opt.list = state
      end,
    }):map '<leader>uL'

    -- Toggle: line numbers
    Snacks.toggle({
      name = 'Line Numbers',
      get = function()
        return vim.wo.number
      end,
      set = function(state)
        vim.wo.number = state
      end,
    }):map '<leader>un'

    -- Toggle: relative line numbers
    Snacks.toggle({
      name = 'Relative Numbers',
      get = function()
        return vim.wo.relativenumber
      end,
      set = function(state)
        vim.wo.relativenumber = state
      end,
    }):map '<leader>ur'

    -- Toggle: word wrap
    Snacks.toggle({
      name = 'Word Wrap',
      get = function()
        return vim.wo.wrap
      end,
      set = function(state)
        vim.wo.wrap = state
      end,
    }):map '<leader>uw'

    -- Toggle: spell check
    Snacks.toggle({
      name = 'Spell Check',
      get = function()
        return vim.wo.spell
      end,
      set = function(state)
        vim.wo.spell = state
      end,
    }):map '<leader>us'

    -- Toggle: treesitter context
    Snacks.toggle({
      name = 'Treesitter Context',
      get = function()
        return require('treesitter-context').enabled()
      end,
      set = function(state)
        if state then
          require('treesitter-context').enable()
        else
          require('treesitter-context').disable()
        end
      end,
    }):map '<leader>uc'

    -- Toggle: Sidekick NES (Next Edit Suggestions)
    Snacks.toggle({
      name = 'Edit Suggestions (NES)',
      get = function()
        return vim.g.sidekick_nes ~= false
      end,
      set = function(state)
        vim.g.sidekick_nes = state
      end,
    }):map '<leader>ae'

    -- Toggle: Copilot
    Snacks.toggle({
      name = 'Copilot',
      get = function()
        return not require('copilot.client').is_disabled()
      end,
      set = function(state)
        if state then
          require('copilot.command').enable()
        else
          require('copilot.command').disable()
        end
      end,
    }):map '<leader>ao'
  end,
  keys = (function()
    local function project_root()
      local buf = vim.api.nvim_get_current_buf()
      local start = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ':p:h')
      local git = vim.fs.find('.git', { upward = true, path = start })[1]
      return git and vim.fs.dirname(git) or vim.uv.cwd()
    end
    return {
      {
        '<leader>gg',
        function()
          Snacks.lazygit { cwd = project_root() }
        end,
        desc = 'Lazygit (Root Dir)',
      },
      {
        '<leader>gG',
        function()
          Snacks.lazygit()
        end,
        desc = 'Lazygit (cwd)',
      },
    }
  end)(),
}
