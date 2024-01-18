-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--

local api = vim.api

api.nvim_create_autocmd("FileType", {
  group = api.nvim_create_augroup("AddOdinCommentString", { clear = true }),
  callback = function(ev)
    vim.bo.commentstring = "// %s"
  end,
  pattern = { "odin", "swift" },
})

api.nvim_create_autocmd("FileType", {
  group = api.nvim_create_augroup("KillSwiftTSContext", { clear = true }),
  callback = function()
    local tsc = require("treesitter-context")
    if vim.bo.filetype == "swift" then
      tsc.disable()
    else
      tsc.enable()
    end
  end,
  pattern = { "swift" },
})
