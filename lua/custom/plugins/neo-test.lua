local neotest = require 'neotest'

local vitest_configs = { 'vitest.config.ts', 'vitest.config.js', 'vitest.config.mts', 'vite.config.ts', 'vite.config.js', 'vite.config.mts' }
local jest_configs = { 'jest.config.js', 'jest.config.ts', 'jest.config.mjs', 'jest.config.cjs' }

local function find_ancestor_file(path, filenames)
  return vim.fs.root(path, filenames)
end

neotest.setup {
  adapters = {
    require 'neotest-vitest' {
      vitestCommand = 'npx vitest',
      is_test_file = function(file_path)
        if not string.match(file_path, '%.spec%.[jt]sx?$') and not string.match(file_path, '%.test%.[jt]sx?$') then
          return false
        end
        return find_ancestor_file(file_path, vitest_configs) ~= nil
      end,
      filter_dir = function(name)
        return name ~= 'node_modules'
      end,
      cwd = function(path)
        return find_ancestor_file(path, vitest_configs) or vim.fn.getcwd()
      end,
    },
    require 'neotest-jest' {
      jestCommand = 'npx jest',
      is_test_file = function(file_path)
        if not string.match(file_path, '%.spec%.[jt]sx?$') and not string.match(file_path, '%.test%.[jt]sx?$') then
          return false
        end
        return find_ancestor_file(file_path, jest_configs) ~= nil
      end,
      filter_dir = function(name)
        return name ~= 'node_modules'
      end,
      cwd = function(path)
        return find_ancestor_file(path, jest_configs) or vim.fn.getcwd()
      end,
    },
    require 'rustaceanvim.neotest',
    require 'neotest-dotnet' {
      dap = { justMyCode = false },
    },
  },
  floating = {
    border = 'rounded',
    max_height = 0.8,
    max_width = 0.8,
  },
  summary = {
    open = 'botright vsplit | vertical resize 50',
  },
}

vim.keymap.set('n', '<leader>tt', function() neotest.run.run() end, { desc = '[T]est Run Nearest' })
vim.keymap.set('n', '<leader>tf', function() neotest.run.run(vim.fn.expand '%') end, { desc = '[T]est Run [F]ile' })
vim.keymap.set('n', '<leader>ta', function() neotest.run.run(vim.fn.getcwd()) end, { desc = '[T]est Run [A]ll' })
vim.keymap.set('n', '<leader>ts', function() neotest.summary.toggle() end, { desc = '[T]est [S]ummary' })
vim.keymap.set('n', '<leader>to', function() neotest.output.open { enter = true } end, { desc = '[T]est [O]utput' })
vim.keymap.set('n', '<leader>tO', function() neotest.output_panel.toggle() end, { desc = '[T]est [O]utput Panel' })
vim.keymap.set('n', '<leader>tS', function() neotest.run.stop() end, { desc = '[T]est [S]top' })
vim.keymap.set('n', '<leader>td', function() neotest.run.run { strategy = 'dap' } end, { desc = '[T]est [D]ebug Nearest' })
