-- Function to check if a file exists at the given path and is readable.

if true then
  return {}
end

local function fileExists(filename)
  local file = io.open(filename, "r")
  if file then
    file:close()
    return true
  end
  return false
end

-- Function to check and source nvim.lua file or alternatively init.lua file
local function sourceLocalConfig()
  local cwd = vim.fn.getcwd() -- Get the current working directory

  -- Define the filenames that it could be
  local filename = "nvim.lua"
  local altFilename = "nvim.style"

  -- Check if either of the files exists in the CWD
  local nvimLuaExists = fileExists(cwd .. "/" .. filename)
  local initLuaExists = fileExists(cwd .. "/" .. altFilename)

  -- If any of the files exist, source the first file that exists.
  if nvimLuaExists == true then
    dofile(vim.fn.expand(filename))
    vim.notify("Sourced local config file: " .. filename, vim.log.levels.INFO, {})
  elseif initLuaExists == true then
    dofile(vim.fn.expand(altFilename))
    vim.notify("Sourced local config file: " .. altFilename, vim.log.levels.INFO, {})
  end
end

return {
  sourceLocalConfig(),
}
