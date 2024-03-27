local colours = require("colours")
local icons = require("icons")
local sbar = require("sketchybar")

local M = {}
-- PIXTODO: Use sbar.add("bracket") t create another bracket on the right hand side.

local popup_width = 250

print("Unloading the macOS screen indicator")
sbar.exec("launchctl unload -F /System/Library/LaunchAgents/com.apple.OSDUIHelper.plist >/dev/null 2>&1")

M.volume_percent = sbar.add("item", "widgets.volume1", {
	position = "right",
	icon = { drawing = false },
	label = {
		string = "??%",
		padding_left = -1,
		font = { family = "SF Mono" },
	},
})

M.volume_icon = sbar.add("item", "widgets.volmume2", {
	position = "right",
	padding_right = 1,
	icon = {
		string = icons.volume._100,
		width = 0,
		align = "left",
		color = colours.rose_pallete.muted,
		font = {
			style = "Regular",
			size = 14.0,
		},
	},
	label = {
		width = 25,
		align = "left",
		font = {
			style = "Regular",
			size = 14.0,
		},
	},
})

M.volume_bracket = sbar.add("bracket", "widgets.volume.bracket", {
	M.volume_icon.name,
	M.volume_percent.name,
}, {
	background = { color = colours.rose_pallete.muted },
	popup = { align = "center" },
})

M.volume_slider = sbar.add("slider", popup_width, {
	position = "popup." .. M.volume_bracket.name,
	slider = {
		highlight_color = colours.rose_pallete.pine,
		background = {
			height = 6,
			corner_radius = 3,
			color = colours.rose_pallete.overlay,
		},
		knob = {
			string = "􀀁",
			drawing = true,
		},
	},
	background = {
		color = colours.rose_pallete.muted,
		height = 2,
		y_offset = -20,
	},
	click_script = 'osascript -e "set volume output volume $PERCENTAGE"',
})

M.volume_slider:subscribe("mouse.clicked", function(env)
	sbar.exec("osascript -e 'set volume output volume " .. env["PERCENTAGE"] .. "'")
end)

M.volume_percent:subscribe("volume_change", function(env)
	local volume = tonumber(env.INFO)
	local icon = icons.volume._0
	if volume > 60 then
		icon = icons.volume._100
	elseif volume > 30 then
		icon = icons.volume._66
	elseif volume > 10 then
		icon = icons.volume._33
	elseif volume > 0 then
		icon = icons.volume._10
	end

	local lead = ""
	if volume < 10 then
		lead = "0"
	end

	M.volume_icon:set({ label = icon })
	M.volume_percent:set({ label = lead .. volume .. "%" })
	M.volume_slider:set({ slider = { percentage = volume } })
end)

function M.volume_collapse_details()
	local drawing = M.volume_bracket:query().popup.drawing == "on"
	if not drawing then
		return
	end
	M.volume_bracket:set({ popup = { drawing = false } })
	sbar.remove("/volume.device\\.*/")
end

M.current_audio_device = "None"

function M.volume_toggle_details(env)
	if env.BUTTON == "right" then
		sbar.exec("open /System/LIbrary/PreferencePanes/Sound.prefPane")
		return
	end

	local should_draw = M.volume_bracket:query().popup.drawing == "off"

	if should_draw then
		M.volume_bracket:set({ popup = { drawing = true } })

		sbar.exec("SwitchAudioSource -t output -c", function(result)
			M.current_audio_device = result:sub(1, -2)

			sbar.exec("SwitchAudioSource -a -t output", function(available)
				local current = M.current_audio_device
				local counter = 0

				for device in string.gmatch(available, "[^\r\n]+") do
					local colour = colours.basics.grey
					if current == device then
						colour = colours.basics.white
					end

					sbar.add("item", "volume.device." .. counter, {
						position = "popup." .. M.volume_bracket.name,
						width = popup_width,
						align = "center",
						label = { string = device, color = colour },
						click_script = 'SwitchAudioSource -s "'
							.. device
							.. '" && sketchybar --set /volume.device\\.*/ label.color='
							.. colours.basics.grey
							.. " --set $NAME label.color="
							.. colours.basics.white,
					})

					counter = counter + 1
				end
			end)
		end)
	else
		M.volume_collapse_details()
	end
end

function M.volume_scroll(env)
	local delta = env.SCROLL_DELTA
	sbar.exec('osascript -e "set volume output volume (output volume of (get volume settings) + ' .. delta .. ')"')
end

M.volume_icon:subscribe("mouse.entered", M.volume_toggle_details)
M.volume_icon:subscribe("mouse.scrolled", M.volume_scroll)
M.volume_percent:subscribe("mouse.clicked", M.volume_toggle_details)
M.volume_percent:subscribe("mouse.exited.global", M.volume_collapse_details)
M.volume_percent:subscribe("mouse.scrolled", M.volume_scroll)

print("Volume Running")

return M
