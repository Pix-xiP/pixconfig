local sbar = require("sketchybar")
local icons = require("icons")
local colours = require("colours")

local M = {}

M.popup_toggle = "sketchybar --set $NAME popup.drawing=toggle"

M.apple = sbar.add("item", "apple", {
	padding_right = 15,
	click_script = M.popup_toggle,
	icon = {
		string = icons.apple,
		font = {
			style = "Black",
			size = 16.0,
		},
		color = colours.rosepine.main.pine,
	},
	label = {
		drawing = false,
	},
	popup = {
		height = 35,
	},
})

M.bracket = { M.apple.name }

M.apple_prefs = sbar.add("item", {
	position = "popup." .. M.apple.name,
	icon = icons.preferences,
	label = "Preferences",
})

M.apple_activity = sbar.add("item", {
	position = "popup." .. M.apple.name,
	icon = icons.activity,
	label = "Activity",
})

M.lock = sbar.add("item", {
	position = "popup." .. M.apple.name,
	icon = icons.lock,
	label = "Lock",
})

M.apple_finder = sbar.add("item", {
	position = "popup." .. M.apple.name,
	icon = icons.activity,
	label = "Finder",
})

M.arc = sbar.add("item", {
	position = "popup." .. M.apple.name,
	icon = icons.activity,
	label = "Arc",
})

M.apple_prefs:subscribe("mouse.clicked", function(_)
	sbar.exec("open -a 'System Preferences'")
	M.apple:set({ popup = { drawing = false } })
end)

M.apple_activity:subscribe("mouse.clicked", function(_)
	sbar.exec("open -a 'Activity Monitor'")
	M.apple:set({ popup = { drawing = false } })
end)

M.lock:subscribe("mouse.clicked", function(_)
	sbar.exec("pmset displaysleepnow")
	M.apple:set({ popup = { drawing = false } })
end)

M.apple_finder:subscribe("mouse.clicked", function(_)
	sbar.exec("open -a 'Finder'")
	M.apple:set({ popup = { drawing = false } })
end)

M.arc:subscribe("mouse.clicked", function(_)
	sbar.exec("open -a 'Arc'")
	M.apple:set({ popup = { drawing = false } })
end)

sbar.add("bracket", { M.apple.name }, {
	background = {
		color = colours.basics.transparent,
		height = 27,
		border_color = colours.rosepine.main.highlight_low,
	},
})

print("Apple Prefs running")

return M
