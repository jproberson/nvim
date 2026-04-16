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

-- Per-colorscheme setup is deferred until the theme is actually selected.
-- Each entry is: colorscheme name → function that calls the plugin's setup().
-- The ColorSchemePre autocmd runs the matching setup exactly once the first
-- time that scheme is applied.

vim.g.gruvbox_material_disable_italic_comment = 1

local theme_setups = {
  cyberdream = function()
    require('cyberdream').setup { italic_comments = false, transparent = false }
  end,
  kanagawa = function()
    require('kanagawa').setup {
      commentStyle = { italic = false },
      keywordStyle = { italic = false },
      statementStyle = { bold = false },
    }
  end,
  catppuccin = function()
    require('catppuccin').setup {
      flavour = 'mocha',
      no_italic = true,
      custom_highlights = function(colors)
        return {
          DiagnosticUnnecessary = { fg = colors.overlay0 },
        }
      end,
    }
  end,
  tokyonight = function()
    require('tokyonight').setup { styles = { comments = { italic = false } } }
  end,
  ['rose-pine'] = function()
    require('rose-pine').setup { styles = { italic = false } }
  end,
  nightfox = function()
    require('nightfox').setup { options = { styles = { comments = '' } } }
  end,
  everforest = function()
    require('everforest').setup { italics = false }
  end,
  ['solarized-osaka'] = function()
    require('solarized-osaka').setup { styles = { comments = { italic = false } } }
  end,
  dracula = function()
    require('dracula').setup { italic_comment = false }
  end,
  onedark = function()
    require('onedark').setup { style = 'darker', code_style = { comments = 'none' } }
  end,
}

local cs_to_key = {
  cyberdream = 'cyberdream',
  kanagawa = 'kanagawa', ['kanagawa-dragon'] = 'kanagawa', ['kanagawa-wave'] = 'kanagawa', ['kanagawa-lotus'] = 'kanagawa',
  ['catppuccin-mocha'] = 'catppuccin', ['catppuccin-macchiato'] = 'catppuccin',
  ['catppuccin-frappe'] = 'catppuccin', ['catppuccin-latte'] = 'catppuccin',
  ['tokyonight-night'] = 'tokyonight', ['tokyonight-storm'] = 'tokyonight', ['tokyonight-moon'] = 'tokyonight',
  ['rose-pine'] = 'rose-pine', ['rose-pine-moon'] = 'rose-pine', ['rose-pine-dawn'] = 'rose-pine',
  nightfox = 'nightfox', carbonfox = 'nightfox', dawnfox = 'nightfox',
  duskfox = 'nightfox', nordfox = 'nightfox', terafox = 'nightfox',
  everforest = 'everforest',
  ['solarized-osaka'] = 'solarized-osaka', ['solarized-osaka-storm'] = 'solarized-osaka',
  dracula = 'dracula', ['dracula-soft'] = 'dracula',
  onedark = 'onedark',
}

local configured = {}
local function ensure_configured(cs)
  local key = cs_to_key[cs]
  if not key or configured[key] then
    return
  end
  configured[key] = true
  theme_setups[key]()
end

vim.api.nvim_create_autocmd('ColorSchemePre', {
  callback = function(ev)
    ensure_configured(ev.match)
  end,
})

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
  { name = 'onedark', colorscheme = 'onedark' },
  { name = 'nord', colorscheme = 'nord' },
  { name = 'oxocarbon', colorscheme = 'oxocarbon' },
}

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
    .new(require('telescope.themes').get_dropdown { winblend = 10 }, {
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
