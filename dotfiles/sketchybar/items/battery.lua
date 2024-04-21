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
	update_freq = 180,
	popup = { align = "center" },
})

M.remaining_time = sbar.add("item", {
	position = "popup." .. M.battery.name,
	icon = {
		string = "Time remaining:",
		width = 100,
		align = "left",
	},
	label = {
		string = "??:??h",
		width = 100,
		align = "right",
	},
})

function M.battery_update()
	sbar.exec("pmset -g batt", function(battery)
		local icon = "!"
		local charge_str
		local colour

		if battery:find("AC Power") then
			colour = colours.rose_pallete.pine
			icon = icons.battery.charging
			charge_str = ""
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
	end)
end

---@diagnostic disable-next-line: unused-local
M.battery:subscribe("mouse.entered", function(env)
	local drawing = M.battery:query().popup.drawing
	M.battery:set({ popup = { drawing = "toggle" } })

	if drawing == "off" then
		sbar.exec("pmset -g batt", function(batt_info)
			if batt_info:find("AC Power") then
				M.remaining_time:set({ label = "Inf" })
			else
				local found, _, remaining = batt_info:find(" (%d+:%d+) remaining")
				local label = found and remaining .. "h" or "No estimate"
				M.remaining_time:set({ label = label })
			end
		end)
	end
end)

---@diagnostic disable-next-line: unused-local
M.battery:subscribe("mouse.exited", function(env)
	M.battery:set({ popup = { drawing = "toggle" } })
end)

M.battery:subscribe({ "routine", "power_source_change", "system_woke" }, M.battery_update)

sbar.add("bracket", "widgets.battery.bracket", { M.battery.name }, {
	background = { color = colours.rose_pallete.muted },
})

sbar.add("item", "widgets.battery.padding", {
	position = "right",
	width = 5,
})

return M
