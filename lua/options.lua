vim.o.number = true
-- vim.o.relativenumber = true

vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Schedule clipboard sync after UiEnter to reduce startup time
vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true

vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = 'yes'

vim.o.updatetime = 250

vim.o.timeoutlen = 300

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = false
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

vim.o.cursorline = true

-- Higher scrolloff = more room for which-key popup
vim.o.scrolloff = 8

vim.o.confirm = true

vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.shiftround = true
vim.o.smartindent = true

-- Override tab width to 2 for JS/TS/web filetypes
vim.api.nvim_create_autocmd('FileType', {
    pattern = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'json',
        'yaml',
        'html',
        'css',
        'scss',
    },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
})

-- conceallevel required for obsidian.nvim UI features
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'markdown' },
    callback = function()
        vim.opt_local.conceallevel = 2
    end,
})

-- vim: ts=2 sts=2 sw=2 et
