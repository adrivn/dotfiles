return {
	{
		"cappyzawa/trim.nvim",
		event = "BufWrite",
		opts = {
			trim_on_write = true,
			trim_trailing = true,
			trim_last_line = false,
			trim_first_line = false,
			-- ft_blocklist = { "markdown", "text", "org", "tex", "asciidoc", "rst" },
			-- patterns = {[[%s/\(\n\n\)\n\+/\1/]]}, -- Only one consecutive bl
		},
	},
	{
		"sindrets/diffview.nvim",
		opts = {
			keymaps = {
				view = {
					{ "n", "q", ":DiffviewClose<CR>", { desc = "Close diff view" } },
				},
			},
		},
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			dashboard = {
				enabled = true,
				preset = {
					keys = {
						{ key = "e", icon = " ", desc = "new file", action = ":ene" },
						{
							key = "f",
							icon = "󰈞 ",
							desc = "find file",
							action = function()
								require("snacks").picker.files({ cwd = vim.fn.getcwd() })
							end,
						},
						{
							key = "o",
							icon = "󰔟 ",
							desc = "recent files",
							action = function()
								require("snacks").picker.recent()
							end,
						},
						{
							key = "p",
							icon = " ",
							desc = "recent projects",
							action = function()
								require("snacks").picker.projects({
									patterns = {},
								})
							end,
						},
						{ key = "l", icon = " ", desc = "lazy (sync)", action = ":Lazy sync" },
						{ key = "m", icon = " ", desc = "mason", action = ":Mason" },
						{
							key = "t",
							icon = " ",
							desc = "themes",
							action = function()
								require("snacks").picker.colorschemes({ enable_preview = true, ignore_builtins = true })
							end,
						},
						{ key = "q", icon = " ", desc = "quit nvim", action = ":qa" },
					},
					-- Used by the `header` section
					header = {
						[[
                                ▀████▀▄▄              ▄█
						            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█
						    ▄        █          ▀▀▀▀▄  ▄▀
						   ▄▀ ▀▄      ▀▄              ▀▄▀
						  ▄▀    █     █▀   ▄█▀▄      ▄█
						  ▀▄     ▀▄  █     ▀██▀     ██▄█
						   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █
						    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀
						   █   █  █      ▄▄           ▄▀
                       ]],
					},
				},
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1, padding = 1 },
					{ section = "startup" },
				},
			},
			picker = { enabled = true },
			lazygit = { enabled = true },
			statuscolumn = { enabled = true },
			terminal = { enabled = true },
			notifier = { enabled = true, timeout = 3000 },
			indent = { enabled = true },
			input = { enabled = true },
			bufdelete = { enabled = true },
		},
	},
	{ "gbprod/substitute.nvim", opts = {} },
	{
		"nvim-mini/mini.surround",
		version = false,
		opts = {
			mappings = {
				add = "ys",
				delete = "ds",
				find = "",
				find_left = "",
				highlight = "",
				replace = "cs",
				update_n_lines = "",
			},
		},
	},
	{
		"nvim-mini/mini.splitjoin",
		version = false,
		opts = {
			mappings = {
				split = "gs",
				join = "gj",
			},
		},
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			open_mapping = "<C-\\>",
			start_in_insert = true,
		},
	},
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		opts = {
			bind = true,
			handler_opts = {
				border = "rounded",
			},
		},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},
}
