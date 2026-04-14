-- rustaceanvim auto-initializes; only keymaps needed here.
vim.keymap.set('n', '<leader>rd', '<cmd>!cargo doc --open<cr>', { desc = '[R]ust [D]oc open' })
vim.keymap.set('n', '<leader>rr', '<cmd>!cargo run<cr>', { desc = '[R]ust [R]un' })
vim.keymap.set('n', '<leader>rf', function()
  local file = vim.fn.expand '%:p'
  local out = '/tmp/rust_out'
  vim.cmd('TermExec cmd="rustc ' .. file .. ' -o ' .. out .. ' && ' .. out .. '"')
end, { desc = '[R]ust [F]ile run (single file)' })
vim.keymap.set('n', '<leader>rR', function()
  local args = vim.fn.input('Cargo run args: ')
  if args ~= '' then
    vim.cmd('!cargo run -- ' .. args)
  else
    vim.cmd('!cargo run')
  end
end, { desc = '[R]ust [R]un with args' })
vim.keymap.set('n', '<leader>rb', '<cmd>!cargo build<cr>', { desc = '[R]ust [B]uild' })
vim.keymap.set('n', '<leader>rt', '<cmd>!cargo test<cr>', { desc = '[R]ust [T]est' })
vim.keymap.set('n', '<leader>rc', '<cmd>!cargo check<cr>', { desc = '[R]ust [C]heck' })
