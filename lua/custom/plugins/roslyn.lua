return {
  'seblyng/roslyn.nvim',
  ft = { 'cs', 'vb' },
  opts = {
    filewatching = 'roslyn',
  },
  config = function(_, opts)
    -- give Roslyn the same completion capabilities you use elsewhere
    local caps = require('blink.cmp').get_lsp_capabilities()
    vim.lsp.config('roslyn', { capabilities = caps })
    require('roslyn').setup(opts)
  end,
}
