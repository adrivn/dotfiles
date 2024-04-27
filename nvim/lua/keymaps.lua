-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

vim.keymap.set("n", ";", ":", { desc = "Remap semicolon, for the butter fingers" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Toggle line number and relative line number
vim.keymap.set("n", "<leader>tn", "<cmd>echo 'Not yet!'<CR>", { desc = "[T]oggle line [N]umber" })
vim.keymap.set("n", "<leader>tr", "<cmd>echo 'Not yet!'<CR>", { desc = "[T]oggle [R]elative line number" })

-- Buffer navigation
vim.keymap.set("n", "<Tab>", "<cmd>bprev<CR>", { desc = "Next buffer", silent = true })
vim.keymap.set("n", "<S-Tab>", "<cmd>bnext<CR>", { desc = "Previous buffer", silent = true })
vim.keymap.set("n", "<A-w>", "<cmd>bd<CR><cmd>bprev<CR>", { desc = "Close buffer", silent = true })

-- NvimTree
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- See `:help telescope.builtin`
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fs", builtin.builtin, { desc = "[F]ind [S]elect Telescope" })
vim.keymap.set("n", "<leader>fw", builtin.live_grep, { desc = "[F]ind by [W]ord" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]ind [R]esume" })
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = '[F]ind Recent/[O]ld Files ("." for repeat)' })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind existing [B]uffers" })
vim.keymap.set("n", "<leader>th", builtin.colorscheme, { desc = "[TH]eme picker" })

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to Telescope to change the theme, layout, etc.
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set("n", "<leader>f/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, { desc = "[F]ind [/] in Open Files" })

-- Shortcut for searching your Neovim configuration files
-- HACK: This does not work with symlinks so better to comment it out for now
--
-- vim.keymap.set("n", "<leader>fn", function()
-- 	builtin.find_files({ cwd = vim.fn.stdpath("config") })
-- end, { desc = "[S]earch [N]eovim files" })

-- Projects browser
-- vim.keymap.set("n", "<leader>pf", ":Telescope projects<CR>", { desc = "[P]roject [F]inder", silent = true })
vim.keymap.set("n", "<leader>pf", function()
	require("telescope").extensions.projects.projects()
end, { desc = "[P]roject [F]inder" })

-- LazyGit
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit instance" })

-- -- Trouble
vim.keymap.set("n", "<leader>tx", "<cmd>TroubleToggle<CR>", { desc = "Open Trouble Menu" })
vim.keymap.set(
	"n",
	"<leader>tw",
	"<cmd>TroubleToggle workspace_diagnostics<CR>",
	{ desc = "Open Workspace Diagnostics" }
)
vim.keymap.set(
	"n",
	"<leader>td",
	"<cmd>TroubleToggle document_diagnostics<CR>",
	{ desc = "<cmd>TroubleToggle document_diagnostics<CR>" }
)
vim.keymap.set("n", "<leader>tl", "<cmd>TroubleToggle loclist<CR>", { desc = "<cmd>TroubleToggle loclist<CR>" })
vim.keymap.set("n", "<leader>tq", "<cmd>TroubleToggle quickfix<CR>", { desc = "Open Quick Fix Menu" })
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<CR>", { desc = "<cmd>TroubleToggle lsp_references<CR>" })
vim.keymap.set("n", "<leader>tt", "<cmd>TodoTelescope<CR>", { desc = "Open TODO Telescope" })
--
-- Substitute
vim.keymap.set("n", "s", function()
	require("substitute").operator()
end, { desc = "Substitute" })
vim.keymap.set("n", "ss", function()
	require("substitute").line()
end, { desc = "Substitute entire line" })
vim.keymap.set("n", "S", function()
	require("substitute").eol()
end, { desc = "Substitute from current position to the end of line" })
vim.keymap.set("x", "S", function()
	require("substitute").visual()
end, { desc = "Substitute (visual mode)" })

-- Project
vim.keymap.set("n", "<leader>pf", "<cmd>Telescope projects<CR>", { desc = "Open projects list" })

-- Inlay hints
vim.keymap.set("n", "<leader>ih", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { nil, vim.api.nvim_get_current_buf() })
end, { desc = "Toggle inlay hints" })
