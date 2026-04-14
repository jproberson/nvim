-- Leader keys must be set before plugins load
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

require 'options'
require 'keymaps'
require 'pack'

-- Load order respects dependencies:
--   blink.cmp provides LSP capabilities used by lspconfig / roslyn / swift
--   snacks sets the global `Snacks` which mini.lua checks for
--   treesitter early so treesitter-context / render-markdown work
--   themes early so a colorscheme is set ASAP
require 'custom.plugins.themes'

require 'kickstart.plugins.which-key'
require 'kickstart.plugins.gitsigns'
require 'kickstart.plugins.telescope'
require 'kickstart.plugins.treesitter'
require 'custom.plugins.treesitter-context'

require 'kickstart.plugins.blink-cmp'

require 'kickstart.plugins.lspconfig'
require 'kickstart.plugins.conform'
require 'kickstart.plugins.lint'

require 'kickstart.plugins.todo-comments'

-- snacks before mini (mini checks for the `Snacks` global)
require 'custom.plugins.snacks'
require 'kickstart.plugins.mini'

require 'kickstart.plugins.debug'

require 'kickstart.plugins.indent_line'
require 'kickstart.plugins.autopairs'
require 'kickstart.plugins.neo-tree'

require('guess-indent').setup {}

require 'custom.plugins.crates'
require 'custom.plugins.diffview'
require 'custom.plugins.harpoon'
require 'custom.plugins.illuminate'
require 'custom.plugins.neo-test'
require 'custom.plugins.noice'
require 'custom.plugins.obsidian'
require 'custom.plugins.oil'
require 'custom.plugins.render-markdown'
require 'custom.plugins.roslyn'
require 'custom.plugins.rustaceannvim'
require 'custom.plugins.scrolleof'
require 'custom.plugins.sidekick'
require 'custom.plugins.swift'
require 'custom.plugins.toggleterm'
require 'custom.plugins.trouble'
require 'custom.plugins.typescript'
require 'custom.plugins.undotree'

-- vim: ts=2 sts=2 sw=2 et
