require('lazydev').setup {
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}

require('mason').setup {
  registries = {
    'github:mason-org/mason-registry',
    'github:Crashdummyy/mason-registry',
  },
}
require('fidget').setup {}

local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.name == 'typescript-tools' then
      return
    end
    local function map(keys, fn, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, fn, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('gd', function() Snacks.picker.lsp_definitions() end, 'Goto Definition')
    map('gr', function() Snacks.picker.lsp_references() end, 'References')
    map('gI', function() Snacks.picker.lsp_implementations() end, 'Goto Implementation')
    map('gy', function() Snacks.picker.lsp_type_definitions() end, 'Goto Type Definition')
    map('gD', vim.lsp.buf.declaration, 'Goto Declaration')
    map('K', vim.lsp.buf.hover, 'Hover')
    map('gK', vim.lsp.buf.signature_help, 'Signature Help')
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { buffer = event.buf, desc = 'LSP: Signature Help' })
    map('<leader>ca', vim.lsp.buf.code_action, 'Code Action', { 'n', 'v' })
    map('<leader>cr', vim.lsp.buf.rename, 'Rename')
    map('<leader>cA', function()
      vim.lsp.buf.code_action { context = { only = { 'source' }, diagnostics = {} } }
    end, 'Source Action')
    map('gO', function() Snacks.picker.lsp_symbols() end, 'Document Symbols')
    map('gW', function() Snacks.picker.lsp_workspace_symbols() end, 'Workspace Symbols')

    local function supports(method)
      if not client then
        return false
      end
      return client:supports_method(method, event.buf)
    end

    if supports(vim.lsp.protocol.Methods.textDocument_codeLens) and vim.lsp.codelens then
      map('<leader>cc', vim.lsp.codelens.run, 'Run Codelens', { 'n', 'v' })
      map('<leader>cC', vim.lsp.codelens.refresh, 'Refresh & Display Codelens')
      vim.lsp.codelens.refresh()
    end

    if supports(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })
      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(ev)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = highlight_augroup, buffer = ev.buf }
        end,
      })
    end

    if supports(vim.lsp.protocol.Methods.textDocument_inlayHint) and vim.lsp.inlay_hint then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, 'Toggle Inlay Hints')
    end

    local function rename_file()
      local old = vim.api.nvim_buf_get_name(0)
      vim.ui.input({ prompt = 'New path: ', default = old }, function(new)
        if not new or new == '' or new == old then
          return
        end
        local params = { files = { { oldUri = vim.uri_from_fname(old), newUri = vim.uri_from_fname(new) } } }
        for _, cli in pairs(vim.lsp.get_clients { bufnr = event.buf }) do
          if cli:supports_method('workspace/willRenameFiles', event.buf) then
            local resp = cli:request_sync('workspace/willRenameFiles', params, 1000, event.buf)
            if resp and resp.result then
              vim.lsp.util.apply_workspace_edit(resp.result, cli.offset_encoding)
            end
          end
        end
        vim.fn.mkdir(vim.fn.fnamemodify(new, ':h'), 'p')
        os.rename(old, new)
        vim.cmd.edit(vim.fn.fnameescape(new))
      end)
    end
    map('<leader>cR', rename_file, 'Rename File')

    local ok, illuminate = pcall(require, 'illuminate')
    if ok then
      map(']]', function()
        illuminate.goto_next_reference(true)
      end, 'Next Reference')
      map('[[', function()
        illuminate.goto_prev_reference(true)
      end, 'Prev Reference')
      vim.keymap.set('n', '<A-n>', function()
        illuminate.goto_next_reference(true)
      end, { buffer = event.buf, desc = 'LSP: Next Reference' })
      vim.keymap.set('n', '<A-p>', function()
        illuminate.goto_prev_reference(true)
      end, { buffer = event.buf, desc = 'LSP: Prev Reference' })
    end
  end,
})

vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
}

-- Default config applied to every server (capabilities from blink.cmp)
vim.lsp.config('*', {
  capabilities = capabilities,
})

-- Per-server overrides. Server cmd/filetypes/root_markers come from
-- nvim-lspconfig's lsp/<name>.lua definitions; we only override what we need.
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      completion = { callSnippet = 'Replace' },
    },
  },
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
})

require('mason-tool-installer').setup {
  ensure_installed = { 'lua_ls', 'stylua' },
}

-- mason-lspconfig v2 auto-calls vim.lsp.enable() for every mason-installed LSP.
-- Exclude TS servers: typescript-tools.nvim handles TypeScript.
require('mason-lspconfig').setup {
  automatic_enable = { exclude = { 'ts_ls', 'vtsls' } },
}
