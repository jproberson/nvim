-- All colorscheme plugins + a picker to switch between them
-- <leader>uT to open the theme picker (persists choice across restarts)

local theme_file = vim.fn.stdpath 'data' .. '/current_theme.txt'

local function get_saved_theme()
  local f = io.open(theme_file, 'r')
  if f then
    local theme = f:read '*l'
    f:close()
    return theme
  end
  return nil
end

local function save_theme(name)
  local f = io.open(theme_file, 'w')
  if f then
    f:write(name)
    f:close()
  end
end

local default_theme = 'cyberdream'

return {
  {
    'scottmckendry/cyberdream.nvim',
    lazy = true,
    priority = 1000,
    opts = {
      italic_comments = false,
      transparent = false,
    },
  },
  {
    'rebelot/kanagawa.nvim',
    lazy = true,
    priority = 1000,
    opts = {
      commentStyle = { italic = false },
      keywordStyle = { italic = false },
      statementStyle = { bold = false },
    },
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = true,
    priority = 1000,
    opts = {
      flavour = 'mocha',
      no_italic = true,
      custom_highlights = function(colors)
        return {
          DiagnosticUnnecessary = { fg = colors.overlay0 },
        }
      end,
    },
  },
  {
    'folke/tokyonight.nvim',
    lazy = true,
    priority = 1000,
    opts = {
      styles = {
        comments = { italic = false },
      },
    },
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = true,
    priority = 1000,
    opts = {
      styles = { italic = false },
    },
  },
  {
    'sainnhe/gruvbox-material',
    lazy = true,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_disable_italic_comment = 1
    end,
  },
  {
    'EdenEast/nightfox.nvim',
    lazy = true,
    priority = 1000,
    opts = {
      options = {
        styles = { comments = '' },
      },
    },
  },
  {
    'neanias/everforest-nvim',
    lazy = true,
    priority = 1000,
    config = function()
      require('everforest').setup {
        italics = false,
      }
    end,
  },
  {
    'craftzdog/solarized-osaka.nvim',
    lazy = true,
    priority = 1000,
    opts = {
      styles = {
        comments = { italic = false },
      },
    },
  },
  {
    'Mofiqul/dracula.nvim',
    lazy = true,
    priority = 1000,
    opts = {
      italic_comment = false,
    },
  },
  {
    -- Dummy plugin entry to set up the picker and apply saved theme
    dir = vim.fn.stdpath 'config',
    name = 'theme-picker',
    priority = 999,
    dependencies = {
      'scottmckendry/cyberdream.nvim',
      'rebelot/kanagawa.nvim',
      'catppuccin',
      'folke/tokyonight.nvim',
      'rose-pine',
      'sainnhe/gruvbox-material',
      'EdenEast/nightfox.nvim',
      'neanias/everforest-nvim',
      'craftzdog/solarized-osaka.nvim',
      'Mofiqul/dracula.nvim',
    },
    config = function()
      local themes = {
        { name = 'cyberdream', colorscheme = 'cyberdream' },
        { name = 'dracula', colorscheme = 'dracula' },
        { name = 'dracula-soft', colorscheme = 'dracula-soft' },
        { name = 'everforest', colorscheme = 'everforest' },
        { name = 'gruvbox-material', colorscheme = 'gruvbox-material' },
        { name = 'kanagawa-dragon', colorscheme = 'kanagawa-dragon' },
        { name = 'kanagawa-wave', colorscheme = 'kanagawa-wave' },
        { name = 'kanagawa-lotus', colorscheme = 'kanagawa-lotus' },
        { name = 'catppuccin-mocha', colorscheme = 'catppuccin-mocha' },
        { name = 'catppuccin-macchiato', colorscheme = 'catppuccin-macchiato' },
        { name = 'catppuccin-frappe', colorscheme = 'catppuccin-frappe' },
        { name = 'catppuccin-latte', colorscheme = 'catppuccin-latte' },
        { name = 'nightfox', colorscheme = 'nightfox' },
        { name = 'carbonfox', colorscheme = 'carbonfox' },
        { name = 'dawnfox', colorscheme = 'dawnfox' },
        { name = 'duskfox', colorscheme = 'duskfox' },
        { name = 'nordfox', colorscheme = 'nordfox' },
        { name = 'terafox', colorscheme = 'terafox' },
        { name = 'rose-pine', colorscheme = 'rose-pine' },
        { name = 'rose-pine-moon', colorscheme = 'rose-pine-moon' },
        { name = 'rose-pine-dawn', colorscheme = 'rose-pine-dawn' },
        { name = 'solarized-osaka', colorscheme = 'solarized-osaka' },
        { name = 'solarized-osaka-storm', colorscheme = 'solarized-osaka-storm' },
        { name = 'tokyonight-night', colorscheme = 'tokyonight-night' },
        { name = 'tokyonight-storm', colorscheme = 'tokyonight-storm' },
        { name = 'tokyonight-moon', colorscheme = 'tokyonight-moon' },
      }

      -- Apply saved theme or default
      local saved = get_saved_theme() or default_theme
      local ok = pcall(vim.cmd.colorscheme, saved)
      if not ok then
        vim.cmd.colorscheme(default_theme)
      end

      vim.keymap.set('n', '<leader>uT', function()
        local pickers = require 'telescope.pickers'
        local finders = require 'telescope.finders'
        local conf = require('telescope.config').values
        local actions = require 'telescope.actions'
        local action_state = require 'telescope.actions.state'

        local current = vim.g.colors_name or ''

        pickers
          .new({}, {
            prompt_title = 'Switch Theme',
            finder = finders.new_table {
              results = themes,
              entry_maker = function(entry)
                local display = entry.name
                if entry.colorscheme == current then
                  display = display .. ' (current)'
                end
                return {
                  value = entry,
                  display = display,
                  ordinal = entry.name,
                }
              end,
            },
            sorter = conf.generic_sorter {},
            attach_mappings = function(prompt_bufnr)
              local last_previewed = nil
              local accepted = false

              -- Poll the current selection so preview works regardless of
              -- how the user navigates (j/k, C-n/C-p, filtering)
              local timer = vim.uv.new_timer()
              timer:start(50, 50, vim.schedule_wrap(function()
                if not vim.api.nvim_buf_is_valid(prompt_bufnr) then
                  timer:stop()
                  return
                end
                local entry = action_state.get_selected_entry()
                if entry and entry.value.colorscheme ~= last_previewed then
                  last_previewed = entry.value.colorscheme
                  pcall(vim.cmd.colorscheme, entry.value.colorscheme)
                end
              end))

              actions.select_default:replace(function()
                local entry = action_state.get_selected_entry()
                accepted = true
                timer:stop()
                actions.close(prompt_bufnr)
                if entry then
                  pcall(vim.cmd.colorscheme, entry.value.colorscheme)
                  save_theme(entry.value.colorscheme)
                end
              end)

              actions.close:enhance {
                post = function()
                  timer:stop()
                  if not accepted then
                    pcall(vim.cmd.colorscheme, current)
                  end
                end,
              }

              return true
            end,
          })
          :find()
      end, { desc = 'Switch [T]heme' })
    end,
  },
}
