local sbar = require("sketchybar")
local colours = require("colours")

local M = {}

M.front_app = sbar.add("item", {
	position = "left",
	display = "active",
	icon = {
		drawing = false,
	},
	label = {
		font = {
			style = "Black",
			size = 12.0,
		},
		color = colours.rose_pallete.foam,
	},
	updates = true,
})

M.bracket = { M.front_app.name }

M.front_app:subscribe("front_app_switched", function(env)
	M.front_app:set({ label = { string = env.INFO } })
end)

return M
