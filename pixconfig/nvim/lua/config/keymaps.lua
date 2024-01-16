-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

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
