-- Merges with nvim-lspconfig's lsp/copilot.lua (adds filetypes so
-- vim.lsp.enable auto-attaches copilot to buffers).
return {
  filetypes = {
    'bash', 'c', 'cpp', 'cs', 'css', 'dart', 'dockerfile', 'elixir',
    'fish', 'go', 'graphql', 'haskell', 'html', 'java', 'javascript',
    'javascriptreact', 'json', 'jsonc', 'kotlin', 'lua', 'make',
    'markdown', 'nix', 'objc', 'ocaml', 'php', 'proto', 'python',
    'ruby', 'rust', 'scss', 'sh', 'sql', 'swift', 'terraform', 'text',
    'toml', 'typescript', 'typescriptreact', 'vim', 'xml', 'yaml',
    'zig', 'zsh',
  },
}
