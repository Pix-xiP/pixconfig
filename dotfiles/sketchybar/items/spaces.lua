local M = {}

function M.mouse_click(env)
	if env.BUTTON == "right" then
		-- sbar.exec("yabai -m space --destroy " .. env.SID .. " && sketchybar --trigger space_change")
		print("Unable to destroy because not true YABAI")
	else
		-- sbar.exec("yabai -m space --focus " .. env.SID)
		print("Unable to focus because not running true YABAI")
	end
end

function M.space_selection(env)
	local colour = env.SELECTED == "true" and colours.rosepine.main.highlight_high
	sbar.set(env.NAME, {
		icon = { highlight = env.SELECTED },
		label = { highlight = env.SELECETD },
		background = { border_color = colour },
	})
end

M.spaces = {}
for i = 1, 10, 1 do
	local space = sbar.add("space", {
		associated_space = i,
		icon = {
			string = i,
			padding_left = 7,
			padding_right = 7,
			color = colours.rosepine.main.text,
			highlight_color = colours.rosepine.main.love,
		},
		padding_left = 1,
		padding_right = 1,
		label = {
			padding_right = 20,
			color = colours.rosepine.main.text,
			highlight_color = colours.rosepine.main.love,
			font = "sketchybar-app-font:Regular:16.0",
			y_offset = -1,
			drawing = true,
		},
	})

	M.spaces[i] = space.name
	space:subscribe("space_change", M.space_selection)
	space:subscribe("mouse.clicked", M.mouse_click)
end

-- This is the bracket around the spaces?
sbar.add("bracket", M.spaces, {
	background = {
		color = colours.rosepine.main.base,
		border_color = colours.rosepine.main.surface,
	},
})

M.space_creator = sbar.add("item", {
	position = "left",
	padding_left = 5,
	padding_right = 5,
	icon = {
		string = "􀆊",
		font = { style = "Heavy", size = 16.0 },
	},
	label = { drawing = false },
	associated_display = "active",
})

M.space_creator:subscribe("mouse.clicked", function(_)
	print("cannot change space due to not true YABAI")
	-- sbar.exec("yabai -m space --create && sketchybar --trigger space_change")
end)

M.space_creator:subscribe("space_windows_change", function(env)
	local icon_line = ""
	local no_app = true
	for app, _ in pairs(env.INFO.apps) do
		no_app = false
		local lookup = app_icons[app]
		local icon = ((lookup == nil) and app_icons["default"] or lookup)
		icon_line = icon_line .. " " .. icon
	end
	if no_app then
		icon_line = " —"
	end

	sbar.animate("tanh", 10, function()
		sbar.set(M.spaces[env.INFO.space], {
			label = { string = icon_line, color = colours.rosepine.main.iris },
		})
	end)
end)

print("Spaces running")

return M
