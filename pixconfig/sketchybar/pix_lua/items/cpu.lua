local sbar = require("sketchybar")
local colours = require("colours")
-- local icons = require("icons")

local M = {}

M.helper_name = "git.felix.helper"

M.cpu_top = sbar.add("item", "cpu.top", {
	position = "right",
	label = {
		string = "CPU",
		font = { style = "Semibold", size = 7 },
	},
	icon = { drawing = false },
	width = 0,
	padding_right = 15,
	y_offset = 6,
	mach_helper = M.helper_name,
})

M.cpu_percent = sbar.add("item", "cpu.percent", {
	position = "right",
	label = {
		string = "CPU",
		font = { style = "Heavy", size = 12 },
	},
	y_offset = -4,
	padding_right = 15,
	width = 55,
	icon = {
		drawing = false,
	},
	update_freq = 4,
	mach_helper = M.helper_name,
})

M.cpu_sys = sbar.add("graph", "cpu.sys", 75, {
	position = "right",
	width = 0,
	graph = {
		color = colours.rose_pallete.love,
		fill_color = colours.rose_pallete.love,
	},
	background = {
		height = 30,
		drawing = true,
		color = colours.basics.transparent,
	},
})

M.cpu_user = sbar.add("graph", "cpu.user", 75, {
	position = "right",
	graph = {
		color = colours.rose_pallete.pine,
	},
	label = { drawing = false },
	icon = { drawing = false },
	background = {
		height = 30,
		drawing = true,
		color = colours.basics.transparent,
	},
})

-- Helper to push to the CPU
sbar.exec("/Users/pix/AdeptusCustodes/pix_hyprland/pixconfig/sketchybar/helper/helper git.felix.helper >/dev/null 2>&1")

print("CPU running")

return M
