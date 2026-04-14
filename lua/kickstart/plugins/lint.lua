local lint = require 'lint'
lint.linters_by_ft = {
  markdown = { 'markdownlint' },
  rust = { 'clippy' },
}

local function find_eslint()
  local node_modules = vim.fn.finddir('node_modules', '.;')
  if node_modules ~= '' then
    local eslint_bin = node_modules .. '/.bin/eslint'
    if vim.fn.executable(eslint_bin) == 1 then
      return eslint_bin
    end
  end
  return 'eslint'
end

lint.linters.eslint.cmd = find_eslint()

local has_biome_config = require('util.biome').has_biome_config

local js_ts_fts = {
  javascript = true,
  javascriptreact = true,
  typescript = true,
  typescriptreact = true,
}

lint.linters_by_ft['markdown'] = nil

local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function()
    if not vim.bo.modifiable then
      return
    end

    local ft = vim.bo.filetype
    if js_ts_fts[ft] then
      if has_biome_config(0) then
        lint.linters_by_ft[ft] = { 'biomejs' }
      else
        lint.linters_by_ft[ft] = { 'eslint' }
      end
    end

    lint.try_lint()
  end,
})
