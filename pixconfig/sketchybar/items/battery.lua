local sbar = require("sketchybar")
local icons = require("icons")
local colours = require("colours")

print("Battery running")

-- PIXTODO: Make this use a more extensive battery option

local M = {}

M.battery = sbar.add("item", {
	position = "right",
	icon = {
		font = {
			style = "Regular",
			size = 19.0,
		},
	},
	label = { drawing = false },
	update_freq = 120,
})

M.bracket = { M.battery.name }

function M.battery_update()
	local file = assert(io.popen("pmset -g batt"))
	local battery = assert(file:read("*a"))
	local icon = "!"
	file:close()
	local charge_str
	local colour

	if string.find(battery, "AC Power") then
		colour = colours.rose_pallete.pine
		icon = icons.battery.charging
	else
		local found, _, charge = battery:find("(%d+)%%")
		if found then
			charge_str = charge
			charge = tonumber(charge)
		end

		if found and charge > 80 then
			colour = colours.rose_pallete.pine
			icon = icons.battery._100
		elseif found and charge > 60 then
			colour = colours.rose_pallete.foam
			icon = icons.battery._75
		elseif found and charge > 40 then
			colour = colours.rose_pallete.gold
			icon = icons.battery._50
		elseif found and charge > 20 then
			colour = colours.rose_pallete.rose
			icon = icons.battery._25
		else
			colour = colours.rose_pallete.love
			icon = icons.battery._0
		end
	end

	M.battery:set({
		icon = {
			string = icon,
			color = colour,
		},
		label = {
			string = charge_str,
			color = colour,
			drawing = true,
		},
	})
end

M.battery:subscribe({ "routine", "power_source_change", "system_woke" }, M.battery_update)

return M
