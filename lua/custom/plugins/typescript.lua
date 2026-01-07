return {
  {
    'pmizio/typescript-tools.nvim',
    ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig', 'folke/which-key.nvim' },
    opts = {
      settings = {
        tsserver_file_preferences = {
          includeCompletionsForModuleExports = true,
          quotePreference = 'auto',
        },
      },
      on_attach = function(client, bufnr)
        local wk = require 'which-key'
        local tb = require 'telescope.builtin'

        -- Add TypeScript-specific commands
        wk.add({
          { '<leader>c', buffer = bufnr, group = '[C]ode' },
          { '<leader>ca', vim.lsp.buf.code_action, buffer = bufnr, desc = 'Code Action' },
          { '<leader>cm', '<cmd>TSToolsAddMissingImports<CR>', buffer = bufnr, desc = 'Add Missing Imports' },
          { '<leader>co', '<cmd>TSToolsOrganizeImports<CR>', buffer = bufnr, desc = 'Organize Imports' },
          { '<leader>cu', '<cmd>TSToolsRemoveUnused<CR>', buffer = bufnr, desc = 'Remove Unused' },
          { '<leader>cf', '<cmd>TSToolsFixAll<CR>', buffer = bufnr, desc = 'Fix All' },
          { '<leader>cS', '<cmd>TSToolsGoToSourceDefinition<CR>', buffer = bufnr, desc = 'Source Definition' },
        })

        -- Override default LSP keymaps with Telescope versions for better UI
        wk.add({
          { 'gr', buffer = bufnr, group = 'LSP' },
          { 'grr', tb.lsp_references, buffer = bufnr, desc = 'References' },
          { 'gri', tb.lsp_implementations, buffer = bufnr, desc = 'Implementation' },
          { 'grt', tb.lsp_type_definitions, buffer = bufnr, desc = 'Type Definition' },
          { 'gra', vim.lsp.buf.code_action, buffer = bufnr, desc = 'Code Action' },
          { 'grn', vim.lsp.buf.rename, buffer = bufnr, desc = 'Rename' },
          { 'gd', tb.lsp_definitions, buffer = bufnr, desc = 'Definition' },
          { 'gD', vim.lsp.buf.declaration, buffer = bufnr, desc = 'Declaration' },
          { 'K', vim.lsp.buf.hover, buffer = bufnr, desc = 'Hover Documentation' },
        })
      end,
    },
  },
  { 'dmmulroy/ts-error-translator.nvim' },
}
