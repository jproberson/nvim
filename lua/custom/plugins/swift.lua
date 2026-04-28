-- sourcekit-lsp comes bundled with Xcode, not installed via Mason
vim.lsp.config('sourcekit', {
  cmd = { 'xcrun', 'sourcekit-lsp' },
  filetypes = { 'swift', 'objective-c', 'objective-cpp' },
  root_markers = {
    'buildServer.json',
    '*.xcodeproj',
    '*.xcworkspace',
    'compile_commands.json',
    'Package.swift',
    '.git',
  },
})
vim.lsp.enable('sourcekit')

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'swift',
  callback = function(ev)
    vim.keymap.set('n', '<leader>sb', '<cmd>!swift build<cr>', { buffer = ev.buf, desc = '[S]wift [B]uild' })
    vim.keymap.set('n', '<leader>sr', '<cmd>!swift run<cr>', { buffer = ev.buf, desc = '[S]wift [R]un' })
    vim.keymap.set('n', '<leader>st', '<cmd>!swift test<cr>', { buffer = ev.buf, desc = '[S]wift [T]est' })
    vim.keymap.set('n', '<leader>sp', '<cmd>!swift package resolve<cr>', { buffer = ev.buf, desc = '[S]wift [P]ackage resolve' })
  end,
})

-- Swift treesitter requires an older tree-sitter CLI version; syntax
-- highlighting uses vim's built-in Swift support instead.
