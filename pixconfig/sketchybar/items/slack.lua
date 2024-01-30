local sbar = require("sketchybar")
local colours = require("colours")
local icons = require("icons")

local M = {}

M.slack = sbar.add("item", "slack", {
	update_freq = 3600,
	position = "right",
	click_script = "sketchybar --trigger slack",
	icon = {
		string = icons.slack,
		color = colours.rose_pallete.pine,
		drawing = true,
		font = {
			size = 18,
		},
	},
})

function M.status_label()
	local handle = assert(io.popen("lsappinfo info -only StatusLabel 'Slack'"))
	local status_label = handle:read("*a")
	handle:close()

	local label = string.match(status_label, '"label"="([^"]*)"')

	if label ~= nil then
		local icon_color
		local new_label

		if label == "" then
			new_label = ""
			icon_color = colours.rose_pallete.pine
		elseif label == "•" then
			new_label = ""
			icon_color = colours.rose_pallete.rose
		elseif tonumber(label) ~= nil then
			icon_color = colours.rose_pallete.love
			new_label = label
		else
			print("Slack exiting")
			return
		end
		if new_label == "" then
			M.slack:set({ icon = { color = icon_color }, label = { string = new_label, drawing = false } })
		else
			M.slack:set({ icon = { color = icon_color }, label = { string = new_label } })
		end
	else
		M.slack:set({ drawing = false })
		print("Slack exiting")
		return
	end
end

M.slack:subscribe("routine", M.status_label)
M.slack:subscribe("system_woke", M.status_label)

M.bracket = { M.slack.name }

M.status_label()

print("Slack running")

return M
