local Snacks = require 'snacks'
Snacks.setup {
  lazygit = { enabled = true },
  terminal = { enabled = true },
  toggle = { enabled = true },
  styles = {
    lazygit = { width = 0, height = 0 },
  },
}

Snacks.toggle({
  name = 'Listchars',
  get = function() return vim.opt.list:get() end,
  set = function(state) vim.opt.list = state end,
}):map '<leader>uL'

Snacks.toggle({
  name = 'Line Numbers',
  get = function() return vim.wo.number end,
  set = function(state) vim.wo.number = state end,
}):map '<leader>un'

Snacks.toggle({
  name = 'Relative Numbers',
  get = function() return vim.wo.relativenumber end,
  set = function(state) vim.wo.relativenumber = state end,
}):map '<leader>ur'

Snacks.toggle({
  name = 'Word Wrap',
  get = function() return vim.wo.wrap end,
  set = function(state) vim.wo.wrap = state end,
}):map '<leader>uw'

Snacks.toggle({
  name = 'Spell Check',
  get = function() return vim.wo.spell end,
  set = function(state) vim.wo.spell = state end,
}):map '<leader>us'

Snacks.toggle({
  name = 'Treesitter Context',
  get = function() return require('treesitter-context').enabled() end,
  set = function(state)
    if state then
      require('treesitter-context').enable()
    else
      require('treesitter-context').disable()
    end
  end,
}):map '<leader>uc'

Snacks.toggle({
  name = 'Format on Save',
  get = function() return vim.g.format_on_save ~= false end,
  set = function(state) vim.g.format_on_save = state end,
}):map '<leader>uf'

Snacks.toggle({
  name = 'Edit Suggestions (NES)',
  get = function() return vim.g.sidekick_nes ~= false end,
  set = function(state) vim.g.sidekick_nes = state end,
}):map '<leader>ae'

Snacks.toggle({
  name = 'Copilot',
  get = function() return not require('copilot.client').is_disabled() end,
  set = function(state)
    if state then
      require('copilot.command').enable()
    else
      require('copilot.command').disable()
    end
  end,
}):map '<leader>ao'

local function project_root()
  local buf = vim.api.nvim_get_current_buf()
  local start = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ':p:h')
  local git = vim.fs.find('.git', { upward = true, path = start })[1]
  return git and vim.fs.dirname(git) or vim.uv.cwd()
end

vim.keymap.set('n', '<leader>gg', function()
  Snacks.lazygit { cwd = project_root() }
end, { desc = 'Lazygit (Root Dir)' })

vim.keymap.set('n', '<leader>gG', function()
  Snacks.lazygit()
end, { desc = 'Lazygit (cwd)' })
