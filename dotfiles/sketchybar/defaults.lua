local M = {}

sbar.default({
	updates = "when_shown",
	icon = {
		font = {
			family = settings.font.text,
			style = settings.font.style.bold,
			size = 14.0,
		},
		color = colours.white,
		padding_left = settings.paddings,
		padding_right = settings.paddings,
	},
	label = {
		font = {
			family = settings.font.text,
			style = settings.font.style.semibold,
			size = 13.0,
		},
		color = colours.white,
		padding_left = settings.paddings,
		padding_right = settings.paddings,
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
			border_color = colours.rosepine.main.highlight_med,
			color = colours.rosepine.main.base,
			shadow = { drawing = true },
		},
		blur_radius = 20,
	},
	padding_left = 5,
	padding_right = 5,
	scroll_texts = true,
})

return M
