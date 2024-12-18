return {

	-- incline: floating statusline at the top
	{
		"b0o/incline.nvim",
		opts = {
			window = {
				padding = 0,
				margin = { horizontal = 0 },
			},
			render = function(props)
				local devicons = require("nvim-web-devicons")
				local helpers = require("incline.helpers")
				local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
				if filename == "" then
					filename = "[No Name]"
				end
				local ft_icon, ft_color = devicons.get_icon_color(filename)
				local modified = vim.bo[props.buf].modified
				return {
					ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
					" ",
					{ filename, gui = modified and "bold,italic" or "bold" },
					" ",
					guibg = "#44406e",
				}
			end,
		},
		-- Optional: Lazy load Incline
		event = "VeryLazy",
	},
	-- scrollbar with good stuff
	{
		"petertriho/nvim-scrollbar",
		event = "BufReadPre",
		opts = {
			handlers = {
				gitsigns = true, -- gitsigns integration (display hunks)
				ale = true, -- lsp integration (display errors/warnings)
				search = false, -- hlslens integration (display search result)
			},
			excluded_filetypes = {
				"cmp_docs",
				"cmp_menu",
				"noice",
				"prompt",
				"dropbar_menu",
				"dropbar_menu_fzf",
				"fzf-lua",
				"TelescopePrompt",
				"alpha",
			},
		},
	},

	-- tree file browser
	{ "echasnovski/mini.files", version = false, opts = {} },
	-- highlight undo
	{
		"tzachar/highlight-undo.nvim",
		keys = { { "u" }, { "<C-r>" } },
		opts = {},
	},
	-- better escape from insert mode using j & k
	{
		"max397574/better-escape.nvim",
		opts = {},
	},

	-- autopairs
	{ "echasnovski/mini.pairs", version = false, opts = {} },
	-- text objects (awesome plugin)
	{ "echasnovski/mini.ai", version = false, opts = {} },
	-- icons
	{
		"echasnovski/mini.icons",
		version = false,
		opts = {},
		init = function()
			local mi = require("mini.icons")
			mi.mock_nvim_web_devicons()
			mi.tweak_lsp_kind()
		end,
	},
	-- bufferline
	{ "akinsho/bufferline.nvim", version = "*", opts = {} },

	-- lualine
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			-- add this plugin as dependency for lualine
			"bwpge/lualine-pretty-path",
		},
		config = function()
			local mode = {
				"mode",
				fmt = function(str)
					return " " .. str
					-- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
				end,
			}

			local filename = {
				"pretty_path",
				file_status = true, -- displays file status (readonly status, modified status)
				path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
			}

			local hide_in_width = function()
				return vim.fn.winwidth(0) > 100
			end

			local diagnostics = {
				"diagnostics",
				sources = { "nvim_diagnostic" },
				sections = { "error", "warn" },
				symbols = { error = " ", warn = " ", info = " ", hint = " " },
				colored = false,
				update_in_insert = false,
				always_visible = false,
				cond = hide_in_width,
			}

			local diff = {
				"diff",
				colored = false,
				symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
				cond = hide_in_width,
			}

			require("lualine").setup({
				options = {
					icons_enabled = true,
					-- theme = "nord", -- Set theme based on environment variable
					-- Some useful glyphs:
					-- https://www.nerdfonts.com/cheat-sheet
					--        
					section_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
					disabled_filetypes = { "alpha" },
					always_divide_middle = true,
					globalstatus = true,
				},
				sections = {
					lualine_a = { mode },
					lualine_b = { "branch" },
					lualine_c = { filename },
					lualine_x = {
						diagnostics,
						diff,
						{ "encoding", cond = hide_in_width },
						{ "filetype", cond = hide_in_width },
					},
					lualine_y = { "location" },
					lualine_z = { "progress" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { { "pretty_path", path = 1 } },
					lualine_x = { { "location", padding = 0 } },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				extensions = { "toggleterm", "neo-tree", "trouble", "mason", "lazy" },
			})
		end,
	},
	{
		"goolord/alpha-nvim",
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			-- Set header
			dashboard.section.header.val = {
				[[          ▀████▀▄▄              ▄█ ]],
				[[            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ]],
				[[    ▄        █          ▀▀▀▀▄  ▄▀  ]],
				[[   ▄▀ ▀▄      ▀▄              ▀▄▀  ]],
				[[  ▄▀    █     █▀   ▄█▀▄      ▄█    ]],
				[[  ▀▄     ▀▄  █     ▀██▀     ██▄█   ]],
				[[   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ]],
				[[    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ]],
				[[   █   █  █      ▄▄           ▄▀   ]],
			}

			-- Set menu
			dashboard.section.buttons.val = {
				dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("f", "󰈞  > Find file", function()
					require("fzf-lua").files({ cwd = vim.fn.getcwd() })
				end),
				dashboard.button("o", "󰔟  > Recent Files", ":FzfLua oldfiles<CR>"),
				dashboard.button("p", "  > Recent Projects", ":lua OpenRecentProjects()<CR>"),
				dashboard.button("l", "  > Lazy (sync)", ":Lazy sync<CR>"),
				dashboard.button("m", "  > Mason", ":Mason<CR>"),
				dashboard.button("t", "  > Themes (fzflua)", function()
					require("fzf-lua").colorschemes({ enable_preview = true, ignore_builtins = true })
				end),
				dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
			}

			local function footer()
				return "Don't Stop Until You are Proud..."
			end

			dashboard.section.footer.val = footer()

			dashboard.section.footer.opts.hl = "Type"
			dashboard.section.header.opts.hl = "Include"
			dashboard.section.buttons.opts.hl = "Keyword"

			dashboard.opts.opts.noautocmd = true

			-- Send config to alpha
			alpha.setup(dashboard.opts)
		end,
	},
}
