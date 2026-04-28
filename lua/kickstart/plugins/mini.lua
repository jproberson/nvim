require('mini.ai').setup { n_lines = 500 }
require('mini.surround').setup()

local statusline = require 'mini.statusline'
statusline.setup { use_icons = vim.g.have_nerd_font }

---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function()
  return '%2l:%-2v'
end

require('mini.bracketed').setup()

vim.opt.diffopt:append { 'linematch:60', 'algorithm:histogram', 'indent-heuristic' }

local mini_diff = require 'mini.diff'
mini_diff.setup {
  view = {
    style = 'number',
    signs = { add = '▒', change = '▒', delete = '▒' },
    priority = 199,
  },
}

vim.keymap.set('n', '<leader>uO', function()
  if not vim.wo.number and not vim.wo.relativenumber then
    vim.wo.number = true
  end
  mini_diff.toggle_overlay(0)
end, { desc = 'MiniDiff: Toggle overlay' })

local function mini_diff_is_enabled(bufnr)
  return vim.b[bufnr].minidiff_summary ~= nil
end

local function toggle_minidiff_signs(bufnr)
  bufnr = bufnr or 0
  if mini_diff_is_enabled(bufnr) then
    mini_diff.disable(bufnr)
  else
    mini_diff.enable(bufnr)
  end
  vim.defer_fn(function()
    vim.cmd 'redraw!'
  end, 100)
end

vim.keymap.set('n', '<leader>uG', function()
  toggle_minidiff_signs(0)
end, { desc = 'MiniDiff: Toggle signs (current buffer)' })

if package.loaded['snacks'] or vim.g.loaded_snacks then
  Snacks.toggle {
    name = 'Mini Diff Signs',
    get = function()
      return mini_diff_is_enabled(0)
    end,
    set = function(state)
      if state and not mini_diff_is_enabled(0) then
        mini_diff.enable(0)
      elseif (not state) and mini_diff_is_enabled(0) then
        mini_diff.disable(0)
      end
      vim.defer_fn(function()
        vim.cmd 'redraw!'
      end, 100)
    end,
  }
end
