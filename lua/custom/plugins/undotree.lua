-- undotree (vimscript plugin; configured via g: vars)
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_ShortIndicators = 1
vim.g.undotree_WindowLayout = 2
vim.g.undotree_DiffpanelHeight = 10

vim.keymap.set('n', '<leader>U', '<cmd>UndotreeToggle<cr>', { desc = 'Undo Tree' })
