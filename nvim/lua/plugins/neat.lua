return {
	-- project.nvim [project search + auto cd]
	-- https://github.com/ahmedkhalf/project.nvim
	{
		"zeioth/project.nvim",
		event = "User BaseDefered",
		cmd = "ProjectRoot",
		init = function()
			require("telescope").load_extension("projects")
		end,
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
	{ "kdheepak/lazygit.nvim", event = "VeryLazy" },
	{ "gbprod/substitute.nvim", opts = {} },
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		opts = {},
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
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
		opts = { use_default_keymaps = false },
	},
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
	},
}
