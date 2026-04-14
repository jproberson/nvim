require('toggleterm').setup {
  size = function(term)
    if term.direction == 'horizontal' then
      return 15
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_terminals = true,
  start_in_insert = true,
  insert_mappings = true,
  terminal_mappings = true,
  persist_size = true,
  persist_mode = true,
  direction = 'float',
  close_on_exit = true,
  shell = vim.o.shell,
  auto_scroll = true,
  float_opts = {
    border = 'curved',
    winblend = 0,
  },
}

vim.keymap.set('n', '<leader>TT', '<cmd>ToggleTerm<cr>', { desc = '[T]erminal [T]oggle' })
vim.keymap.set('n', '<leader>Tf', '<cmd>ToggleTerm direction=float<cr>', { desc = '[T]erminal [F]loat' })
vim.keymap.set('n', '<leader>Th', '<cmd>ToggleTerm direction=horizontal<cr>', { desc = '[T]erminal [H]orizontal' })
vim.keymap.set('n', '<leader>Tv', '<cmd>ToggleTerm direction=vertical<cr>', { desc = '[T]erminal [V]ertical' })

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'
