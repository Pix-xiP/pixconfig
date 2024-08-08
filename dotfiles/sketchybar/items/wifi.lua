local colours = require("colours")
local icons = require("icons")
local sbar = require("sketchybar")

local M = {}

-- Execute the event provider binary which provides the event "network_update"
-- for the network interface "en0", which is fired every 2.0 seconds.
sbar.exec([[
  killall network_load >/dev/null;
  /Users/pix/.config/sketchybar/helpers/event_providers/network_load/bin/network_load en0 network_update 2.0
]])

local popup_width = 250

M.wifi_up = sbar.add("item", "widgets.wifi1", {
	position = "right",
	padding_left = -5,
	width = 0,
	icon = {
		padding_right = 0,
		font = {
			style = "Bold",
			size = 9.0,
		},
		string = icons.wifi.upload,
	},
	label = {
		font = {
			family = "SF Mono",
			style = "Bold",
			size = 9.0,
		},
		color = colours.basics.red,
		string = "??? Bps",
	},
	y_offset = 4,
})

M.wifi_down = sbar.add("item", "widgets.wifi2", {
	position = "right",
	padding_left = -5,
	icon = {
		padding_right = 0,
		font = {
			style = "Bold",
			size = 9.0,
		},
		string = icons.wifi.download,
	},
	label = {
		font = {
			family = "SF Mono",
			style = "Bold",
			size = 9.0,
		},
		color = colours.basics.blue,
		string = "??? Bps",
	},
	y_offset = -4,
})

M.wifi = sbar.add("item", "widgets.wifi.padding", {
	position = "right",
	label = { drawing = false },
})

-- Background around the item
M.wifi_bracket = sbar.add("bracket", "widgets.wifi.bracket", {
	M.wifi.name,
	M.wifi_up.name,
	M.wifi_down.name,
}, {
	background = { color = colours.rose_pallete.muted },
	popup = { align = "center", height = 30 },
})

M.ssid = sbar.add("item", {
	position = "popup." .. M.wifi_bracket.name,
	icon = {
		font = {
			style = "Bold",
		},
		string = icons.wifi.router,
	},
	width = popup_width,
	align = "center",
	label = {
		font = {
			size = 15,
			style = "Bold",
		},
		max_chars = 18,
		string = "????????????",
	},
	background = {
		height = 2,
		color = colours.rose_pallete.overlay,
		y_offset = -15,
	},
})

M.hostname = sbar.add("item", {
	position = "popup." .. M.wifi_bracket.name,
	icon = {
		align = "left",
		string = "Hostname:",
		width = popup_width / 2,
	},
	label = {
		max_chars = 20,
		string = "????????????",
		width = popup_width / 2,
		align = "right",
	},
})

M.ip = sbar.add("item", {
	position = "popup." .. M.wifi_bracket.name,
	icon = {
		align = "left",
		string = "IP:",
		width = popup_width / 2,
	},
	label = {
		string = "???.???.???.???",
		width = popup_width / 2,
		align = "right",
	},
})

M.mask = sbar.add("item", {
	position = "popup." .. M.wifi_bracket.name,
	icon = {
		align = "left",
		string = "Subnet mask:",
		width = popup_width / 2,
	},
	label = {
		string = "???.???.???.???",
		width = popup_width / 2,
		align = "right",
	},
})

M.router = sbar.add("item", {
	position = "popup." .. M.wifi_bracket.name,
	icon = {
		align = "left",
		string = "Router:",
		width = popup_width / 2,
	},
	label = {
		string = "???.???.???.???",
		width = popup_width / 2,
		align = "right",
	},
})

M.extra = sbar.add("item", { position = "right", width = 5 })

M.wifi_up:subscribe("network_update", function(env)
	local up_color = (env.upload == "000 Bps") and colours.basics.grey or colours.basics.red
	local down_color = (env.download == "000 Bps") and colours.basics.grey or colours.basics.blue
	M.wifi_up:set({
		icon = { color = up_color },
		label = {
			string = env.upload,
			color = up_color,
		},
	})
	M.wifi_down:set({
		icon = { color = down_color },
		label = {
			string = env.download,
			color = down_color,
		},
	})
end)

---@diagnostic disable-next-line: unused-local
M.wifi:subscribe({ "wifi_change", "system_woke" }, function(env)
	---@diagnostic disable-next-line: redefined-local
	sbar.exec("ipconfig getifaddr en0", function(ip)
		local connected = not (ip == "")
		M.wifi:set({
			icon = {
				string = connected and icons.wifi.connected or icons.wifi.disconnected,
				color = connected and colours.basics.white or colours.basics.red,
			},
		})
	end)
end)

local function hide_details()
	M.wifi_bracket:set({ popup = { drawing = false } })
end

local function toggle_details()
	local should_draw = M.wifi_bracket:query().popup.drawing == "off"
	if should_draw then
		M.wifi_bracket:set({ popup = { drawing = true } })
		sbar.exec("networksetup -getcomputername", function(result)
			M.hostname:set({ label = result })
		end)
		sbar.exec("ipconfig getifaddr en0", function(result)
			M.ip:set({ label = result })
		end)
		sbar.exec("ipconfig getsummary en0 | awk -F ' SSID : '  '/ SSID : / {print $2}'", function(result)
			M.ssid:set({ label = result })
		end)
		sbar.exec("networksetup -getinfo Wi-Fi | awk -F 'Subnet mask: ' '/^Subnet mask: / {print $2}'", function(result)
			M.mask:set({ label = result })
		end)
		sbar.exec("networksetup -getinfo Wi-Fi | awk -F 'Router: ' '/^Router: / {print $2}'", function(result)
			M.router:set({ label = result })
		end)
	else
		hide_details()
	end
end

M.wifi_up:subscribe("mouse.entered", toggle_details)
M.wifi_down:subscribe("mouse.entered", toggle_details)
-- M.wifi:subscribe("mouse.clicked", toggle_details)

M.wifi:subscribe("mouse.entered", toggle_details)
M.wifi:subscribe("mouse.exited.global", hide_details)

local function copy_label_to_clipboard(env)
	local label = sbar.query(env.NAME).label.value
	sbar.exec('echo "' .. label .. '" | pbcopy')
	sbar.set(env.NAME, { label = { string = icons.clipboard, align = "center" } })
	sbar.delay(1, function()
		sbar.set(env.NAME, { label = { string = label, align = "right" } })
	end)
end

M.ssid:subscribe("mouse.clicked", copy_label_to_clipboard)
M.hostname:subscribe("mouse.clicked", copy_label_to_clipboard)
M.ip:subscribe("mouse.clicked", copy_label_to_clipboard)
M.mask:subscribe("mouse.clicked", copy_label_to_clipboard)
M.router:subscribe("mouse.clicked", copy_label_to_clipboard)

print("Wifi running")

return M
