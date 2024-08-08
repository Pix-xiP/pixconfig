local colours = require("colours")
local sbar = require("sketchybar")

local M = {}

M.cal = sbar.add("item", {
	icon = {
		-- padding_right = 0,
		padding_left = 8,
		font = {
			style = "Black",
			size = 12.0,
		},
	},
	label = {
		width = 60,
		padding_right = 8,
		align = "right",
	},
	position = "right",
	update_freq = 30,
})

M.bracket = { M.cal.name }

-- Double border for calendar using a single item bracket
sbar.add("bracket", { M.cal.name }, {
	background = {
		-- color = colours.transparent,
		border_color = colours.basics.grey,
	},
})

M.cal:subscribe({ "routine", "forced", "system_woke" }, function()
	M.cal:set({ icon = os.date("􀉉 %a %d %b"), label = os.date(" 􀐫 %H:%M") })
end)

print("calender running")

-- M.update()

return M
