local M = {}

sbar.bar({
	topmost = "window",
	height = 28,
	-- color = colours.rosepine.main.base,
	color = {
		alpha = 0,
	},
	border_color = colours.rosepine.main.highlight_low,
	-- shadow = true,
	sticky = true,
	padding_right = 2,
	padding_left = 2,
	blur_radius = 20,
	margin = -2,
	position = "top",
})

print("Loaded bar and defaults")

return M
