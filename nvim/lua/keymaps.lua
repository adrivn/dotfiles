-- An example helper to create a Normal mode mapping
local nmap = function(lhs, rhs, desc)
	-- See `:h vim.keymap.set()`
	vim.keymap.set("n", lhs, rhs, { desc = desc })
end
local nmap_leader = function(suffix, rhs, desc)
	vim.keymap.set("n", "<Leader>" .. suffix, rhs, { desc = desc })
end
local xmap_leader = function(suffix, rhs, desc)
	vim.keymap.set("x", "<Leader>" .. suffix, rhs, { desc = desc })
end

local leader_group_clues = {
	{ mode = "n", keys = "<Leader>b", desc = "+Buffer" },
	{ mode = "n", keys = "<Leader>e", desc = "+Explore/Edit" },
	{ mode = "n", keys = "<Leader>f", desc = "+Find" },
	{ mode = "n", keys = "<Leader>g", desc = "+Git" },
	{ mode = "n", keys = "<Leader>l", desc = "+Language" },
	{ mode = "n", keys = "<Leader>m", desc = "+Map" },
	{ mode = "n", keys = "<Leader>o", desc = "+Other" },
	{ mode = "n", keys = "<Leader>s", desc = "+Session" },
	{ mode = "n", keys = "<Leader>t", desc = "+Terminal" },
	{ mode = "n", keys = "<Leader>v", desc = "+Visits" },

	{ mode = "x", keys = "<Leader>g", desc = "+Git" },
	{ mode = "x", keys = "<Leader>l", desc = "+Language" },
}

local ConfigClues = function()
	local miniclue = require("mini.clue")
              -- stylua: ignore
              miniclue.setup({
                -- Define which clues to show. By default shows only clues for custom mappings
                -- (uses `desc` field from the mapping; takes precedence over custom clue).
                clues = {
                  -- This is defined in 'plugin/20_keymaps.lua' with Leader group descriptions
                  leader_group_clues,
                  miniclue.gen_clues.builtin_completion(),
                  miniclue.gen_clues.g(),
                  miniclue.gen_clues.marks(),
                  miniclue.gen_clues.registers(),
                  -- This creates a submode for window resize mappings. Try the following:
                  -- - Press `<C-w>s` to make a window split.
                  -- - Press `<C-w>+` to increase height. Clue window still shows clues as if
                  --   `<C-w>` is pressed again. Keep pressing just `+` to increase height.
                  --   Try pressing `-` to decrease height.
                  -- - Stop submode either by `<Esc>` or by any key that is not in submode.
                  miniclue.gen_clues.windows({ submode_resize = true }),
                  miniclue.gen_clues.z(),
                },
                -- Explicitly opt-in for set of common keys to trigger clue window
                triggers = {
                  { mode = 'n', keys = '<Leader>' }, -- Leader triggers
                  { mode = 'x', keys = '<Leader>' },
                  { mode = 'n', keys = '\\' },       -- mini.basics
                  { mode = 'n', keys = '[' },        -- mini.bracketed
                  { mode = 'n', keys = ']' },
                  { mode = 'x', keys = '[' },
                  { mode = 'x', keys = ']' },
                  { mode = 'i', keys = '<C-x>' },    -- Built-in completion
                  { mode = 'n', keys = 'g' },        -- `g` key
                  { mode = 'x', keys = 'g' },
                  { mode = 'n', keys = "'" },        -- Marks
                  { mode = 'n', keys = '`' },
                  { mode = 'x', keys = "'" },
                  { mode = 'x', keys = '`' },
                  { mode = 'n', keys = '"' },        -- Registers
                  { mode = 'x', keys = '"' },
                  { mode = 'i', keys = '<C-r>' },
                  { mode = 'c', keys = '<C-r>' },
                  { mode = 'n', keys = '<C-w>' },    -- Window commands
                  { mode = 'n', keys = 'z' },        -- `z` key
                  { mode = 'x', keys = 'z' },
                },
                window = {
                        delay = 500,
                },
              })
end

ConfigClues()

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

local finder = require("snacks").picker
vim.keymap.set("n", "<leader>fh", finder.help, { desc = "[F]ind [H]elp", nowait = true })
vim.keymap.set("n", "<leader>fk", finder.keymaps, { desc = "[F]ind [K]eymaps", nowait = true })
vim.keymap.set("n", "<leader>ff", finder.files, { desc = "[F]ind [F]iles", nowait = true })
vim.keymap.set("n", "<leader>fs", finder.pickers, { desc = "[F]ind [S]elect Builtin fzf Engines", nowait = true })
vim.keymap.set("n", "<leader>fw", finder.grep, { desc = "[F]ind by [w]ord", nowait = true })
-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set("n", "<leader>fW", function()
	finder.grep_buffers()
end, { desc = "[W] Fuzzily search in current buffer", nowait = true })
vim.keymap.set("n", "<leader>fq", finder.qflist, { desc = "[F]ind [Q]uickfix", nowait = true })
vim.keymap.set("n", "<leader>fd", finder.diagnostics, { desc = "[F]ind [D]iagnostics", nowait = true })
vim.keymap.set("n", "<leader>fr", finder.resume, { desc = "[F]ind [R]esume", nowait = true })
vim.keymap.set("n", "<leader>fo", finder.recent, { desc = "[F]ind [O]ld Files", nowait = true })
vim.keymap.set("n", "<leader>fb", finder.buffers, { desc = "[F]ind existing [B]uffers", nowait = true })
vim.keymap.set("n", "<leader>th", function()
	finder.colorschemes({
		enable_preview = true,
		ignore_builtins = true,
	})
end, { desc = "[TH]eme picker", nowait = true })
vim.keymap.set("n", "<leader>fn", function()
	require("snacks").notifier.show_history()
end, { desc = "[F]ind in [N]otifications", nowait = true })
vim.keymap.set("n", "<leader>pf", finder.projects, { desc = "[P]roject [F]inder", silent = true, noremap = true })

-- Git and stuff
vim.keymap.set("n", "<leader>gg", function()
	require("snacks").lazygit()
end, { desc = "Open LazyGit instance", silent = true, noremap = true })
vim.keymap.set("n", "<leader>gt", function()
	MiniDiff.toggle_overlay()
end, { desc = "Git: [T]oggle Diff", silent = true, noremap = true })

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
vim.keymap.set("n", "<leader>tD", function()
	require("snacks").picker.todo_comments()
end, { desc = "TodoComments: fzf view" })

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
