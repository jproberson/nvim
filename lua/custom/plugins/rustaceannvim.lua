return {
  'mrcjkb/rustaceanvim',
  version = '^6', -- Recommended
  lazy = false, -- This plugin is already lazy
  config = function()
    -- Cargo/Rust commands
    vim.keymap.set('n', '<leader>rd', '<cmd>!cargo doc --open<cr>', { desc = '[R]ust [D]oc open' })
    vim.keymap.set('n', '<leader>rr', '<cmd>!cargo run<cr>', { desc = '[R]ust [R]un' })
    vim.keymap.set('n', '<leader>rb', '<cmd>!cargo build<cr>', { desc = '[R]ust [B]uild' })
    vim.keymap.set('n', '<leader>rt', '<cmd>!cargo test<cr>', { desc = '[R]ust [T]est' })
    vim.keymap.set('n', '<leader>rc', '<cmd>!cargo check<cr>', { desc = '[R]ust [C]heck' })
  end,
}
