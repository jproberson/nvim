vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump { count = 1 }
end, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump { count = -1 }
end, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']e', function()
  vim.diagnostic.jump { count = 1, severity = vim.diagnostic.severity.ERROR }
end, { desc = 'Go to next error' })
vim.keymap.set('n', '[e', function()
  vim.diagnostic.jump { count = -1, severity = vim.diagnostic.severity.ERROR }
end, { desc = 'Go to previous error' })
vim.keymap.set('n', ']w', function()
  vim.diagnostic.jump { count = 1, severity = vim.diagnostic.severity.WARN }
end, { desc = 'Go to next warning' })
vim.keymap.set('n', '[w', function()
  vim.diagnostic.jump { count = -1, severity = vim.diagnostic.severity.WARN }
end, { desc = 'Go to previous warning' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et

-- Move line down (normal mode)
vim.keymap.set('n', '<A-J>', ':m .+1<CR>==', { noremap = true, silent = true, desc = 'Move line down' })
vim.keymap.set('n', '<S-A-Down>', ':m .+1<CR>==', { noremap = true, silent = true })
-- Move line up (normal mode)
vim.keymap.set('n', '<A-K>', ':m .-2<CR>==', { noremap = true, silent = true, desc = 'Move line up' })
vim.keymap.set('n', '<S-A-Up>', ':m .-2<CR>==', { noremap = true, silent = true })

-- Move lines down (visual mode)
vim.keymap.set('v', '<A-J>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = 'Move lines down' })
vim.keymap.set('v', '<S-A-Down>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- Move lines up (visual mode)
vim.keymap.set('v', '<A-K>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = 'Move lines up' })
vim.keymap.set('v', '<S-A-Up>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('n', '<D-d>', '<C-d>zz')
vim.keymap.set('n', '<D-u>', '<C-u>zz')

vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- join lines without moving cursor
vim.keymap.set('n', 'J', 'mzJ`z')

vim.keymap.set('n', '=ap', "ma=ap'a")
-- paste without overwriting
vim.keymap.set('x', '<leader>P', [["_dP]])

vim.keymap.set({ 'n', 'v' }, '<leader>D', '"_d', { desc = 'Delete without yanking' })

vim.keymap.set('n', '<leader>cL', '<cmd>LspRestart<cr>', { desc = 'LSP: Restart' })

vim.keymap.set('n', '<leader>uK', '<cmd>WhichKeyCheckGroups<cr>', { desc = 'which-key: Check missing groups' })

vim.keymap.set('n', '<leader>wv', '<cmd>vsplit<cr>', { desc = '[W]indow [V]ertical split' })
vim.keymap.set('n', '<leader>ws', '<cmd>split<cr>', { desc = '[W]indow [S]plit horizontal' })
