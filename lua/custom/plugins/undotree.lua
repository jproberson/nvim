return {
  'mbbill/undotree',
  cmd = 'UndotreeToggle', -- Lazy load on command
  keys = {
    { '<leader>U', '<cmd>UndotreeToggle<cr>', desc = 'Undo Tree' },
  },
  config = function()
    -- Focus the undo tree when opened
    vim.g.undotree_SetFocusWhenToggle = 1

    -- Use short timestamps
    vim.g.undotree_ShortIndicators = 1

    -- Position on the right side
    vim.g.undotree_WindowLayout = 2

    -- Diff window height
    vim.g.undotree_DiffpanelHeight = 10
  end,
}
