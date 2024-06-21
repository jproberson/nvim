-- Your Harpoon plugin setup
return {
    'theprimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {'nvim-lua/plenary.nvim'},
    config = function()
        require('harpoon').setup()
    end,
    keys = {{
        '<leader>A',
        function()
            require('harpoon.mark').add_file()
        end,
        desc = 'harpoon file'
    }, {
        '<leader>a',
        function()
            require('harpoon.ui').toggle_quick_menu()
        end,
        desc = 'harpoon quick menu'
    }, {'<leader>1', function()
        require('harpoon.ui').nav_file(1)
    end}, {'<leader>2', function()
        require('harpoon.ui').nav_file(2)
    end}, {'<leader>3', function()
        require('harpoon.ui').nav_file(3)
    end}, {'<leader>4', function()
        require('harpoon.ui').nav_file(4)
    end}, {'<leader>5', function()
        require('harpoon.ui').nav_file(5)
    end}}
}
