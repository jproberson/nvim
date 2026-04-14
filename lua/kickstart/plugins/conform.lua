-- Detect if buffer's project uses biome
local function has_biome_config(bufnr)
  local buf_path = vim.api.nvim_buf_get_name(bufnr)
  if buf_path == '' then
    return false
  end
  return vim.fs.find({ 'biome.json', 'biome.jsonc' }, {
    upward = true,
    path = vim.fs.dirname(buf_path),
    stop = vim.env.HOME,
  })[1] ~= nil
end

local biome_fts = {
  typescript = true,
  typescriptreact = true,
  javascript = true,
  javascriptreact = true,
  json = true,
}

-- Biome projects: return empty so LSP handles formatting
-- Prettier projects: use prettierd/prettier via conform
local function web_formatter(bufnr)
  if has_biome_config(bufnr) then
    return {}
  end
  return { 'prettierd', 'prettier', stop_after_first = true }
end

return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          local bufnr = vim.api.nvim_get_current_buf()
          local ft = vim.bo[bufnr].filetype
          if biome_fts[ft] and has_biome_config(bufnr) then
            vim.lsp.buf.format { async = true }
          else
            require('conform').format { async = true, lsp_format = 'fallback' }
          end
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        if vim.g.format_on_save == false then
          return nil
        end

        local ft = vim.bo[bufnr].filetype
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[ft] then
          return nil
        end

        if ft == 'lua' then
          return { timeout_ms = 2000, lsp_format = 'never' }
        end

        -- Biome projects: prefer biome LSP for formatting
        if biome_fts[ft] and has_biome_config(bufnr) then
          return { timeout_ms = 500, lsp_format = 'prefer' }
        end

        return { timeout_ms = 500, lsp_format = 'fallback' }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        rust = { 'rustfmt' },
        typescript = web_formatter,
        typescriptreact = web_formatter,
        javascript = web_formatter,
        javascriptreact = web_formatter,
        json = web_formatter,
        yaml = { 'prettierd', 'prettier', stop_after_first = true },
        markdown = { 'prettierd', 'prettier', stop_after_first = true },
        swift = { 'swift_format' },
      },
      formatters = {
        stylua = {
          prepend_args = {
            '--no-editorconfig',
            '--indent-type',
            'Spaces',
            '--indent-width',
            '4',
            '--column-width',
            '120',
          },
        },
      },
    },
  },
}
