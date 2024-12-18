return {
	-- project.nvim [project search + auto cd]
	-- https://github.com/ahmedkhalf/project.nvim
	{
		"zeioth/project.nvim",
		-- event = "User BaseDefered",
		event = "VeryLazy",
		cmd = "ProjectRoot",
		opts = {
			-- How to find root directory
			patterns = {
				".git",
				"_darcs",
				".hg",
				".bzr",
				".svn",
				"Makefile",
				"package.json",
				".solution",
				".solution.toml",
			},
			-- Don't list the next projects
			exclude_dirs = {
				"~/",
			},
			silent_chdir = true,
			manual_mode = false,

			-- Don't chdir for certain buffers
			exclude_chdir = {
				filetype = { "", "OverseerList", "alpha" },
				buftype = { "nofile", "terminal" },
			},

			--ignore_lsp = { "lua_ls" },
		},
		config = function(_, opts)
			require("project_nvim").setup(opts)
		end,
	},
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
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			lazygit = { enabled = true },
			statuscolumn = { enabled = true },
			notifier = { enabled = true, timeout = 3000 },
			indent = { enabled = true },
			input = { enabled = true },
			bufdelete = { enabled = true },
		},
	},
	{ "gbprod/substitute.nvim", opts = {} },
	{
		"echasnovski/mini.surround",
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
		"echasnovski/mini.splitjoin",
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
