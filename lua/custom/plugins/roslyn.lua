local caps = require('blink.cmp').get_lsp_capabilities()
vim.lsp.config('roslyn', { capabilities = caps })
require('roslyn').setup {
  filewatching = 'roslyn',
}
