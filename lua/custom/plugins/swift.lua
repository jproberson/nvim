-- Swift LSP and tooling support
-- Note: sourcekit-lsp comes bundled with Xcode, not installed via Mason

local swift_lsp_configured = false

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'swift', 'objective-c', 'objective-cpp' },
  callback = function()
    -- Only configure sourcekit once
    if not swift_lsp_configured then
      swift_lsp_configured = true

      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local util = require 'lspconfig.util'

      require('lspconfig').sourcekit.setup {
        capabilities = capabilities,
        cmd = { 'xcrun', 'sourcekit-lsp' },
        filetypes = { 'swift', 'objective-c', 'objective-cpp' },
        root_dir = function(filename, _)
          return util.root_pattern('buildServer.json')(filename)
            or util.root_pattern('*.xcodeproj', '*.xcworkspace')(filename)
            or util.root_pattern('compile_commands.json', 'Package.swift')(filename)
            or util.find_git_ancestor(filename)
        end,
      }
    end

    -- Start LSP for this buffer
    vim.cmd 'LspStart sourcekit'
  end,
})

-- Swift keymaps
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'swift',
  callback = function(ev)
    vim.keymap.set('n', '<leader>sb', '<cmd>!swift build<cr>', { buffer = ev.buf, desc = '[S]wift [B]uild' })
    vim.keymap.set('n', '<leader>sr', '<cmd>!swift run<cr>', { buffer = ev.buf, desc = '[S]wift [R]un' })
    vim.keymap.set('n', '<leader>st', '<cmd>!swift test<cr>', { buffer = ev.buf, desc = '[S]wift [T]est' })
    vim.keymap.set('n', '<leader>sp', '<cmd>!swift package resolve<cr>', { buffer = ev.buf, desc = '[S]wift [P]ackage resolve' })
  end,
})

-- Note: Swift treesitter requires an older tree-sitter CLI version.
-- Syntax highlighting will use vim's built-in Swift support instead.
return {}
