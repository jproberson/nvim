local M = {}

-- Central place to define which-key groups
-- Add new prefixes here and they will show up automatically.
M.groups = {
  { '<leader>c', group = '[C]ode' },
  { '<leader>s', group = '[S]earch' },
  { '<leader>t', group = '[T]oggle' },
  { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
  { '<leader>x', group = 'Trouble' },
  { '<leader>d', group = '[D]iffview' },
  { '<leader>g', group = '[G]it' },
  { '<leader>b', group = '[B]reakpoints' },
  { '<leader>u', group = '[U]I' },
  { '<leader>q', group = '[Q]uickfix' },
  { '<leader>f', group = '[F]ormat' },

  -- Non-leader chains
  { 'g', group = 'Goto' },
  { ']', group = 'Next' },
  { '[', group = 'Prev' },
}

function M.spec()
  return M.groups
end

return M

