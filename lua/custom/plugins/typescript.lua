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

        wk.register({
          ['<leader>c'] = {
            name = '+typescript',
            a = { vim.lsp.buf.code_action, 'Code Action' },
            m = { '<cmd>TSToolsAddMissingImports<CR>', 'Add Missing Imports' },
            o = { '<cmd>TSToolsOrganizeImports<CR>', 'Organize Imports' },
            r = { '<cmd>TSToolsRemoveUnused<CR>', 'Remove Unused' },
            f = { '<cmd>TSToolsFixAll<CR>', 'Fix All' },
            S = { '<cmd>TSToolsGoToSourceDefinition<CR>', 'Source Definition' },
          },
        }, { buffer = bufnr })
      end,
    },
  },
  { 'dmmulroy/ts-error-translator.nvim' },
}
