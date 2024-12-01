-- [[ Basic Keymaps ]]
vim.keymap.set("n", ";", ":", { desc = "Remap semicolon, for the butter fingers" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<C-q>", "<cmd>q<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "x", '"_x', { desc = "", noremap = true, silent = true })
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>x", function()
	require("snacks").bufdelete.delete()
end, { desc = "Close buffer", noremap = true, silent = true })
vim.keymap.set("n", "<leader>ov", "<cmd>vs<CR>", { desc = "New vertical split", noremap = true })
vim.keymap.set("n", "<leader>oh", "<cmd>sp<CR>", { desc = "New horizontal split", noremap = true })
vim.keymap.set("n", "<leader>b", "<cmd>enew<CR>", { desc = "New buffer", noremap = true, silent = true })
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Up>", ":resize -2<CR>", { desc = "", noremap = true, silent = true })
vim.keymap.set("n", "<A-Down>", ":resize +2<CR>", { desc = "", noremap = true, silent = true })
vim.keymap.set("n", "<A-Left>", ":vertical resize -2<CR>", { desc = "", noremap = true, silent = true })
vim.keymap.set("n", "<A-Right>", ":vertical resize +2<CR>", { desc = "", noremap = true, silent = true })

-- Join line while keeping the cursor in the same position
vim.keymap.set("n", "J", "mzJ`z")
-- Keep cursor centred while scrolling up and down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- Next and previous instance of the highlighted letter
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

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

-- hop.nvim
local hop = require("hop")
local directions = require("hop.hint").HintDirection
vim.keymap.set("", "f", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, { remap = true })
vim.keymap.set("", "F", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end, { remap = true })
vim.keymap.set("", "t", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })
end, { remap = true })
vim.keymap.set("", "T", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })
end, { remap = true })

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
-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set("n", "<leader>fW", function()
	-- You can pass additional configuration to Telescope to change the theme, layout, etc.
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]ind [R]esume" })
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = '[F]ind Recent/[O]ld Files ("." for repeat)' })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind existing [B]uffers" })
vim.keymap.set("n", "<leader>th", function()
	builtin.colorscheme({
		enable_preview = true,
		ignore_builtins = true,
	})
end, { desc = "[TH]eme picker" })
vim.keymap.set("n", "<leader>fn", function()
	require("snacks").notifier.show_history()
end, { desc = "[F]ind in [N]otifications" })

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set("n", "<leader>f/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, { desc = "[F]ind [/] in Open Files" })

-- Projects browser
vim.keymap.set(
	"n",
	"<leader>pf",
	":Telescope projects<CR>",
	{ desc = "[P]roject [F]inder", silent = true, noremap = true }
)

-- Git and stuff
vim.keymap.set("n", "<leader>gg", function()
	require("snacks").lazygit()
end, { desc = "Open LazyGit instance", silent = true, noremap = true })
vim.keymap.set("n", "<leader>gb", function()
	require("gitsigns").blame_line()
end, { desc = "Gitsigns: Blame line", silent = true, noremap = true })
vim.keymap.set("n", "<leader>gB", function()
	require("gitsigns").blame()
end, { desc = "Gitsigns: Blame entire file", silent = true, noremap = true })
vim.keymap.set("n", "<leader>gp", function()
	require("gitsigns").preview_hunk()
end, { desc = "Gitsigns: Preview Hunk", silent = true, noremap = true })
vim.keymap.set("n", "ghp", function()
	require("gitsigns").prev_hunk()
end, { desc = "Gitsigns: Go to previous hunk", silent = true, noremap = true })
vim.keymap.set("n", "ghn", function()
	require("gitsigns").next_hunk()
end, { desc = "Gitsigns: Go to next hunk", silent = true, noremap = true })
vim.keymap.set("n", "<leader>tb", function()
	require("gitsigns").toggle_current_line_blame()
end, { desc = "Gitsigns: Toggle Line Blame", silent = true, noremap = true })
vim.keymap.set("n", "<leader>gd", function()
	require("gitsigns").diffthis()
end, { desc = "Gitsigns: Diff entire file", silent = true, noremap = true })
vim.keymap.set("n", "<leader>td", function()
	require("gitsigns").toggle_deleted()
end, { desc = "Gitsigns: [T]oggle [D]eleted", silent = true, noremap = true })

-- TreeSJ
vim.keymap.set(
	"n",
	"<leader>ps",
	require("treesj").split,
	{ desc = "[P]aragraph [S]plit", silent = true, noremap = true }
)
vim.keymap.set(
	"n",
	"<leader>pj",
	require("treesj").join,
	{ desc = "[P]aragraph [J]oin", silent = true, noremap = true }
)
-- surround entire line
vim.keymap.set("n", "yss", "ys_", { remap = true })
vim.keymap.set("n", "\\", function()
	require("mini.files").open()
end, { silent = true })

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
-- ToggleTerm
vim.keymap.set({ "n", "t", "i" }, "<A-h>", "<cmd>ToggleTerm<CR>", { silent = true, noremap = true })

-- Trouble and Todo Comments
vim.keymap.set("n", "<leader>tT", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set(
	"n",
	"<leader>tt",
	"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
	{ desc = "Buffer Diagnostics (Trouble)" }
)
vim.keymap.set("n", "<leader>ts", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
vim.keymap.set(
	"n",
	"<leader>tl",
	"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	{ desc = "LSP Definitions / references / ... (Trouble)" }
)
vim.keymap.set("n", "<leader>tL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>tq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
vim.keymap.set("n", "<leader>tD", "<cmd>TodoTelescope<cr>", { desc = "TodoComments: Telescope view" })

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
