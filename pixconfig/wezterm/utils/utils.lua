-- Utils for useful Lua functions to help wezterm config :>

-- Capture name for require.
-- local NAME = ...

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

function M.merge_lists(t1, t2)
	local merged = {}
	for _, v in pairs(t1) do
		table.insert(merged, v)
	end
	for _, v in pairs(t2) do
		table.insert(merged, v)
	end
	return merged
end

-- Give functions back to whoever requires.
return M
