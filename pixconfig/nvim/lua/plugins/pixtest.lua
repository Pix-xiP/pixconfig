local p = require("pix.window_spawn")

local M = {}

-- function M:spawn_floating_window()
--   local w = 50
--   local h = 10
--
--   local buf = vim.api.nvim_create_buf(false, true)
--   vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Hello, World!" })
--
--   local win = vim.api.nvim_get_current_win()
--   local config = vim.api.nvim_win_get_config(win)
--
--   local opts = {
--     relative = "editor",
--     row = math.floor((vim.o.lines - h) / 2),
--     col = math.floor((vim.o.columns - w) / 2),
--     width = w,
--     height = h,
--     style = "minimal",
--   }
--
--   local fwin = vim.api.nvim_open_win(buf, true, opts)
-- end

print("Hello")

return {
  {
    dir = "~/.config/nvim/lua/pix",
    keys = {
      {
        "<leader>fp",
        function()
          p:toggle_window()
        end,
      },
    },
  },
}
