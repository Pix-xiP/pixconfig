-- Keymaps are automatically loaded on the VeryLazy event
-- Add any additional keymaps here

local pix_buffer = require("pix.buffer_helpers")

-- Keymaps
local map = vim.keymap.set
local del = vim.keymap.del

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Better up and down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move a single line up and down.
map({ "n" }, "<M-up>", "<cmd>m-2<cr>", { desc = "Move line UP" })
map({ "n" }, "<M-down>", "<cmd>m+<cr>", { desc = "Move line DOWN" })
map({ "i" }, "<M-down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line DOWN" })
map({ "i" }, "<M-up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line UP" })

-- Move a selection up and down
map({ "v" }, "<M-down>", ":m '>+1<CR>gv=gv")
map({ "v" }, "<M-up>", ":m '<-2<CR>gv=gv")

-- Clear search with <ESC>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- TLDR: Make n always forard and N always backward.
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Better indentation with g
map("v", "<", "<gv")
map("v", ">", ">gv")

-- -- Run Pix Autoformatter on current buffer
-- map({ "n" }, "<leader>pf", ":!pix-af -i -f %<enter>", { desc = "Format currently open Swift buffer" })

-- J but cursor stays in current location.
map({ "n" }, "J", "mzJ`z", { desc = "Join lines without moving cursor" })

-- n / N but it keeps cursor in middle of screen.
map({ "n" }, "n", "nzzzv", { desc = "Next search result" })
map({ "n" }, "N", "Nzzzv", { desc = "Previous search result" })

-- Paste without losing current copy - copy arst, paste over tsra without losing arst.
map({ "x" }, "<leader>pp", '"_dP', { desc = "Paste without overwriting register when highlighted." })

map({ "n" }, "<leader>xr", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Replace current word" })
map(
  { "v" },
  "<leader>xr",
  ":s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
  { desc = "replace current word in scope" }
)

map({ "n" }, "<leader>mx", "<cmd>!chmod +x %<CR>", { desc = "Make file executable" })

map({ "n" }, "<leader>mw", ":w !sudo tee %<CR>", { desc = "Reopen a file with changes using sudo permissions" })

-- map({ "i" }, "<M-m>", "<esc>a", { desc = "Remove auto suggestions and continue typing" })

-- Search current buffer looks different.
-- map({ "n", "v" }, "<leader>sb", function()
--   require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
--     previewer = false,
--   }))
-- end, { desc = "Search current buffer" })

-- Nuke CTRL S for saving...
del({ "i", "x", "n", "s" }, "<C-s>")

map(
  { "n" },
  "<leader>pn",
  "iif err != nil {<CR> return err<CR>}<Esc>kk",
  { desc = "Automatically place a if err = nil check in for Go" }
)

map({ "v" }, "<leader>psc", ":s/[a-z]\\@<=[A-Z]/\\_\\l\\0/g<CR>", { desc = "This converts camelCase to snake_case" })

map({ "n", "v" }, "<leader>pcc", "<cmd>:Compile 13<CR>", { desc = "Runs compile command for compilation mode" })
map({ "n", "v" }, "<leader>pcr", "<cmd>:Recompile 13<CR>", { desc = "Runs compile command for compilation mode" })

map(
  { "n", "v" },
  "<leader>pmc",
  pix_buffer.switch_case,
  { desc = "Changes current line from camelCase to snake_case or back again" }
)
