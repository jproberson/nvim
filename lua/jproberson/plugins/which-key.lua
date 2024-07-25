return {
	"folke/which-key.nvim",
	event = "VimEnter",
	config = function()
		require("which-key").setup()

		local wk = require("which-key")
		wk.add({
			{ "<leader>1", hidden = true },
			{ "<leader>2", hidden = true },
			{ "<leader>3", hidden = true },
			{ "<leader>4", hidden = true },
			{ "<leader>5", hidden = true },
			{ "<leader>E", group = "[E]xplore splits" },
			{ "<leader>E_", hidden = true },
			{ "<leader>c", group = "[C]ode" },
			{ "<leader>c_", hidden = true },
			{ "<leader>d", group = "[D]ocument" },
			{ "<leader>d_", hidden = true },
			{ "<leader>f", group = "[F]ormat" },
			{ "<leader>f_", hidden = true },
			{ "<leader>h", group = "Git" },
			{ "<leader>h_", hidden = true },
			{ "<leader>l", group = "[L]azy" },
			{ "<leader>l_", hidden = true },
			{ "<leader>o", group = "[O]bsidian" },
			{ "<leader>o_", hidden = true },
			{ "<leader>p", group = "[P]review" },
			{ "<leader>p_", hidden = true },
			{ "<leader>r", group = "[R]ename" },
			{ "<leader>r_", hidden = true },
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>s_", hidden = true },
			{ "<leader>t", group = "[T]abs" },
			{ "<leader>t_", hidden = true },
			{ "<leader>w", group = "[W]orkspace" },
			{ "<leader>w_", hidden = true },
			{ "<leader>x", group = "Trouble keys" },
			{ "<leader>x_", hidden = true },
		})
	end,
}
