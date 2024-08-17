local sbar = require("sketchybar")
local colours = require("colours")
local icons = require("icons")

local M = {}

M.slack = sbar.add("item", "slack", {
	update_freq = 1800,
	position = "right",
	click_script = "sketchybar --trigger slack",
	icon = {
		string = icons.slack,
		color = colours.rosepine.main.pine,
		drawing = false,
		font = {
			size = 18,
		},
		y_offset = 1,
	},
})

function M.status_label()
	sbar.exec("lsappinfo info -only StatusLabel 'Slack'", function(status_label)
		local label = string.match(status_label, '"label"="([^"]*)"')
		if label == "" then
			M.slack:set({ drawing = false })
		end

		if label ~= nil then
			local icon_color
			local new_label

			if label == "" then
				new_label = ""
				icon_color = colours.rosepine.main.pine
			elseif label == "•" then
				new_label = ""
				icon_color = colours.rosepine.main.rose
			elseif tonumber(label) ~= nil then
				icon_color = colours.rosepine.main.love
				new_label = label
			else
				M.slack:set({ drawing = false })
				return
			end
			if new_label == "" then
				M.slack:set({
					drawing = true,
					icon = { color = icon_color },
					label = { string = new_label, drawing = false },
				})
			else
				M.slack:set({ drawing = true, icon = { color = icon_color }, label = { string = new_label } })
			end
		else
			M.slack:set({ drawing = false })
		end
	end)
end

M.slack:subscribe("routine", M.status_label)
M.slack:subscribe("system_woke", M.status_label)

M.bracket = { M.slack.name }

M.status_label()

print("Slack running")

return M
