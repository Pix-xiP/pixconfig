local colours = require("colours")
local sbar = require("sketchybar")

local M = {}

print("Loading bar and defaults")

M.settings = {
	font = "SF Pro",
	paddings = 3,
}

sbar.default({
	updates = "when_shown",
	icon = {
		font = {
			family = M.settings.font,
			style = "Bold",
			size = 14.0,
		},
		color = colours.white,
		padding_left = M.settings.paddings,
		padding_right = M.settings.paddings,
	},
	label = {
		font = {
			family = M.settings.font,
			style = "Semibold",
			size = 13.0,
		},
		color = colours.white,
		padding_left = M.settings.paddings,
		padding_right = M.settings.paddings,
	},
	background = {
		height = 26,
		corner_radius = 9,
		border_width = 2,
	},
	popup = {
		background = {
			border_width = 2,
			corner_radius = 9,
			border_color = colours.rose_pallete.highlight_high,
			color = colours.rose_pallete.surface,
			shadow = { drawing = true },
		},
		blur_radius = 20,
	},
	padding_left = 5,
	padding_right = 5,
	scroll_texts = true,
})

sbar.bar({
	height = 28,
	color = colours.rose_pallete.base,
	border_color = colours.rose_pallete.highlight_low,
	-- shadow = true,
	sticky = true,
	padding_right = 10,
	padding_left = 10,
	blur_radius = 20,
	margin = -2,
	position = "top",
	topmost = "window",
})

return M
