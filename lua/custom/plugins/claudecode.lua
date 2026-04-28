-- claudecode.nvim: launches the same `claude` CLI binary as sidekick, but
-- connects it to Neovim over the IDE/MCP protocol so edits show up as native
-- diff splits and @-mentions pull live buffer/selection state.
--
-- Sidekick's <leader>ac (terminal-paste Claude) is intentionally kept; this
-- exposes the MCP-integrated variant on <leader>aC.
--
-- Diff-review keys (<leader>aa accept, <leader>ad deny) are set buffer-local
-- by the plugin inside its diff buffers, so we don't bind global accept/deny.

require('claudecode').setup {
  diff_opts = {
    layout = 'vertical',
    open_in_current_tab = true,
  },
}

local map = vim.keymap.set

map('n', '<leader>aC', '<cmd>ClaudeCode<cr>', { desc = 'Toggle Claude (claudecode.nvim)' })
map('n', '<leader>aF', '<cmd>ClaudeCodeFocus<cr>', { desc = 'Focus Claude (claudecode.nvim)' })
map('n', '<leader>aR', '<cmd>ClaudeCode --resume<cr>', { desc = 'Resume Claude session' })
map('n', '<leader>aB', '<cmd>ClaudeCodeAdd %<cr>', { desc = 'Add current buffer to Claude' })

-- Single key for both modes: visual sends selection, normal sends buffer.
map({ 'n', 'v' }, '<leader>aS', '<cmd>ClaudeCodeSend<cr>', { desc = 'Send buffer/selection to Claude' })
