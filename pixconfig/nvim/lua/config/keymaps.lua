-- Keymaps are automatically loaded on the VeryLazy event
-- Add any additional keymaps here

local map = vim.keymap.set

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
map({ "i" }, "<M-up>", "<esc><cmd>m-2<cr>a", { desc = "Move line UP" })
map({ "i" }, "<M-down>", "<esc><cmd>m+<cr>a", { desc = "Move line DOWN" })

-- Move a selection up and down
map({ "v" }, "<M-down>", ":m '>+1<CR>gv=gv")
map({ "v" }, "<M-up>", ":m '<-2<CR>gv=gv")

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

map({ "n" }, "<leader>mx", "<cmd>!chmod +x %<CR>", { desc = "Make file executable" })

-- map({ "i" }, "<M-m>", "<esc>a", { desc = "Remove auto suggestions and continue typing" })
