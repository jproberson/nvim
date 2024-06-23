return { -- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	config = function() -- This is the function that runs, AFTER loading
		require("which-key").setup()

		-- Document existing key chains
		require("which-key").register({
			["<leader>c"] = {
				name = "[C]ode",
				_ = "which_key_ignore",
			},
			["<leader>d"] = {
				name = "[D]ocument",
				_ = "which_key_ignore",
			},
			["<leader>r"] = {
				name = "[R]ename",
				_ = "which_key_ignore",
			},
			["<leader>s"] = {
				name = "[S]earch",
				_ = "which_key_ignore",
			},
			["<leader>w"] = {
				name = "[W]orkspace",
				_ = "which_key_ignore",
			},
			["<leader>o"] = {
				name = "[O]bsidian",
				_ = "which_key_ignore",
			},
			["<leader>t"] = {
				name = "[T]oggle",
				_ = "which_key_ignore",
			},
			["<leader>M"] = {
				name = "Markdown preview",
				_ = "which_key_ignore",
			},
			["<leader>E"] = {
				name = "[E]xplore splits",
				_ = "which_key_ignore",
			},
			["<leader>1"] = "which_key_ignore",
			["<leader>2"] = "which_key_ignore",
			["<leader>3"] = "which_key_ignore",
			["<leader>4"] = "which_key_ignore",
			["<leader>5"] = "which_key_ignore",
		})
	end,
}
