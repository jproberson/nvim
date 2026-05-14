-- Drop the treesitter provider: nvim-treesitter (pinned to master) hits a
-- nil-node bug in locals.lua:286 (`attempt to call method 'parent'`) on
-- startup. LSP is the preferred provider when available, regex is the
-- fallback for buffers without an LSP attached.
require('illuminate').configure {
  delay = 100,
  providers = { 'lsp', 'regex' },
}
