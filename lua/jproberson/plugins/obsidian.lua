return {}
-- local function directory_exists(path)
--     local ok, err, code = os.rename(path, path)
--     if not ok then
--         if code == 13 then
--             -- Permission denied, but it exists
--             return true
--         end
--     end
--     return ok, err
-- end
-- return {
--     'epwalsh/obsidian.nvim',
--     version = '*', -- recommended, use latest release instead of latest commit
--     lazy = false, -- true,
--     dependencies = {'nvim-lua/plenary.nvim'},
--     config = function()
--         local function directory_exists(path)
--             local ok, err, code = os.rename(path, path)
--             if not ok then
--                 if code == 13 then
--                     -- Permission denied, but it exists
--                     return true
--                 end
--             end
--             return ok, err
--         end
--         local work_exists = directory_exists(vim.fn.expand '~/vaults/work')
--         local workspaces = {}
--         if work_exists then
--             table.insert(workspaces, {
--                 name = 'work',
--                 path = '~/vaults/work'
--             })
--         end
--         table.insert(workspaces, {
--             name = 'personal',
--             path = '~/vaults/personal'
--         })
--         require('obsidian').setup {
--             workspaces = workspaces,
--             notes_subdir = 'Notes',
--             templates = {
--                 subdir = 'Templates',
--                 date_format = '%m/%d/%Y',
--                 time_format = '%I:%M %p'
--             },
--             daily_notes = {
--                 folder = 'Notes/Daily',
--                 date_format = '%m-%d-%Y',
--                 alias_format = '%m-%d-%Y'
--             },
--             completion = {
--                 nvim_cmp = true,
--                 min_chars = 2,
--                 new_notes_location = 'notes_subdir',
--                 preferred_link_style = 'wiki',
--                 prepend_note_id = false,
--                 prepend_note_path = false,
--                 use_path_only = false
--             },
--             new_notes_location = 'notes_subdir',
--             use_alias_only = true,
--             disable_frontmatter = false,
--             note_id_func = function(title)
--                 if title ~= nil then
--                     -- Sanitize the title to create a valid filename.
--                     local sanitizedTitle = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
--                     return sanitizedTitle
--                 else
--                     -- Generate a random ID if no title is provided.
--                     local randomId = ''
--                     for _ = 1, 4 do
--                         randomId = randomId .. string.char(math.random(65, 90))
--                     end
--                     return randomId
--                 end
--             end,
--             mappings = {}
--         }
--         local wk = require 'which-key'
--         local obsidian_helpers = require 'helper-functions/obsidian_helpers'
--         wk.register({
--             o = {
--                 name = '+obsidian',
--                 o = {'<cmd>ObsidianOpen<CR>', 'Open Obsidian Note'},
--                 n = {'<cmd>ObsidianNew<CR>', 'Create New Obsidian Note'},
--                 q = {'<cmd>ObsidianQuickSwitch<CR>', 'Quick Switch Obsidian Note'},
--                 f = {'<cmd>ObsidianFollowLink<CR>', 'Follow Link in Obsidian Note'},
--                 -- F = { obsidian_helpers.selectAndInsertTemplate, 'Select Template for New Note' },
--                 w = {obsidian_helpers.OpenWeeklyOncallNote, 'Weekly Oncall Note'},
--                 s = {'<cmd>ObsidianSearch<CR>', 'Search Obsidian Notes'},
--                 t = {'<cmd>ObsidianToday<CR>', "Open Today's Obsidian Note"},
--                 i = {'<cmd>ObsidianTemplate<CR>', 'Insert Obsidian Template'},
--                 c = {function()
--                     require('obsidian').util.toggle_checkbox()
--                 end, 'Toggle checkbox'},
--                 C = {function()
--                     local bufnr = vim.api.nvim_get_current_buf()
--                     local row = vim.api.nvim_win_get_cursor(0)[1]
--                     local current_line = vim.api.nvim_buf_get_lines(bufnr, row - 1, row, true)[1] or ''
--                     local checkbox = '- [ ] '
--                     if string.match(current_line, '^%s*$') then
--                         vim.api.nvim_buf_set_lines(bufnr, row - 1, row, false, {checkbox})
--                     else
--                         vim.api.nvim_buf_set_lines(bufnr, row, row, false, {checkbox, ''})
--                         vim.api.nvim_win_set_cursor(0, {row + 1, #checkbox - 3})
--                     end
--                 end, 'Create checkbox'}
--             }
--         }, {
--             prefix = '<leader>'
--         })
--     end
-- }
