-- Copilot via native vim.lsp (nvim-lspconfig ships the config).
-- Run `:LspCopilotSignIn` once to authenticate.
vim.lsp.enable('copilot')

-- Enable inline completions when copilot attaches
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('copilot-inline-completion', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == 'copilot' and client:supports_method('textDocument/inlineCompletion', args.buf) then
      vim.lsp.inline_completion.enable(true, { bufnr = args.buf })
    end
  end,
})

vim.keymap.set('i', '<S-Tab>', function() vim.lsp.inline_completion.get() end, { desc = 'Trigger inline completion' })
vim.keymap.set('i', '<M-]>', function() vim.lsp.inline_completion.select() end, { desc = 'Accept/cycle inline completion' })

require('sidekick').setup {
  nes = {
    -- Uses the default function so vim.g.sidekick_nes toggle (snacks) works
    debounce = 100,
    diff = { inline = 'words' },
  },
  cli = {
    watch = true,
    win = {
      layout = 'right',
      split = { width = 80 },
    },
    -- Use defaults for all tools (claude, codex, copilot, gemini, etc.)
    prompts = {
      explain = 'Explain {this}',
      fix = 'Can you fix {this}?',
      review = 'Can you review {file} for any issues or improvements?',
      tests = 'Can you write tests for {this}?',
      document = 'Add documentation to {function|line}',
      refactor = 'Refactor {this} to be more readable',
      optimize = 'How can {this} be optimized?',
      changes = 'Can you review my changes?',
      diagnostics = 'Can you help me fix the diagnostics in {file}?\n{diagnostics}',
    },
    picker = 'snacks',
  },
}

vim.keymap.set('n', '<tab>', function()
  if not require('sidekick').nes_jump_or_apply() then
    return '<Tab>'
  end
end, { expr = true, desc = 'Goto/Apply Next Edit Suggestion' })

vim.keymap.set({ 'n', 't', 'i', 'x' }, '<c-.>', function() require('sidekick.cli').focus() end, { desc = 'Sidekick Focus' })
vim.keymap.set('n', '<leader>aa', function() require('sidekick.cli').toggle() end, { desc = 'Toggle CLI' })
vim.keymap.set('n', '<leader>as', function() require('sidekick.cli').select() end, { desc = 'Select CLI' })
vim.keymap.set('n', '<leader>ad', function() require('sidekick.cli').close() end, { desc = 'Detach CLI Session' })

vim.keymap.set({ 'x', 'n' }, '<leader>at', function() require('sidekick.cli').send { msg = '{this}' } end, { desc = 'Send This' })
vim.keymap.set('n', '<leader>af', function() require('sidekick.cli').send { msg = '{file}' } end, { desc = 'Send File' })
vim.keymap.set('x', '<leader>av', function() require('sidekick.cli').send { msg = '{selection}' } end, { desc = 'Send Selection' })
vim.keymap.set('n', '<leader>aD', function() require('sidekick.cli').send { msg = '{diagnostics}' } end, { desc = 'Send Diagnostics' })

vim.keymap.set({ 'n', 'x' }, '<leader>ap', function() require('sidekick.cli').prompt() end, { desc = 'Select Prompt' })

vim.keymap.set('n', '<leader>ac', function() require('sidekick.cli').toggle { name = 'claude', focus = true } end, { desc = 'Toggle Claude' })
