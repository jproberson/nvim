local M = {}

local function leader_prefixes_in_maps(modes)
  modes = modes or { 'n', 'v', 'x' }
  local found = {}
  for _, mode in ipairs(modes) do
    for _, km in ipairs(vim.api.nvim_get_keymap(mode)) do
      local lhs = km.lhs or ''
      local pref = lhs:match('^<leader>(.)')
      if pref then
        found[pref] = true
      end
    end
  end
  return found
end

local function defined_groups()
  local spec = require('config.whichkey-groups').spec()
  local set = {}
  for _, item in ipairs(spec or {}) do
    local lhs = item[1]
    if type(lhs) == 'string' then
      local pref = lhs:match('^<leader>(.)')
      if pref then
        set[pref] = true
      end
    end
  end
  return set
end

function M.check_missing()
  local used = leader_prefixes_in_maps()
  local have = defined_groups()
  local missing = {}
  for pref, _ in pairs(used) do
    if not have[pref] then
      table.insert(missing, pref)
    end
  end
  table.sort(missing)
  if #missing == 0 then
    vim.notify('which-key: no missing <leader> groups', vim.log.levels.INFO)
  else
    vim.notify('which-key: missing groups for <leader> ' .. table.concat(missing, ', '), vim.log.levels.WARN)
  end
end

function M.setup()
  vim.api.nvim_create_user_command('WhichKeyCheckGroups', function()
    M.check_missing()
  end, { desc = 'List <leader> prefixes without which-key group' })
end

return M

