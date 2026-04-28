-- DAP setup for Go, Rust, JS/TS, and C#.

local dap = require 'dap'
local dapui = require 'dapui'

require('mason-nvim-dap').setup {
  automatic_installation = true,
  ensure_installed = {
    'delve',
    'codelldb',
    'js-debug-adapter',
    'netcoredbg',
  },
}

dapui.setup()
dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close

-- Go
require('dap-go').setup {
  delve = {
    detached = vim.fn.has 'win32' == 0,
  },
}

-- Rust (codelldb)
local mason_path = vim.fn.stdpath 'data' .. '/mason/packages'
local codelldb_root = mason_path .. '/codelldb/extension/'
local codelldb_path = codelldb_root .. 'adapter/codelldb'
local liblldb_path

if vim.fn.has 'mac' == 1 then
  liblldb_path = codelldb_root .. 'lldb/lib/liblldb.dylib'
elseif vim.fn.has 'linux' == 1 then
  liblldb_path = codelldb_root .. 'lldb/lib/liblldb.so'
elseif vim.fn.has 'win32' == 1 then
  liblldb_path = codelldb_root .. 'lldb/bin/liblldb.dll'
end

dap.adapters.codelldb = {
  type = 'server',
  port = '${port}',
  executable = {
    command = codelldb_path,
    args = { '--port', '${port}' },
  },
}

dap.configurations.rust = {
  {
    name = 'Launch (auto cargo target)',
    type = 'codelldb',
    request = 'launch',
    program = function()
      local ok, result = pcall(function()
        local output = vim.fn.system 'cargo metadata --format-version 1 --no-deps'
        if vim.v.shell_error ~= 0 or not output or output == '' then
          return nil
        end
        local metadata = vim.fn.json_decode(output)
        local crate = metadata.packages[1].name
        return vim.fn.getcwd() .. '/target/debug/' .. crate
      end)
      if ok and result and vim.fn.filereadable(result) == 1 then
        return result
      end
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

-- JS/TS
require('dap').adapters['pwa-node'] = {
  type = 'server',
  host = 'localhost',
  port = '${port}',
  executable = {
    command = 'js-debug-adapter',
    args = { '${port}' },
  },
}

for _, language in ipairs { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' } do
  dap.configurations[language] = {
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch file',
      program = '${file}',
      cwd = '${workspaceFolder}',
    },
    {
      type = 'pwa-node',
      request = 'attach',
      name = 'Attach',
      processId = require('dap.utils').pick_process,
      cwd = '${workspaceFolder}',
    },
  }
end

-- C#/.NET
dap.adapters.coreclr = {
  type = 'executable',
  command = 'netcoredbg',
  args = { '--interpreter=vscode' },
}

dap.configurations.cs = {
  {
    type = 'coreclr',
    name = 'launch - netcoredbg',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
  },
}

-- Keymaps
vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<F1>', function() require('dap').step_into() end, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F2>', function() require('dap').step_over() end, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F3>', function() require('dap').step_out() end, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end, { desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>B', function()
  require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = 'Debug: Set Conditional Breakpoint' })
vim.keymap.set('n', '<F7>', function() require('dapui').toggle() end, { desc = 'Debug: Toggle UI' })
