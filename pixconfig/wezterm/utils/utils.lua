-- Utils for useful Lua functions to help wezterm config :>

-- Capture name for require.
local NAME = ...

-- Module to return
local M = {}

-- What OS are we running on!
local function get_os()
	local f = assert(io.popen("uname", "r"))
	local s = assert(f:read("*a"))
	f:close()
	s = string.gsub(s, "^%s+", "")
	s = string.gsub(s, "%s+$", "")
	s = string.gsub(s, "[\n\r]+", " ")
	return s
end

M.os = get_os()

-- Give functions back to whoever requires.
return M
