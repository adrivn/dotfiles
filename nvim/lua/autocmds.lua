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

-- Auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd("VimResized", {
	command = "wincmd =",
})

-- Restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.cmd('normal! g`"zz')
		end
	end,
})

-- Set local settings for terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "term://*",
	callback = function()
		if vim.opt.buftype:get() == "terminal" then
			local set = vim.opt_local
			set.number = false -- Don't show numbers
			set.relativenumber = false -- Don't show relativenumbers
			set.scrolloff = 0 -- Don't scroll when at the top or bottom of the terminal buffer
			vim.opt.filetype = "terminal"

			vim.cmd.startinsert() -- Start in insert mode
		end
	end,
})

-- Disable folding and status line on alpha buffer
vim.cmd([[ autocmd FileType alpha setlocal nofoldenable ]])
vim.api.nvim_create_autocmd({ "User", "BufEnter" }, {
	callback = function(params)
		local is_empty_file = vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "nofile"
		local is_filetype_alpha = vim.api.nvim_get_option_value("filetype", { buf = 0 }) == "alpha"
		if
			(
				(params.event == "User" and params.file == "AlphaReady")
				or (params.event == "BufEnter" and is_filetype_alpha)
			) and not vim.g.before_alpha
		then
			vim.g.before_alpha = {
				showtabline = vim.opt.showtabline:get(),
				laststatus = vim.opt.laststatus:get(),
			}
			vim.opt.showtabline, vim.opt.laststatus = 0, 0
		elseif vim.g.before_alpha and params.event == "BufEnter" and not is_empty_file then
			vim.opt.laststatus = vim.g.before_alpha.laststatus
			vim.opt.showtabline = vim.g.before_alpha.showtabline
			vim.g.before_alpha = nil
		end
	end,
})

-- persists colorscheme or fallback vim.g.SCHEME = "habamax"
vim.api.nvim_create_autocmd("VimEnter", {
	nested = true,
	callback = function()
		pcall(vim.cmd.colorscheme, vim.g.SCHEME)
	end,
})
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function(params)
		vim.g.SCHEME = params.match
	end,
})
