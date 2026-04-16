local Snacks = require 'snacks'
Snacks.setup {
    lazygit = { enabled = true },
    terminal = { enabled = true },
    toggle = { enabled = true },
    picker = {
        enabled = true,
        ui_select = true,
        layout = {
            preset = 'ivy',
            layout = { height = 0 },
        },
        sources = {
            files = { hidden = true },
            grep = { hidden = true },
            grep_word = { hidden = true },
        },
    },
    styles = {
        lazygit = { width = 0, height = 0 },
    },
}

-- Picker keymaps (replaces telescope)
vim.keymap.set('n', '<leader>sf', function()
    Snacks.picker.files()
end, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sg', function()
    Snacks.picker.grep()
end, { desc = '[S]earch by [G]rep' })
vim.keymap.set('v', '<leader>sg', function()
    Snacks.picker.grep_word()
end, { desc = '[S]earch selected text by [G]rep' })
vim.keymap.set('n', '<leader>sw', function()
    Snacks.picker.grep_word()
end, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sh', function()
    Snacks.picker.help()
end, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', function()
    Snacks.picker.keymaps()
end, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sd', function()
    Snacks.picker.diagnostics()
end, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', function()
    Snacks.picker.resume()
end, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>ss', function()
    Snacks.picker.pickers()
end, { desc = '[S]earch [S]elect Picker' })
vim.keymap.set('n', '<leader>s.', function()
    Snacks.picker.recent()
end, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader><leader>', function()
    Snacks.picker.buffers()
end, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>sF', function()
    Snacks.picker.git_status()
end, { desc = '[S]earch Git [F]iles (changed)' })
vim.keymap.set('n', '<leader>gb', function()
    Snacks.picker.git_branches()
end, { desc = '[G]it [B]ranches' })
vim.keymap.set('n', '<leader>/', function()
    Snacks.picker.lines()
end, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>s/', function()
    Snacks.picker.grep_buffers()
end, { desc = '[S]earch [/] in Open Files' })
vim.keymap.set('n', '<leader>sn', function()
    Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })
vim.keymap.set('n', '<leader>so', function()
    Snacks.picker.grep { dirs = { '~/vaults/' } }
end, { desc = 'Search Obsidian' })

Snacks.toggle({
    name = 'Listchars',
    get = function()
        return vim.opt.list:get()
    end,
    set = function(state)
        vim.opt.list = state
    end,
}):map '<leader>uL'

Snacks.toggle({
    name = 'Line Numbers',
    get = function()
        return vim.wo.number
    end,
    set = function(state)
        vim.wo.number = state
    end,
}):map '<leader>un'

Snacks.toggle({
    name = 'Relative Numbers',
    get = function()
        return vim.wo.relativenumber
    end,
    set = function(state)
        vim.wo.relativenumber = state
    end,
}):map '<leader>ur'

Snacks.toggle({
    name = 'Word Wrap',
    get = function()
        return vim.wo.wrap
    end,
    set = function(state)
        vim.wo.wrap = state
    end,
}):map '<leader>uw'

Snacks.toggle({
    name = 'Spell Check',
    get = function()
        return vim.wo.spell
    end,
    set = function(state)
        vim.wo.spell = state
    end,
}):map '<leader>us'

Snacks.toggle({
    name = 'Treesitter Context',
    get = function()
        return require('treesitter-context').enabled()
    end,
    set = function(state)
        if state then
            require('treesitter-context').enable()
        else
            require('treesitter-context').disable()
        end
    end,
}):map '<leader>uc'

Snacks.toggle({
    name = 'Format on Save',
    get = function()
        return vim.g.format_on_save ~= false
    end,
    set = function(state)
        vim.g.format_on_save = state
    end,
}):map '<leader>uf'

Snacks.toggle({
    name = 'Edit Suggestions (NES)',
    get = function()
        return vim.g.sidekick_nes ~= false
    end,
    set = function(state)
        vim.g.sidekick_nes = state
    end,
}):map '<leader>ae'

Snacks.toggle({
    name = 'Copilot',
    get = function()
        return not require('copilot.client').is_disabled()
    end,
    set = function(state)
        if state then
            require('copilot.command').enable()
        else
            require('copilot.command').disable()
        end
    end,
}):map '<leader>ao'

local function project_root()
    local buf = vim.api.nvim_get_current_buf()
    local start = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ':p:h')
    local git = vim.fs.find('.git', { upward = true, path = start })[1]
    return git and vim.fs.dirname(git) or vim.uv.cwd()
end

vim.keymap.set('n', '<leader>gg', function()
    Snacks.lazygit { cwd = project_root() }
end, { desc = 'Lazygit (Root Dir)' })

vim.keymap.set('n', '<leader>gG', function()
    Snacks.lazygit()
end, { desc = 'Lazygit (cwd)' })
