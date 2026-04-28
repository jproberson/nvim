require('neo-tree').setup {
  default_component_configs = {
    git_status = {
      symbols = {
        unstaged = 'M',
        staged = 'S',
      },
    },
  },
  filesystem = {
    window = {
      mappings = {
        ['\\'] = 'close_window',
      },
    },
  },
  git_status = {
    window = {
      mappings = {
        ['|'] = 'close_window',
      },
    },
  },
}

vim.keymap.set('n', '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal', silent = true })
vim.keymap.set('n', '|', ':Neotree git_status<CR>', { desc = 'NeoTree git status', silent = true })
