return {
	{ -- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
		main = "ibl",
		opts = {},
	},
	-- highlight undo
	{
		"tzachar/highlight-undo.nvim",
		opts = {},
	},
	-- better escape from insert mode using j & k
	{
		"max397574/better-escape.nvim",
		opts = {},
	},
	-- barbar, lets try instead of bufferline
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			-- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
			animation = true,
			insert_at_start = true,
			sidebar_filetypes = {
				-- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
				NvimTree = true, -- …etc.
			},
		},
		version = "^1.0.0", -- optional: only update when a new 1.x version is released
	},
	-- -- bufferline, what else
	-- {
	-- 	"akinsho/bufferline.nvim",
	-- 	version = "*",
	-- 	dependencies = "nvim-tree/nvim-web-devicons",
	-- 	opts = {
	-- 		offsets = {
	-- 			{
	-- 				filetype = "NvimTree",
	-- 				text = function()
	-- 					return vim.fn.getcwd()
	-- 				end,
	-- 				highlight = "Directory",
	-- 				text_align = "left",
	-- 			},
	-- 		},
	-- 	},
	-- },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "dracula",
				-- dracula, codedark, ayu_dark, horizon, onedark, nightfly
				globalstatus = true,
			},
		},
	},
}
