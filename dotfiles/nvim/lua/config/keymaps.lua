-- keymaps that just affect regular use, plugin keybinsd will be found on the plugin itself.
local map = vim.keymap.set
local del = vim.keymap.del

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- diagnostic keymaps?
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "open disagnostic [Q]uickfix list" })

-- move between windows with hjkl
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- resize window using arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- move a single line up and down.
map({ "n" }, "<M-up>", "<cmd>m-2<cr>", { desc = "Move line UP" })
map({ "n" }, "<M-down>", "<cmd>m+<cr>", { desc = "Move line DOWN" })
map({ "i" }, "<M-down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line DOWN" })
map({ "i" }, "<M-up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line UP" })

-- Move a selection up and down
map({ "v" }, "<M-down>", ":m '>+1<CR>gv=gv")
map({ "v" }, "<M-up>", ":m '<-2<CR>gv=gv")

-- clear search with <Esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- TLDR: Make n always forard and N always backward.
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- better indentation with g
map("v", "<", "<gv")
map("v", ">", ">gv")

-- J but cursor stays in current location.
map({ "n" }, "J", "mzJ`z", { desc = "Join lines without moving cursor" })

-- n / N but it keeps cursor in middle of screen.
map({ "n" }, "n", "nzzzv", { desc = "Next search result" })
map({ "n" }, "N", "Nzzzv", { desc = "Previous search result" })

-- replace work under cursor
map({ "n" }, "<leader>xr", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Replace current word" })
map(
	{ "v" },
	"<leader>xr",
	":s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
	{ desc = "replace current word in scope" }
)

-- convert camelCase to snake_case
map({ "v" }, "<leader>psc", ":s/[a-z]\\@<=[A-Z]/\\_\\l\\0/g<CR>", { desc = "This converts camelCase to snake_case" })
