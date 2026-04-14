-- NOTE: run `:Copilot auth` once to sign in.
require('copilot').setup {
  suggestion = {
    enabled = true,
    auto_trigger = true,
    keymap = {
      accept = '<S-Tab>',
      accept_word = '<C-Right>',
      accept_line = '<C-Down>',
      next = '<M-]>',
      prev = '<M-[>',
      dismiss = '<C-]>',
    },
  },
  panel = { enabled = false },
}

require('sidekick').setup {
  nes = {
    enabled = true,
    debounce = 100,
    diff = { inline = 'words' },
  },
  cli = {
    watch = true,
    win = {
      layout = 'right',
      split = { width = 80 },
    },
    tools = {
      claude = { cmd = { 'claude' } },
      codex = { cmd = { 'codex' } },
    },
    prompts = {
      explain = 'Explain {this}',
      fix = 'Can you fix {this}?',
      review = 'Can you review {file} for issues?',
      tests = 'Write tests for {this}',
      document = 'Add documentation to {function|line}',
      refactor = 'Refactor {this} to be more readable',
      optimize = 'Optimize {this} for performance',
    },
    picker = 'snacks',
  },
}

vim.keymap.set('n', '<tab>', function()
  if not require('sidekick').nes_jump_or_apply() then
    return '<Tab>'
  end
end, { expr = true, desc = 'Goto/Apply Next Edit Suggestion' })

vim.keymap.set({ 'n', 't', 'i', 'x' }, '<c-.>', function() require('sidekick.cli').toggle() end, { desc = 'Sidekick Toggle' })
vim.keymap.set('n', '<leader>aa', function() require('sidekick.cli').toggle() end, { desc = 'Toggle CLI' })
vim.keymap.set('n', '<leader>as', function() require('sidekick.cli').select() end, { desc = 'Select CLI' })
vim.keymap.set('n', '<leader>ad', function() require('sidekick.cli').close() end, { desc = 'Detach CLI Session' })

vim.keymap.set({ 'x', 'n' }, '<leader>at', function() require('sidekick.cli').send { msg = '{this}' } end, { desc = 'Send This' })
vim.keymap.set('n', '<leader>af', function() require('sidekick.cli').send { msg = '{file}' } end, { desc = 'Send File' })
vim.keymap.set('x', '<leader>av', function() require('sidekick.cli').send { msg = '{selection}' } end, { desc = 'Send Selection' })

vim.keymap.set({ 'n', 'x' }, '<leader>ap', function() require('sidekick.cli').prompt() end, { desc = 'Select Prompt' })

vim.keymap.set('n', '<leader>ac', function() require('sidekick.cli').toggle { name = 'claude', focus = true } end, { desc = 'Toggle Claude' })
