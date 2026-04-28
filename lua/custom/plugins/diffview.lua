vim.opt.diffopt:append { 'linematch:60', 'algorithm:histogram', 'indent-heuristic' }
vim.opt.fillchars:append { diff = ' ' }

require('diffview').setup {
  enhanced_diff_hl = true,
  show_help_hints = true,
  watch_index = true,
  view = {
    default = { winbar_info = true },
    merge_tool = { layout = 'diff3_mixed' },
  },
  file_panel = {
    win_config = { position = 'left', width = 35 },
    listing_style = 'tree',
  },
  default_args = { DiffviewFileHistory = { '--follow' } },
  hooks = {
    diff_buf_read = function(bufnr)
      vim.opt_local.wrap = false
      vim.opt_local.list = false
      vim.opt_local.colorcolumn = ''
    end,
  },
}

local hl = vim.api.nvim_set_hl
hl(0, 'DiffAdd', { bg = '#1e2e1e' })
hl(0, 'DiffDelete', { bg = '#2e1e1e' })
hl(0, 'DiffChange', { bg = '#1e2530' })
hl(0, 'DiffText', { bg = '#263545', bold = true })

vim.keymap.set('n', '<leader>do', ':DiffviewOpen<CR>', { desc = 'DiffView: Open' })
vim.keymap.set('n', '<leader>dc', ':DiffviewClose<CR>', { desc = 'DiffView: Close' })
vim.keymap.set('n', '<leader>dt', ':DiffviewToggleFiles<CR>', { desc = 'DiffView: Toggle files panel' })
vim.keymap.set('n', '<leader>dr', ':DiffviewRefresh<CR>', { desc = 'DiffView: Refresh' })
vim.keymap.set('n', '<leader>df', ':DiffviewFileHistory %<CR>', { desc = 'DiffView: File history (file)' })
vim.keymap.set('n', '<leader>dF', ':DiffviewFileHistory<CR>', { desc = 'DiffView: Repo history' })

local function get_default_branch()
  local result = vim.fn.system('git rev-parse --verify origin/main 2>/dev/null')
  if vim.v.shell_error == 0 then
    return 'origin/main'
  end
  result = vim.fn.system('git rev-parse --verify origin/master 2>/dev/null')
  if vim.v.shell_error == 0 then
    return 'origin/master'
  end
  result = vim.fn.system('git rev-parse --verify main 2>/dev/null')
  if vim.v.shell_error == 0 then
    return 'main'
  end
  return 'master'
end

vim.keymap.set('n', '<leader>dh', ':DiffviewOpen HEAD~1..HEAD<CR>', { desc = 'DiffView: HEAD~1 vs HEAD' })
vim.keymap.set('n', '<leader>dm', function()
  local branch = get_default_branch()
  vim.cmd('DiffviewOpen ' .. branch .. '...HEAD')
end, { desc = 'DiffView: default branch...HEAD' })
