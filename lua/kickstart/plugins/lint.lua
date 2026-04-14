return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        rust = { 'clippy' },
      }

      -- Find eslint in node_modules
      local function find_eslint()
        local node_modules = vim.fn.finddir('node_modules', '.;')
        if node_modules ~= '' then
          local eslint_bin = node_modules .. '/.bin/eslint'
          if vim.fn.executable(eslint_bin) == 1 then
            return eslint_bin
          end
        end
        return 'eslint' -- fallback to global
      end

      lint.linters.eslint.cmd = find_eslint()

      -- Detect if current buffer's project uses biome
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

      local js_ts_fts = {
        javascript = true,
        javascriptreact = true,
        typescript = true,
        typescriptreact = true,
      }

      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      -- lint.linters_by_ft = lint.linters_by_ft or {}
      -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
      --
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- You can disable the default linters by setting their filetypes to nil:
      -- lint.linters_by_ft['clojure'] = nil
      -- lint.linters_by_ft['dockerfile'] = nil
      -- lint.linters_by_ft['inko'] = nil
      -- lint.linters_by_ft['janet'] = nil
      -- lint.linters_by_ft['json'] = nil
      lint.linters_by_ft['markdown'] = nil
      -- lint.linters_by_ft['rst'] = nil
      -- lint.linters_by_ft['ruby'] = nil
      -- lint.linters_by_ft['terraform'] = nil
      -- lint.linters_by_ft['text'] = nil

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          if not vim.bo.modifiable then
            return
          end

          -- Dynamically choose linter for JS/TS based on project config
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
    end,
  },
}
