require("jproberson.core.keymaps")
require("jproberson.core.options")


vim.api.nvim_create_autocmd({'FileType'}, {
    pattern = {'json', 'jsonc'},
    callback = function()
        vim.wo.conceallevel = 0
    end
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'markdown'},
    callback = function()
        vim.wo.conceallevel = 2
    end
})
