local sbar = require("sketchybar")
local icons = require("icons")
local colours = require("colours")
local bar = require("bar")

-- PIXTODO: Still need to finish this
local M = {}

print("Github running")

M.github_bell = sbar.add("item", {
	position = "right",
	padding_right = 6,
	update_freq = 180,
	icon = {
		string = icons.git.bell,
		-- width = 0,
		-- align = "left",
		color = colours.rose_pallete.foam,
		font = {
			style = "Bold",
			size = 15.0,
		},
	},
	label = {
		string = icons.loading,
		highlight_color = colours.rose_pallete.foam,
	},
	popup = {
		align = "right",
	},
})

M.github_template = sbar.add("item", {
	drawing = "off",
	background = {
		corner_radius = 12,
	},
	padding_left = 7,
	padding_right = 7,
	icon = {
		background = {
			height = 2,
			y_offset = -12,
		},
	},
})

M.bracket = { M.github_bell.name }

-- PIXTODO: Need to finish this.
function M:popup(ev)
	print("Popup running")
	M.github_template:set({
		popup = {
			drawing = true,
		},
	})
end

function M:update()
	print("Running update function")
	local cmd = assert(io.popen("gh api notifications"))
	local notifs = assert(cmd:read("a*"))
	cmd:close()
	cmd = assert(io.popen("gh api notifications | jq 'length'"))
	local count = assert(cmd:read("a*"))

	local args = {}
	if notifs == "[]" then
		args.icon = icons.git.bell
		args.label = {
			string = "0",
		}
	else
		args.icon = icons.git.bell_dot
		args.label = {
			string = count,
		}
	end

	-- This might need to be label.string
	-- FIXME: Doesn't quite work - not sure if can even .string in lua
	local prev = M.github_bell:query().label.value

	print("PREV:", prev)

	-- args remove github notif here.

	local counter = 0
	args.icon.color = colours.rose_pallete.foam
end

M.github_bell:subscribe("mouse.entered", function()
	M:popup("on")
end)

M.github_bell:subscribe({ "mouse.exited", "mouse.exited.global" }, function()
	M:popup("off")
end)

M.github_bell:subscribe("mouse.clicked", function()
	M:popup("toggle")
end)

M.github_bell:subscribe({ "routine", "forced", "github.update" }, M.update)

M.github_bell:subscribe("system_woke", M.update)

return M
