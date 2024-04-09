-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Autoopen Nvim-tree upon entering Nvim
vim.api.nvim_create_autocmd("VimEnter", {
	desc = "Autoopen Nvim-tree upon entering Nvim",
	callback = function()
		require("nvim-tree.api").tree.open()
	end,
})
