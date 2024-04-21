local sbar = require("sketchybar")

local M = {}

M.cal = sbar.add("item", {
	icon = {
		padding_right = 0,
		font = {
			style = "Black",
			size = 12.0,
		},
	},
	label = {
		width = 45,
		align = "right",
	},
	position = "right",
	update_freq = 15,
})

M.bracket = { M.cal.name }

function M.update()
	local date = os.date("%a. %d %b.")
	local time = os.date("%H:%M")
	M.cal:set({ icon = date, label = time })
end

M.cal:subscribe("routine", M.update)
M.cal:subscribe("forced", M.update)

print("calender running")

M.update()

return M
