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

M.ExistsGroup = vim.api.nvim_create_augroup("PixExistsGroup", {})

vim.api.nvim_create_autocmd("WinClosed", {
  command = "lua require('pix.window_spawn').unexists()",
  group = M.ExistsGroup,
})
-- vim.api.nvim_exec( [[ augroup PixExistsGroup autocmd!  autocmd WinClosed * lua M.toggle_window() augroup END ]], false)

-- This function is for explicitly setting the exists flag to
-- be false, in the case the window shuts with ':q' or 'esc'
function M:unexists()
  if M.exists then
    M.exists = false
  end
end

function M:run_command(command)
  local file = io.popen(command, "r")
  if file == nil then
    return false, ""
  end
  local res = file:read("*a")
  local ok, _, _ = file:close()
  return ok, res
end

function M:toggle_window()
  if not M.exists then
    local cmd = vim.fn.input("Enter command: ")
    local ok, result = M:run_command(cmd)
    if not ok then
      return nil
    end
    local msg = {}
    for line in result:gmatch("[^\n]+") do
      table.insert(msg, line)
    end
    M:spawn_floating_window(msg)
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
  -- local lines_num = vim.api.nvim_get_option("lines")

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
  --
  -- local ok, output = run_command("ls -lah")
  -- if ok then
  --   for line in output:gmatch("[^\n]+") do
  --     print(line)
  --     table.insert(lines, line)
  --   end
  -- end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

return M
