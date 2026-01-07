return {
  'folke/sidekick.nvim',
  dependencies = {
    {
      'zbirenbaum/copilot.lua',
      event = 'InsertEnter',
      build = ':Copilot auth',
      opts = {
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
      },
    },
  },
  opts = {
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
        -- If you install codex CLI for ChatGPT: npm install -g @openai/codex
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
  },
  keys = {
    -- NES (Next Edit Suggestions)
    {
      '<tab>',
      function()
        if not require('sidekick').nes_jump_or_apply() then
          return '<Tab>'
        end
      end,
      expr = true,
      desc = 'Goto/Apply Next Edit Suggestion',
    },

    -- Toggle sidekick
    { '<c-.>', function() require('sidekick.cli').toggle() end, mode = { 'n', 't', 'i', 'x' }, desc = 'Sidekick Toggle' },
    { '<leader>aa', function() require('sidekick.cli').toggle() end, desc = 'Toggle CLI' },
    { '<leader>as', function() require('sidekick.cli').select() end, desc = 'Select CLI' },
    { '<leader>ad', function() require('sidekick.cli').close() end, desc = 'Detach CLI Session' },

    -- Send content
    { '<leader>at', function() require('sidekick.cli').send { msg = '{this}' } end, mode = { 'x', 'n' }, desc = 'Send This' },
    { '<leader>af', function() require('sidekick.cli').send { msg = '{file}' } end, desc = 'Send File' },
    { '<leader>av', function() require('sidekick.cli').send { msg = '{selection}' } end, mode = { 'x' }, desc = 'Send Selection' },

    -- Prompts
    { '<leader>ap', function() require('sidekick.cli').prompt() end, mode = { 'n', 'x' }, desc = 'Select Prompt' },

    -- Direct tool access
    { '<leader>ac', function() require('sidekick.cli').toggle { name = 'claude', focus = true } end, desc = 'Toggle Claude' },
  },
}
