vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("n", "<leader>e", ":Explore<CR>", {
	noremap = true,
	silent = true,
})

keymap.set("n", "<leader>Ev", ":Vex!<CR>", {
	desc = "Open vertical file explorer",
	noremap = true,
	silent = true,
})

keymap.set("n", "<leader>Eh", ":Sex<CR>", {
	desc = "Open horizontal file explorer",
	noremap = true,
	silent = true,
})

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", {
	desc = "Exit insert mode with jk",
})

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
keymap.set("n", "<leader>/", ":nohl<CR>", {
	desc = "Clear search highlights",
})

keymap.set("n", "J", "mzJ`z", {
	desc = "Join line and keep position",
})
keymap.set("n", "<C-d>", "<C-d>zz", {
	desc = "Page down and center",
})
keymap.set("n", "<C-u>", "<C-u>zz", {
	desc = "Page up and center",
})
keymap.set("n", "<leader>pv", vim.cmd.Ex, {
	desc = "Open Ex mode",
})
keymap.set("v", "J", ":m '>+1<CR>gv=gv", {
	desc = "Move text block down",
})
keymap.set("v", "K", ":m '<-2<CR>gv=gv", {
	desc = "Move text block up",
})
keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, {
	desc = "Toggle undo tree",
})

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", {
	desc = "Split window vertically",
}) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", {
	desc = "Split window horizontally",
}) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", {
	desc = "Make splits equal size",
}) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", {
	desc = "Close current split",
}) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", {
	desc = "Open new tab",
}) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", {
	desc = "Close current tab",
}) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", {
	desc = "Go to next tab",
}) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", {
	desc = "Go to previous tab",
}) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", {
	desc = "Open current buffer in new tab",
}) --  move current buffer to new tab

keymap.set("n", "<C-h>", "<C-w><C-h>", {
	desc = "Move focus to the left window",
})
keymap.set("n", "<C-l>", "<C-w><C-l>", {
	desc = "Move focus to the right window",
})
keymap.set("n", "<C-j>", "<C-w><C-j>", {
	desc = "Move focus to the lower window",
})
keymap.set("n", "<C-k>", "<C-w><C-k>", {
	desc = "Move focus to the upper window",
})
