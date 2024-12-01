return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	-- Autoformat
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>fm",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]or[m]at buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				local lsp_format_opt
				if disable_filetypes[vim.bo[bufnr].filetype] then
					lsp_format_opt = "never"
				else
					lsp_format_opt = "fallback"
				end
				return {
					timeout_ms = 2000,
					lsp_format = lsp_format_opt,
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				python = function(bufnr)
					if require("conform").get_formatter_info("ruff_format", bufnr).available then
						return { "ruff_format" }
					else
						return { "isort", "black" }
					end
				end,
				-- Conform will run multiple formatters sequentially
				go = { "goimports", "goimports-reviser", "gofumpt" },
				--
				-- You can use 'stop_after_first' to run the first available formatter from the list
				-- javascript = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},
	{
		"Saghen/blink.cmp",
		-- enabled = false,
		-- How would I do a completion plugin?
		--
		-- - Fully async - users should never need to wait for the menu to open
		--   - Task-driven or callback-driven; don't mix the two
		-- - Sources push completions to an "epoch" (group of items from the same request context)
		-- - Things are added to the menu as they come, but discarded if they're from a previous epoch
		-- - Increment the epoch with every outgoing request + cancel inflight requests for prev. epoch
		-- - Maybe server-side fuzzy matching?
		-- - Menu components = fun(item: CompletionItem, ctx: Context): VirtTextChunk[]
		-- "willothy/blink.cmp",
		-- enabled = false,
		-- branch = "willothy/scrollbar",
		-- dir = "~/projects/lua/blink.cmp/",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		lazy = true,
		event = "InsertEnter",
		version = "v0.*",
		opts = {
			sources = {
				-- add lazydev to your completion providers
				completion = {
					enabled_providers = {
						"lsp",
						"lazydev",
						"path",
						"snippets",
						"buffer",
					},
				},
				providers = {
					-- dont show LuaLS require statements when lazydev has items
					lsp = {
						name = "lsp",
						fallback_for = { "lazydev" },
					},
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
					},
				},
			},
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},
			keymap = {
				-- preset = "super-tab",
				["<C-space>"] = {
					"show",
					"show_documentation",
					"hide_documentation",
				},
				["<C-e>"] = { "hide", "fallback" },

				["<Tab>"] = {
					function(cmp)
						if cmp.is_in_snippet() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					"snippet_forward",
					"fallback",
				},
				["<S-Tab>"] = { "snippet_backward", "fallback" },

				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-n>"] = { "select_next", "fallback" },

				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
			},
			highlight = {
				use_nvim_cmp_as_default = true,
			},
			nerd_font_variant = "normal",
			trigger = {
				signature_help = {
					enabled = true,
				},
			},
			kind_icons = {},
			windows = {
				autocomplete = {
					border = "rounded", -- single|rounded|none
					winblend = vim.o.pumblend,
					winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
					draw = {
						-- col_offset = -3,
						-- side_padding = 0,
						padding = 1,
						gap = 1,
						columns = {
							{ "kind_icon" },
							{ "label", "label_description", gap = 1 },
							{ "kind" },
						},
						components = {
							kind_icon = {
								ellipsis = false,
								text = function(ctx)
									return ctx.kind_icon .. " "
								end,
								highlight = function(ctx)
									return "BlinkCmpKind" .. ctx.kind
								end,
							},

							kind = {
								ellipsis = false,
								text = function(ctx)
									return ctx.kind .. " "
								end,
								highlight = function(ctx)
									return "BlinkCmpKind" .. ctx.kind
								end,
							},

							label = {
								width = { fill = true, max = 60 },
								text = function(ctx)
									return ctx.label .. (ctx.label_detail or "")
								end,
								highlight = function(ctx)
									-- label and label details
									local highlights = {
										{
											0,
											#ctx.label,
											group = ctx.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel",
										},
									}
									if ctx.label_detail then
										table.insert(highlights, {
											#ctx.label + 1,
											#ctx.label + #ctx.label_detail,
											group = "BlinkCmpLabelDetail",
										})
									end

									-- characters matched on the label by the fuzzy matcher
									if ctx.label_matched_indices ~= nil then
										for _, idx in ipairs(ctx.label_matched_indices) do
											table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
										end
									end

									return highlights
								end,
							},

							label_description = {
								width = { max = 30 },
								text = function(ctx)
									return ctx.label_description or ""
								end,
								highlight = "BlinkCmpLabelDescription",
							},
						},
					},
					-- draw = function(ctx)
					--   local hl = require("blink.cmp.utils").try_get_tailwind_hl(ctx)
					--     or ("BlinkCmpKind" .. ctx.kind)
					--
					--   return {
					--     " ",
					--     {
					--       ctx.kind_icon,
					--       hl_group = hl,
					--     },
					--     " ",
					--     {
					--       ctx.label,
					--       ctx.kind == "Snippet" and "~" or nil,
					--       (ctx.item.labelDetails and ctx.item.labelDetails.detail)
					--           and ctx.item.labelDetails.detail
					--         or "",
					--       hl_group = ctx.deprecated and "BlinkCmpLabelDeprecated"
					--         or "BlinkCmpLabel",
					--       max_width = 50,
					--       fill = true,
					--     },
					--     " ",
					--     {
					--       ctx.kind,
					--       hl_group = hl,
					--     },
					--     " ",
					--   }
					-- end,
				},
				documentation = {
					auto_show = false,
					min_width = 10,
					max_width = 60,
					max_height = 20,
					border = "padded",
					winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
				},
				signature_help = {
					min_width = 1,
					max_width = 100,
					max_height = 10,
					border = "padded",
					winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
				},
				ghost_text = {
					enabled = false,
				},
			},
		},
		-- allows extending the enabled_providers array elsewhere in your config
		-- without having to redefine it
		opts_extend = { "sources.completion.enabled_providers" },
	},
}
