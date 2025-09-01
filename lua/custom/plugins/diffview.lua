return {
  'sindrets/diffview.nvim',
  config = function()
    -- Clearer, more DSF-like diffs
    vim.opt.diffopt:append { 'linematch:60', 'algorithm:histogram', 'indent-heuristic' }

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
          -- keep things clean like DSF output
          vim.opt_local.wrap = false
          vim.opt_local.list = false
          vim.opt_local.colorcolumn = ''
        end,
      },
    }

    -- Make added/removed lines pop (adjust to taste or your colorscheme)
    local hl = vim.api.nvim_set_hl
    hl(0, 'DiffAdd', { bg = '#0b3d16' })
    hl(0, 'DiffDelete', { bg = '#3d0b0b' })
    hl(0, 'DiffChange', { bg = '#0b2a3d' })
    hl(0, 'DiffText', { bg = '#154760', bold = true })
    hl(0, 'DiffAdded', { fg = '#4fd38a', bold = true })
    hl(0, 'DiffRemoved', { fg = '#ff6b6b', bold = true })

    -- Keymaps
    vim.keymap.set('n', '<leader>do', ':DiffviewOpen<CR>', { desc = 'DiffView: Open' })
    vim.keymap.set('n', '<leader>dc', ':DiffviewClose<CR>', { desc = 'DiffView: Close' })
    vim.keymap.set('n', '<leader>dt', ':DiffviewToggleFiles<CR>', { desc = 'DiffView: Toggle files panel' })
    vim.keymap.set('n', '<leader>dr', ':DiffviewRefresh<CR>', { desc = 'DiffView: Refresh' })
    vim.keymap.set('n', '<leader>df', ':DiffviewFileHistory %<CR>', { desc = 'DiffView: File history (file)' })
    vim.keymap.set('n', '<leader>dF', ':DiffviewFileHistory<CR>', { desc = 'DiffView: Repo history' })

    -- Optional: handy presets
    vim.keymap.set('n', '<leader>dh', ':DiffviewOpen HEAD~1..HEAD<CR>', { desc = 'DiffView: HEAD~1 vs HEAD' })
    vim.keymap.set('n', '<leader>dm', ':DiffviewOpen origin/main...HEAD<CR>', { desc = 'DiffView: main...HEAD' })
  end,
}
