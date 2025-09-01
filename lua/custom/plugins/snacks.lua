-- lua/plugins/snacks-lazygit.lua
return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    lazygit = { enabled = true },
    terminal = { enabled = true }, -- Snacks.terminal is used under the hood
    styles = {
      -- make lazygit full-screen (can set width/height to fractions like 0.9)
      lazygit = { width = 0, height = 0 },
    },
  },
  keys = (function()
    local function project_root()
      local buf = vim.api.nvim_get_current_buf()
      local start = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ':p:h')
      local git = vim.fs.find('.git', { upward = true, path = start })[1]
      return git and vim.fs.dirname(git) or vim.uv.cwd()
    end
    return {
      {
        '<leader>gg',
        function()
          Snacks.lazygit { cwd = project_root() }
        end,
        desc = 'Lazygit (Root Dir)',
      },
      {
        '<leader>gG',
        function()
          Snacks.lazygit()
        end,
        desc = 'Lazygit (cwd)',
      },
    }
  end)(),
}
