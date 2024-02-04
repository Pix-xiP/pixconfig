local sbar = require("sketchybar")
local colours = require("colours")
local icons = require("icons")

local M = {}

M.discord = sbar.add("item", "discord", {
	update_freq = 20,
	position = "right",
	icon = {
		string = icons.discord,
		color = colours.rose_pallete.pine,
		drawing = true,
		font = {
			size = 18,
		},
	},
})

function M.status_label()
	local handle = assert(io.popen("lsappinfo info -only StatusLabel 'Discord'"))
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
			M.discord:set({ drawing = false })
			return
		end
		if new_label == "" then
			M.discord:set({
				drawing = true,
				icon = { color = icon_color },
				label = { string = new_label, drawing = false },
			})
		else
			M.discord:set({ drawing = true, icon = { color = icon_color }, label = { string = new_label } })
		end
	else
		M.discord:set({ drawing = false })
		return
	end
end

-- This is just to make it spin up faster on start.
M.discord_event = sbar.add("event", "discord")

M.discord:subscribe("discord", M.status_label)
M.discord:subscribe("routine", M.status_label)
M.discord:subscribe("system_woke", M.status_label)

M.bracket = { M.discord.name }

-- Auto trigger on first start // restarting sketchy
sbar.trigger("discord")

print("Discord running")

return M
