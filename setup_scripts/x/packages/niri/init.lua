local base = require("packages.base")
local pkgs = {
	"niri",
}

-- Append base to packages
for k, v in pairs(base) do
	pkgs[k] = v
end

return pkgs
