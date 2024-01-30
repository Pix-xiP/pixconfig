local sbar = require("sketchybar")
local icons = require("icons")
local colours = require("colours")

local M = {}

M.popup_toggle = "sketchybar --set $NAME popup.drawing=toggle"

M.apple_logo = sbar.add("item", "apple_logo", {
	padding_right = 15,
	click_script = M.popup_toggle,
	icon = {
		string = icons.apple,
		font = {
			style = "Black",
			size = 16.0,
		},
		color = colours.rose_pallete.pine,
	},
	label = {
		drawing = false,
	},
	popup = {
		height = 35,
	},
})

M.bracket = { M.apple_logo.name }

M.apple_prefs = sbar.add("item", {
	position = "popup." .. M.apple_logo.name,
	icon = icons.preferences,
	label = "Preferences",
})

M.apple_activity = sbar.add("item", {
	position = "popup." .. M.apple_logo.name,
	icon = icons.activity,
	label = "Activity",
})

M.lock = sbar.add("item", {
	position = "popup." .. M.apple_logo.name,
	icon = icons.lock,
	label = "Lock",
})

M.apple_finder = sbar.add("item", {
	position = "popup." .. M.apple_logo.name,
	icon = icons.activity,
	label = "Finder",
})

M.arc = sbar.add("item", {
	position = "popup." .. M.apple_logo.name,
	icon = icons.activity,
	label = "Arc",
})

M.apple_prefs:subscribe("mouse.clicked", function(_)
	os.execute("open -a 'System Preferences'")
	M.apple_logo:set({ popup = { drawing = false } })
end)

M.apple_activity:subscribe("mouse.clicked", function(_)
	os.execute("open -a 'Activity Monitor'")
	M.apple_logo:set({ popup = { drawing = false } })
end)

M.lock:subscribe("mouse.clicked", function(_)
	os.execute("pmset displaysleepnow")
	M.apple_logo:set({ popup = { drawing = false } })
end)

M.apple_finder:subscribe("mouse.clicked", function(_)
	os.execute("open -a 'Finder'")
	M.apple_logo:set({ popup = { drawing = false } })
end)

M.arc:subscribe("mouse.clicked", function(_)
	os.execute("open -a 'Arc'")
	M.apple_logo:set({ popup = { drawing = false } })
end)

print("Apple Prefs running")

return M
