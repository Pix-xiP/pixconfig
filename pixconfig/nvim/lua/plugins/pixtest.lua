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
function M.tprint(tbl, indent)
  if not indent then
    indent = 0
  end
  local toprint = string.rep(" ", indent) .. "{\r\n"
  indent = indent + 2
  for k, v in pairs(tbl) do
    toprint = toprint .. string.rep(" ", indent)
    if type(k) == "number" then
      toprint = toprint .. "[" .. k .. "] = "
    elseif type(k) == "string" then
      toprint = toprint .. k .. "= "
    end
    if type(v) == "number" then
      toprint = toprint .. v .. ",\r\n"
    elseif type(v) == "string" then
      toprint = toprint .. '"' .. v .. '",\r\n'
    elseif type(v) == "table" then
      toprint = toprint .. M.tprint(v, indent + 2) .. ",\r\n"
    else
      toprint = toprint .. '"' .. tostring(v) .. '",\r\n'
    end
  end
  toprint = toprint .. string.rep(" ", indent - 2) .. "}"
  return toprint
end

function M:spawn_floating_window(message)
  local w = 50
  local h = 10

  -- Create a new empty buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- Get the current window configuration
  local win = vim.api.nvim_get_current_win()
  print(win)
  local config = vim.api.nvim_win_get_config(win)
  M.tprint(config)

  -- Create the floating window
  local opts = {
    relative = "editor",
    width = w,
    height = h,
    col = math.floor((config.width - w) / 2),
    row = math.floor((config.height - h) / 2),
    anchor = "NW",
    style = "minimal",
  }
  -- local fwin
  local _ = vim.api.nvim_open_win(buf, true, opts)

  -- Insert the message into the buffer
  local lines = {}
  for _, line in ipairs(message) do
    table.insert(lines, line)
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

print("Hello")

return {
  {
    dir = "~/.config/nvim/lua/pix",
    keys = {
      {
        "<leader>fp",
        function()
          p:toggle_window({ "Hello from the toggle spawner." })

          -- local cols = vim.api.nvim_get_option("columns")
          -- local lines = vim.api.nvim_get_option("lines")
          --
          -- print(cols)
          -- print(lines)
          -- print("Attempting to spawn a window")
          -- print(lines)
          -- M:spawn_floating_window({ "Hello, World!" })
        end,
      },
    },
  },
}
