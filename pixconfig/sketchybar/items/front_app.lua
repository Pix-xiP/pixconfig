local sbar = require("sketchybar")
local colours = require("colours")

local M = {}

M.front_app = sbar.add("item", {
	position = "left",
	icon = {
		drawing = false,
	},
	label = {
		font = {
			style = "Black",
			size = 12.0,
		},
	},
})

M.bracket = { M.front_app.name }

M.front_app:subscribe("front_app_switched", function(env)
	M.front_app:set({
		label = {
			string = env.INFO,
			color = colours.rose_pallete.foam,
		},
	})
end)

return M
