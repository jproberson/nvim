-- Built-in opt-in plugins (nvim 0.12) — :Undotree and :DiffTool stay available
vim.cmd.packadd('nvim.undotree')
vim.cmd.packadd('nvim.difftool')

-- mbbill/undotree provides a richer UI (diff panel, timestamps); use it for the
-- main keymap. The builtin :Undotree command is still callable directly.
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_ShortIndicators = 1
vim.g.undotree_WindowLayout = 2
vim.g.undotree_DiffpanelHeight = 10

vim.keymap.set('n', '<leader>U', '<cmd>UndotreeToggle<cr>', { desc = 'Undo Tree' })
