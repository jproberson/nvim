-- Plugin installation via vim.pack (Neovim 0.12 builtin).
--
-- Build-step reminders (vim.pack does NOT run these):
--   - nvim-treesitter:        run `:TSUpdate` after first load and periodically.
--   - telescope-fzf-native:   run `make` inside the plugin dir for the native sorter.
--       path: ~/.local/share/nvim/site/pack/core/opt/telescope-fzf-native.nvim
--       (cd there && make)
--   - LuaSnip:                run `make install_jsregexp` in the plugin dir if you use
--                             snippet transformations (regex-based). Optional.
--   - copilot.lua:            run `:Copilot auth` once to sign in.
--   - blink.cmp:              fuzzy matcher Rust binary is auto-downloaded at runtime
--                             (via fuzzy.implementation = 'prefer_rust'); no manual build.

vim.pack.add({
  { src = 'https://github.com/NMAC427/guess-indent.nvim' },

  { src = 'https://github.com/lewis6991/gitsigns.nvim' },

  { src = 'https://github.com/folke/which-key.nvim' },

  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' }, -- build: make
  { src = 'https://github.com/nvim-telescope/telescope-ui-select.nvim' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },

  { src = 'https://github.com/folke/lazydev.nvim' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
  { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
  { src = 'https://github.com/j-hui/fidget.nvim' },

  { src = 'https://github.com/stevearc/conform.nvim' },

  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.*') },
  { src = 'https://github.com/L3MON4D3/LuaSnip', version = vim.version.range('2.*') }, -- build: make install_jsregexp (optional)
  { src = 'https://github.com/rafamadriz/friendly-snippets' },

  { src = 'https://github.com/folke/todo-comments.nvim' },

  { src = 'https://github.com/echasnovski/mini.nvim' },

  -- pinned to master: the default `main` branch is a rewrite with a different API.
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'master' },

  { src = 'https://github.com/mfussenegger/nvim-dap' },
  { src = 'https://github.com/rcarriga/nvim-dap-ui' },
  { src = 'https://github.com/nvim-neotest/nvim-nio' },
  { src = 'https://github.com/jay-babu/mason-nvim-dap.nvim' },
  { src = 'https://github.com/leoluz/nvim-dap-go' },

  { src = 'https://github.com/lukas-reineke/indent-blankline.nvim' },

  { src = 'https://github.com/mfussenegger/nvim-lint' },

  { src = 'https://github.com/windwp/nvim-autopairs' },

  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim' },
  { src = 'https://github.com/MunifTanjim/nui.nvim' },

  -- custom plugins --------------------------------------------------------

  { src = 'https://github.com/saecki/crates.nvim' },

  { src = 'https://github.com/sindrets/diffview.nvim' },

  { src = 'https://github.com/ThePrimeagen/harpoon', version = 'harpoon2' },

  { src = 'https://github.com/RRethy/vim-illuminate' },

  { src = 'https://github.com/nvim-neotest/neotest' },
  { src = 'https://github.com/antoinemadec/FixCursorHold.nvim' },
  { src = 'https://github.com/marilari88/neotest-vitest' },
  { src = 'https://github.com/nvim-neotest/neotest-jest' },
  { src = 'https://github.com/Issafalcon/neotest-dotnet' },

  { src = 'https://github.com/folke/noice.nvim' },

  { src = 'https://github.com/epwalsh/obsidian.nvim' },

  -- mini.icons is a module inside mini.nvim; mini.nvim is already added
  { src = 'https://github.com/stevearc/oil.nvim' },

  { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim' },

  { src = 'https://github.com/seblyng/roslyn.nvim' },

  { src = 'https://github.com/mrcjkb/rustaceanvim', version = vim.version.range('^6') },

  { src = 'https://github.com/Aasim-A/scrollEOF.nvim' },

  { src = 'https://github.com/folke/sidekick.nvim' },
  { src = 'https://github.com/zbirenbaum/copilot.lua' }, -- run :Copilot auth

  { src = 'https://github.com/folke/snacks.nvim' },

  -- themes
  { src = 'https://github.com/scottmckendry/cyberdream.nvim' },
  { src = 'https://github.com/rebelot/kanagawa.nvim' },
  { src = 'https://github.com/catppuccin/nvim' },
  { src = 'https://github.com/folke/tokyonight.nvim' },
  { src = 'https://github.com/rose-pine/neovim' },
  { src = 'https://github.com/sainnhe/gruvbox-material' },
  { src = 'https://github.com/EdenEast/nightfox.nvim' },
  { src = 'https://github.com/neanias/everforest-nvim' },
  { src = 'https://github.com/craftzdog/solarized-osaka.nvim' },
  { src = 'https://github.com/Mofiqul/dracula.nvim' },
  { src = 'https://github.com/navarasu/onedark.nvim' },
  { src = 'https://github.com/shaunsingh/nord.nvim' },
  { src = 'https://github.com/nyoom-engineering/oxocarbon.nvim' },
  { src = 'https://github.com/maxmx03/fluoromachine.nvim' },
  { src = 'https://github.com/hyperb1iss/silkcircuit-nvim' },

  { src = 'https://github.com/akinsho/toggleterm.nvim' },

  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-context' },

  { src = 'https://github.com/folke/trouble.nvim' },

  { src = 'https://github.com/pmizio/typescript-tools.nvim' },
  { src = 'https://github.com/dmmulroy/ts-error-translator.nvim' },

  { src = 'https://github.com/mbbill/undotree' },
})
