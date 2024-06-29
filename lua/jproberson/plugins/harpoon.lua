return {
	"theprimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		-- Cache the harpoon list
		local harpoon_list = harpoon:list()

		-- basic telescope configuration
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
				})
				:find()
		end

		vim.keymap.set("n", "<leader>A", function()
			harpoon_list:add()
		end, { desc = "harpoon file" })
		vim.keymap.set("n", "<leader>a", function()
			harpoon.ui:toggle_quick_menu(harpoon_list)
		end, { desc = "harpoon quick menu" })
		vim.keymap.set("n", "<leader>1", function()
			harpoon_list:select(1)
		end, {})
		vim.keymap.set("n", "<leader>2", function()
			harpoon_list:select(2)
		end, {})
		vim.keymap.set("n", "<leader>3", function()
			harpoon_list:select(3)
		end, {})
		vim.keymap.set("n", "<leader>4", function()
			harpoon_list:select(4)
		end, {})
		vim.keymap.set("n", "<leader>5", function()
			harpoon_list:select(5)
		end, {})
		vim.keymap.set("n", "<C-e>", function()
			toggle_telescope(harpoon_list)
		end, { desc = "Open harpoon window" })
		vim.keymap.set("n", "<C-S-P>", function()
			harpoon_list:prev()
		end, { desc = "harpoon previous file" })
		vim.keymap.set("n", "<C-S-N>", function()
			harpoon_list:next()
		end, { desc = "harpoon next file" })
	end,
}
