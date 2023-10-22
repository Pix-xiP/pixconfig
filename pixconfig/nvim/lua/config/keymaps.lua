-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local map = vim.keymap.set
map({ "n" }, "<M-up>", "<cmd>m-2<cr>", { desc = "Move line UP" })
map({ "n" }, "<M-down>", "<cmd>m+<cr>", { desc = "Move line DOWN" })
map({ "i" }, "<M-up>", "<esc><cmd>m-2<cr>a", { desc = "Move line UP" })
map({ "i" }, "<M-down>", "<esc><cmd>m+<cr>a", { desc = "Move line DOWN" })

-- map({ "i" }, "<M-m>", "<esc>a", { desc = "Remove auto suggestions and continue typing" })
