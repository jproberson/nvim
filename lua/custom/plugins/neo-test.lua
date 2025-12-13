return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    -- Test adapters for different languages
    'marilari88/neotest-vitest', -- Vitest for JavaScript/TypeScript
    'rustaceanvim', -- Rust (uses rustaceanvim's test adapter)
    'Issafalcon/neotest-dotnet', -- C#/.NET
  },
  config = function()
    local neotest = require 'neotest'

    neotest.setup {
      adapters = {
        -- Vitest for JavaScript/TypeScript
        require 'neotest-vitest' {
          filter_dir = function(name, rel_path, root)
            return name ~= 'node_modules'
          end,
          -- For monorepos: find the nearest package with vite.config
          cwd = function(path)
            -- Start from the test file and walk up to find vite.config.ts
            local current = vim.fn.fnamemodify(path, ':h')
            while current ~= '/' do
              if vim.fn.filereadable(current .. '/vite.config.ts') == 1 or vim.fn.filereadable(current .. '/vitest.config.ts') == 1 then
                return current
              end
              current = vim.fn.fnamemodify(current, ':h')
            end
            return vim.fn.getcwd()
          end,
        },
        -- Rust tests (via rustaceanvim)
        require 'rustaceanvim.neotest',
        -- .NET/C# tests
        require 'neotest-dotnet' {
          dap = { justMyCode = false },
        },
      },
      -- Floating window configuration
      floating = {
        border = 'rounded',
        max_height = 0.8,
        max_width = 0.8,
      },
      -- Summary window configuration
      summary = {
        open = 'botright vsplit | vertical resize 50',
      },
    }

    -- Keymaps for test running
    vim.keymap.set('n', '<leader>tt', function()
      neotest.run.run()
    end, { desc = '[T]est Run Nearest' })

    vim.keymap.set('n', '<leader>tf', function()
      neotest.run.run(vim.fn.expand '%')
    end, { desc = '[T]est Run [F]ile' })

    vim.keymap.set('n', '<leader>ta', function()
      neotest.run.run(vim.fn.getcwd())
    end, { desc = '[T]est Run [A]ll' })

    vim.keymap.set('n', '<leader>ts', function()
      neotest.summary.toggle()
    end, { desc = '[T]est [S]ummary' })

    vim.keymap.set('n', '<leader>to', function()
      neotest.output.open { enter = true }
    end, { desc = '[T]est [O]utput' })

    vim.keymap.set('n', '<leader>tO', function()
      neotest.output_panel.toggle()
    end, { desc = '[T]est [O]utput Panel' })

    vim.keymap.set('n', '<leader>tS', function()
      neotest.run.stop()
    end, { desc = '[T]est [S]top' })

    vim.keymap.set('n', '<leader>td', function()
      neotest.run.run { strategy = 'dap' }
    end, { desc = '[T]est [D]ebug Nearest' })
  end,
}
