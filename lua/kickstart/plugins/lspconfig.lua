-- LSP Plugins
return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'mason-org/mason.nvim',
        opts = {
          registries = {
            'github:mason-org/mason-registry',
            'github:Crashdummyy/mason-registry',
          },
        },
      },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      -- LSP attach: LazyVim-style keymaps
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local tb = require 'telescope.builtin'

          local function map(keys, fn, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, fn, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- LazyVim-like LSP keymaps
          map('<leader>cl', function()
            vim.cmd 'LspInfo'
          end, 'Lsp Info')
          map('gd', tb.lsp_definitions, 'Goto Definition')
          map('gr', tb.lsp_references, 'References')
          map('gI', tb.lsp_implementations, 'Goto Implementation')
          map('gy', tb.lsp_type_definitions, 'Goto Type Definition')
          map('gD', vim.lsp.buf.declaration, 'Goto Declaration')
          map('K', vim.lsp.buf.hover, 'Hover')
          map('gK', vim.lsp.buf.signature_help, 'Signature Help')
          vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { buffer = event.buf, desc = 'LSP: Signature Help' })
          map('<leader>ca', vim.lsp.buf.code_action, 'Code Action', { 'n', 'v' })
          map('<leader>cr', vim.lsp.buf.rename, 'Rename')
          map('<leader>cA', function()
            vim.lsp.buf.code_action { context = { only = { 'source' }, diagnostics = {} } }
          end, 'Source Action')
          map('gO', tb.lsp_document_symbols, 'Document Symbols')
          map('gW', tb.lsp_dynamic_workspace_symbols, 'Workspace Symbols')

          -- CodeLens (if supported)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          local function supports(method)
            if not client then
              return false
            end
            return client.supports_method and client:supports_method(method)
          end


          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, event.buf)
            else
              return client.supports_method and client.supports_method(method, { bufnr = event.buf })
            end
          end
          if supports(vim.lsp.protocol.Methods.textDocument_codeLens) and vim.lsp.codelens then
            map('<leader>cc', vim.lsp.codelens.run, 'Run Codelens', { 'n', 'v' })
            map('<leader>cC', vim.lsp.codelens.refresh, 'Refresh & Display Codelens')
            vim.lsp.codelens.refresh()
          end

          -- Document highlight (same behavior you had)
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

          -- Inlay hints toggle
          if supports(vim.lsp.protocol.Methods.textDocument_inlayHint) and vim.lsp.inlay_hint then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, 'Toggle Inlay Hints')
          end

          -- LazyVim-style "Rename File" (uses LSP file ops when available)
          local function rename_file()
            local old = vim.api.nvim_buf_get_name(0)
            vim.ui.input({ prompt = 'New path: ', default = old }, function(new)
              if not new or new == '' or new == old then
                return
              end
              local params = { files = { { oldUri = vim.uri_from_fname(old), newUri = vim.uri_from_fname(new) } } }
              for _, cli in pairs(vim.lsp.get_clients { bufnr = event.buf }) do
                local ok1 = cli.supports_method and cli:supports_method 'workspace/willRenameFiles'
                local ok2 = cli.supports_method and cli.supports_method('workspace/willRenameFiles', { bufnr = event.buf })
                if ok1 or ok2 then
                  local resp = cli.request_sync and cli.request_sync('workspace/willRenameFiles', params, 1000, event.buf)
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

          -- Optional: next/prev reference (if RRethy/vim-illuminate is installed)
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

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
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

      -- LSP servers configuration
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
            },
          },
          on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
