return {
  {
    'echasnovski/mini.nvim',
    config = function()
      -- your existing mini configs
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      require('mini.bracketed').setup()

      -- nice base diff opts (independent of mini.diff)
      vim.opt.diffopt:append { 'linematch:60', 'algorithm:histogram', 'indent-heuristic' }

      -- >>> FIXED: put style/signs/priority inside `view`
      local mini_diff = require 'mini.diff'
      mini_diff.setup {
        view = {
          style = 'number', -- avoid gitsigns conflicts
          signs = { add = '▒', change = '▒', delete = '▒' },
          priority = 199,
        },
        -- you could also set options = { algorithm = "histogram", indent_heuristic = true, linematch = 60 }
      }

      -- Toggle the overlay (unchanged)
      vim.keymap.set('n', '<leader>uO', function()
        if not vim.wo.number and not vim.wo.relativenumber then
          vim.wo.number = true
        end
        mini_diff.toggle_overlay(0)
      end, { desc = 'MiniDiff: Toggle overlay' })

      -- Robust signs toggle that does NOT rely on Snacks being present
      local function mini_diff_is_enabled(bufnr)
        -- When enabled, mini.diff populates buffer variables (see README “Buffer-local variables”).
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

      -- Optional: if Snacks is installed, also register a UI toggle but keep the keymap above
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
        } -- no mapping here; we already mapped <leader>uG directly
      end
    end,
  },
}
