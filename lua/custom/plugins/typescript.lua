-- Generic LSP keymaps (gd, gr, K, gD, gI, <leader>ca, <leader>cr, etc.) come
-- from the LspAttach autocmd in lspconfig.lua. typescript-tools is explicitly
-- skipped there, so we replicate the essentials here and add the
-- TypeScript-only commands.
require('typescript-tools').setup {
  settings = {
    tsserver_file_preferences = {
      includeCompletionsForModuleExports = true,
      quotePreference = 'auto',
    },
  },
  on_attach = function(_, bufnr)
    local wk = require 'which-key'
    local tb = require 'telescope.builtin'

    local function map(keys, fn, desc, mode)
      vim.keymap.set(mode or 'n', keys, fn, { buffer = bufnr, desc = 'LSP: ' .. desc })
    end
    map('gd', tb.lsp_definitions, 'Goto Definition')
    map('gr', tb.lsp_references, 'References')
    map('gI', tb.lsp_implementations, 'Goto Implementation')
    map('gy', tb.lsp_type_definitions, 'Goto Type Definition')
    map('gD', vim.lsp.buf.declaration, 'Goto Declaration')
    map('K', vim.lsp.buf.hover, 'Hover')
    map('<leader>ca', vim.lsp.buf.code_action, 'Code Action', { 'n', 'v' })
    map('<leader>cr', vim.lsp.buf.rename, 'Rename')

    wk.add {
      { '<leader>c', buffer = bufnr, group = '[C]ode' },
      { '<leader>cm', '<cmd>TSToolsAddMissingImports<CR>', buffer = bufnr, desc = 'Add Missing Imports' },
      { '<leader>co', '<cmd>TSToolsOrganizeImports<CR>', buffer = bufnr, desc = 'Organize Imports' },
      { '<leader>cu', '<cmd>TSToolsRemoveUnused<CR>', buffer = bufnr, desc = 'Remove Unused' },
      { '<leader>cf', '<cmd>TSToolsFixAll<CR>', buffer = bufnr, desc = 'Fix All' },
      { '<leader>cS', '<cmd>TSToolsGoToSourceDefinition<CR>', buffer = bufnr, desc = 'Source Definition' },
    }
  end,
}

require('ts-error-translator').setup {}
