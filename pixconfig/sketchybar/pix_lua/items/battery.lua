local sbar = require("sketchybar")
local icons = require("icons")

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

	if string.find(battery, "AC Power") then
		icon = icons.battery.charging
	else
		local found, _, charge = battery:find("(%d+)%%")
		if found then
			charge = tonumber(charge)
		end

		if found and charge > 80 then
			icon = icons.battery._100
		elseif found and charge > 60 then
			icon = icons.battery._75
		elseif found and charge > 40 then
			icon = icons.battery._50
		elseif found and charge > 20 then
			icon = icons.battery._25
		else
			icon = icons.battery._0
		end
	end

	M.battery:set({ icon = icon })
end

M.battery:subscribe({
	"routine",
	"power_source_change",
	"system_woke",
}, M.battery_update)

return M
