vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>xw', function()
  local root = vim.fs.root(0, { 'tsconfig.json', '*.csproj', '*.sln', 'Cargo.toml', 'Package.swift', 'go.mod' })
  if not root then
    vim.notify('No recognized project root found', vim.log.levels.WARN)
    return
  end

  local cmd, efm
  if vim.fs.find('tsconfig.json', { path = root, limit = 1 })[1] then
    cmd = 'npx tsc --noEmit --pretty false'
    efm = '%f(%l\\,%c): error %m,%f(%l\\,%c): warning %m'
  elseif vim.fs.find(function(name) return name:match('%.csproj$') or name:match('%.sln$') end, { path = root, limit = 1 })[1] then
    cmd = 'dotnet build --no-restore --nologo'
    efm = '%f(%l\\,%c): error %m,%f(%l\\,%c): warning %m'
  elseif vim.fs.find('Cargo.toml', { path = root, limit = 1 })[1] then
    cmd = 'cargo check --message-format=short 2>&1'
    efm = '%f:%l:%c: %m'
  elseif vim.fs.find('Package.swift', { path = root, limit = 1 })[1] then
    cmd = 'swift build 2>&1'
    efm = '%f:%l:%c: %m'
  elseif vim.fs.find('go.mod', { path = root, limit = 1 })[1] then
    cmd = 'go build ./... 2>&1'
    efm = '%f:%l:%c: %m'
  end

  vim.notify('Running: ' .. cmd, vim.log.levels.INFO)
  local output = vim.fn.systemlist('cd ' .. vim.fn.shellescape(root) .. ' && ' .. cmd)

  -- Make relative paths absolute so quickfix jumps work regardless of cwd
  for i, line in ipairs(output) do
    if not line:match('^/') and line:match('^[%w%.]+') then
      output[i] = root .. '/' .. line
    end
  end

  vim.fn.setqflist({}, ' ', { title = cmd, lines = output, efm = efm })
  vim.cmd('copen')
end, { desc = 'Workspace type-check (project-aware)' })
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
