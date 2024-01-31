local U = require("utils.utils")

local M = {}

-- Setting the wallpaper
M.image = ""
if U.os == "Linux" then
	M.image = "/home/pix/.config/wallpapers/terminal_background.jpg"
elseif U.os == "Darwin" then
	M.image = "/Users/pix/.config/wallpapers/terminal_background.jpg"
end

-- M.image = ""
-- if U.os == "Linux" then
-- 	M.image = U.linux_config .. "/wallpapers/terminal_background.jpg"
-- elseif U.os == "Darwin" then
-- 	M.image = U.darwin_config .. "/wallpapers/terminal_background.jpg"
-- end

-- Setting wallpaper settings, brightness, hue, saturation etc.
M.window_hsb = {
	brightness = 0.05, -- Darken background by x..
	hue = 1.0, -- Default, 1.0 leaves it unchanged.
	saturation = 1.0,
}

return M
