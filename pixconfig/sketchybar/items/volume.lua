local colours = require("colours")
local icons = require("icons")
local sbar = require("sketchybar")

local M = {}
-- PIXTODO: Use sbar.add("bracket") t create another bracket on the right hand side.

print("Volume running")

print("Unloading the macOS screen indicator")
os.execute("launchctl unload -F /System/Library/LaunchAgents/com.apple.OSDUIHelper.plist >/dev/null 2>&1")

M.volume_slider = sbar.add("slider", {
	position = "right",
	updates = true,
	icon = { drawing = false },
	label = { drawing = false },
	slider = {
		highlight_color = colours.rose_pallete.pine,
		width = 0,
		background = {
			height = 6,
			corner_radius = 3,
			color = colours.rose_pallete.overlay,
		},
		knob = {
			string = "􀀁",
			drawing = false,
		},
	},
})

M.volume_icon = sbar.add("item", {
	position = "right",
	icon = {
		string = icons.volume._100,
		width = 0,
		align = "left",
		color = colours.rose_pallete.muted,
		font = {
			style = "Regular",
			size = 14.0,
		},
	},
	label = {
		width = 25,
		align = "left",
		font = {
			style = "Regular",
			size = 14.0,
		},
	},
})

-- Important to extract the name from the sbar.add command.
M.bracket = { M.volume_icon.name, M.volume_slider.name }

M.volume_slider:subscribe("mouse.clicked", function(env)
	os.execute("osascript -e 'set volume output volume " .. env["PERCENTAGE"] .. "'")
end)

M.volume_slider:subscribe("volume_change", function(env)
	local volume = tonumber(env.INFO)
	local icon = icons.volume._0
	if volume > 60 then
		icon = icons.volume._100
	elseif volume > 30 then
		icon = icons.volume._66
	elseif volume > 10 then
		icon = icons.volume._33
	elseif volume > 0 then
		icon = icons.volume._10
	end

	M.volume_icon:set({ label = icon })
	M.volume_slider:set({ slider = { percentage = volume } })
end)

function M.animate_slider_width(width)
	sbar.animate("tanh", 30.0, function()
		M.volume_slider:set({ slider = { width = width } })
	end)
end

M.volume_icon:subscribe("mouse.clicked", function()
	if tonumber(M.volume_slider:query().slider.width) > 0 then
		M.animate_slider_width(0)
	else
		M.animate_slider_width(100)
	end
end)

return M
