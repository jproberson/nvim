require('nvim-treesitter').setup()

require('nvim-treesitter').install({
  'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline',
  'query', 'rust', 'vim', 'vimdoc', 'javascript', 'typescript', 'tsx', 'json', 'css',
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
