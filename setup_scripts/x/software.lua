local M = {}

---@param opts string the desktop environment package list to be retrieved
function M.get_software(opts)
	print("I was given", opts)
	local pkgs = {}
	if opts == "hyprland" then
		print("getting hyprland packages")
		local pkg_list = require("packages.hyprland")
		print("pkgs", pkg_list)
		for k, v in pairs(pkg_list) do
			if type(v) == "table" then
				for a, b in pairs(v) do
					print(a, b)
				end
			end
			print(k, v)
		end
		pkgs = pkg_list
	elseif opts == "base" then
		print("getting base packages")
		local pkg_list = require("packages.base")
		pkgs = pkg_list
	elseif opts == "niri" then
		print("getting niri packages")
		local pkg_list = require("packages.niri")
		pkgs = pkg_list
	end
	return pkgs
end

return M
