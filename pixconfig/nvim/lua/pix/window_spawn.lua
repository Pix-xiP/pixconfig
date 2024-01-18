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
M.exists = false

function M:toggle_window(message)
  if not M.exists then
    M:spawn_floating_window(message)
    M.exists = true
  else
    vim.api.nvim_win_close(0, true)
    M.exists = false
  end
end

-- @param: Message == Table.
function M:spawn_floating_window(message)
  local w = 80
  local h = 20

  -- Create a new empty buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- Get the current window configuration
  -- local win = vim.api.nvim_get_current_win()
  -- local config = vim.api.nvim_win_get_config(win)

  local cols = vim.api.nvim_get_option("columns")
  local lines_num = vim.api.nvim_get_option("lines")

  -- Create the floating window
  local opts = {
    relative = "editor",
    width = w,
    height = h,
    col = (math.floor((cols - w) / 2) + 10),
    -- row = math.floor((lines_num - h) / 2),

    -- col = math.floor(500),
    row = math.floor(2),
    anchor = "NW",
    -- style = "minimal",
    border = "rounded",
    title = "Pix Spawner",
  }
  -- local fwin
  local _ = vim.api.nvim_open_win(buf, true, opts)

  -- Insert the message into the buffer
  local lines = {}
  for _, line in pairs(message) do
    table.insert(lines, line)
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, message)
end

return M
