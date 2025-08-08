return {
  {
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*', -- stick to stable releases so fuzzy binaries download
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (vim.fn.has 'win32' == 0 and vim.fn.executable 'make' == 1) and 'make install_jsregexp' or nil,
        dependencies = {
          -- Optional: load VSCode-style snippets if you want them
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        opts = {},
      },
      'folke/lazydev.nvim', -- Lua LSP enhancement for Neovim config files
    },

    --- @type blink.cmp.Config
    opts = {
      keymap = { preset = 'default' },
      appearance = { nerd_font_variant = 'mono' },

      completion = {
        documentation = {
          auto_show = false,
          auto_show_delay_ms = 500,
        },
      },

      sources = {
        -- Common completion sources for most workflows
        default = {
          'lsp', -- Language server completions (TypeScript, C#, etc.)
          'path', -- Filesystem paths
          'snippets', -- LuaSnip
          'buffer', -- Words from current buffer
          'lazydev', -- Lua dev (for Neovim config)
        },
        providers = {
          lazydev = {
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
        },
      },

      snippets = { preset = 'luasnip' },

      -- Fast matching & ranking
      fuzzy = {
        implementation = 'prefer_rust', -- downloads prebuilt Rust binary
      },

      signature = { enabled = true }, -- Function signature help while typing
    },
  },
}
