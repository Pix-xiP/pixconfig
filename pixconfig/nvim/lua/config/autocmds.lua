-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("AddOdinCommentString", { clear = true }),
  callback = function(ev)
    vim.bo.commentstring = "// %s"
  end,
  pattern = { "odin" },
})
