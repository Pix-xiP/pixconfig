local icons = require("icons")
local sbar = require("sketchybar")

local M = {}

M.wifi = sbar.add("item", {
	position = "right",
	padding_right = 7,
	label = {
		width = 0,
	},
	icon = {
		string = icons.wifi.disconnected,
		-- padding_right = 0,
	},
})

M.bracket = { M.wifi.name }

function M:update()
	local file = assert(
		io.popen(
			"/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I | awk -F ' SSID: '  '/ SSID: / {print $2}'"
		)
	)
	local wifi_name = assert(file:read("*a"))
	file:close()

	file = assert(io.popen("ipconfig getifaddr en0"))
	local addr = assert(file:read("*a"))
	file:close()

	local icon = icons.wifi.connected
	if wifi_name == "" then
		icon = icons.wifi.disconnected
	end

	M.wifi:set({
		label = {
			string = wifi_name .. " - " .. addr,
			drawing = true,
		},
		icon = {
			string = icon,
		},
	})
end

function M:wifi_clicked()
	local curr = M.wifi:query().label.width
	local width = "0"

	if curr == 0 then
		width = "dynamic"
	end

	sbar.animate("sin", 20, function(_)
		M.wifi:set({ label = { width = width } })
	end)
end

M.wifi:subscribe("wifi_change", M.update)
M.wifi:subscribe("mouse.clicked", M.wifi_clicked)

print("Wifi running")

return M
