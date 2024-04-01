local sbar = require("sketchybar")
local colours = require("colours")
local icons = require("icons")

local M = {}

M.brew = sbar.add("item", {
	position = "right",
	icon = {
		string = icons.brew.box,
		color = colours.rose_pallete.rose,
	},
	-- padding_right = 10,
	label = {
		string = "?",
	},
	update_freq = 3600,
})

M.bracket = { M.brew.name }

M.brew_event = sbar.add("event", "brew_update", "pix.brew.notif")

function M:brew_update_check()
	sbar.exec("brew outdated | wc -l | tr -d ' '", function(count_str)
		local count = tonumber(count_str)
		local colour

		if count > 0 and count < 10 then
			colour = colours.rose_pallete.iris
		elseif count >= 10 and count < 30 then
			colour = colours.rose_pallete.gold
		elseif count >= 30 then
			colour = colours.basics.love
		else
			colour = colours.rose_pallete.pine
			count_str = icons.brew.count
		end

		M.brew:set({
			label = {
				string = count_str,
			},
			icon = {
				color = colour,
			},
		})
	end)
end

function M:run_update()
	sbar.exec("brew update && brew upgrade")
	sbar.trigger("brew_update")
end

M.brew:subscribe("routine", M.brew_update_check)
M.brew:subscribe("mouse.clicked", M.run_update)

print("Brew running")

return M
