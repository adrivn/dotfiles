-- NEOVIM VSCODE CONFIG
require("options")

-- remap leader key
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Basic Keymaps ]]
vim.keymap.set("n", ";", ":", { desc = "Remap semicolon, for the butter fingers" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<C-q>", "<cmd>q<CR>", opts)
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", opts)
vim.keymap.set("n", "x", '"_x', opts)

-- better indent handling
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
-- better search results navigation
vim.keymap.set("n", "n", "nzz", opts)
vim.keymap.set("n", "N", "Nzz", opts)
-- Join line while keeping the cursor in the same position
vim.keymap.set("n", "J", "mzJ`z")
-- Keep cursor centred while scrolling up and down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- Next and previous instance of the highlighted letter
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- browse editors as buffers
vim.keymap.set(
	"n",
	"<Tab>",
	"<cmd>lua require('vscode').action('workbench.action.nextEditor')<CR>",
	{ noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"<S-Tab>",
	"<cmd>lua require('vscode').action('workbench.action.previousEditor')<CR>",
	{ noremap = true, silent = true }
)

-- general keymaps
vim.keymap.set(
	{ "n", "v" },
	"\\",
	"<cmd>lua require('vscode').action('workbench.action.toggleSidebarVisibility')<CR>",
	opts
)
vim.keymap.set({ "n", "v" }, "<leader>cn", "<cmd>lua require('vscode').action('notifications.clearAll')<CR>", opts)
vim.keymap.set({ "n", "v" }, "<leader>pf", "<cmd>lua require('vscode').action('workbench.action.openRecent')<CR>", opts)
vim.keymap.set({ "n", "v" }, "<leader>ff", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>", opts)
vim.keymap.set(
	{ "n", "v" },
	"<leader>fw",
	"<cmd>lua require('vscode').action('workbench.action.findInFiles')<CR>",
	opts
)
vim.keymap.set(
	{ "n", "v" },
	"<leader>lc",
	"<cmd>lua require('vscode').action('workbench.action.showCommands')<CR>",
	opts
)
vim.keymap.set(
	{ "n", "v" },
	"<leader>fm",
	"<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>",
	opts
)
vim.keymap.set(
	{ "n", "v" },
	"<leader>bm",
	"<cmd>lua require('vscode').action('dbtPowerUser.buildCurrentModel')<CR>",
	opts
)
vim.keymap.set({ "n", "v" }, "<leader>bp", "<cmd>lua require('vscode').action('dbtPowerUser.sqlPreview')<CR>", opts)
