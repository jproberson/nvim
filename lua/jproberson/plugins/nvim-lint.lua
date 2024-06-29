return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			python = { "pylint" },
			-- markdown = { "vale" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", {
			clear = true,
		})

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		local lint_progress = function()
			local linters = require("lint").get_running()
			if #linters == 0 then
				return "󰦕"
			end
			return "󱉶 " .. table.concat(linters, ", ")
		end

		vim.keymap.set("n", "<leader>fp", function()
			print(lint_progress())
		end, {
			desc = "Show linting progress",
		})

		vim.keymap.set("n", "<leader>fl", function()
			lint.try_lint()
		end, {
			desc = "Trigger linting for current file",
		})
	end,
}
