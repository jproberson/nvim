local M = {}

-- Returns true if a biome.json(c) is found anywhere between the buffer's dir
-- and $HOME. Used to prefer biome LSP over prettier/eslint when present.
function M.has_biome_config(bufnr)
  local buf_path = vim.api.nvim_buf_get_name(bufnr or 0)
  if buf_path == '' then
    return false
  end
  return vim.fs.find({ 'biome.json', 'biome.jsonc' }, {
    upward = true,
    path = vim.fs.dirname(buf_path),
    stop = vim.env.HOME,
  })[1] ~= nil
end

return M
