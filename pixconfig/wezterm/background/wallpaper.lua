local U = require("utils.utils")

local bg = ""
if U.os == "Linux" then
	bg = "/home/pix/.config/wallpapers/terminal_background.jpg"
elseif U.os == "Darwin" then
	bg = "/Users/pix/.config/wallpapers/terminal_background.jpg"
end

return bg
