local NAME = ...
local wez = require("wezterm")
local utils = require("utils.utils")

local T = {}

local theme_list = {
	{ label = "Rosé Pine Moon (base16)" },
	{ label = "Catppuccin Mocha" },
	{ label = "Cloud (temrinal.sexy)" },
}

T.themes = theme_list
T.default = "Rosé Pine Moon (base16)"

if utils.os == "Linux" then
	T.font = wez.font("FiraCode", { weight = "Bold", italic = false })
elseif utils.os == "Darwin" then
	T.font = wez.font("FiraCode Nerd Font", { weight = "Regular", italic = false })
else
	T.font = wez.font("JetBrains Mono", { weight = "Bold", italic = true })
end

function T.select_theme(window, pane)
	window:perform_action(
		wez.action.InputSelector({
			-- selene: allow(unused_variable)
			---@diagnostic disable-next-line: unused-local
			action = wez.action_callback(function(window, pane, id, label)
				if not id and not label then
					wez.log_info("cancelled")
				else
					window:set_config_overrides({ color_scheme = label })
				end
			end),
			title = "Select Theme",
			choices = T.themes,
			alphabet = "123456789",
			description = "Use / to search, select your theme!",
		}),
		pane
	)
end

T.rose_pallete = {
	moon = {
		nc = "#1f1d30",
		base = "#232136",
		surface = "#2a273f",
		overlay = "#393552",
		muted = "#6e6a86",
		subtle = "#908caa",
		text = "#e0def4",
		love = "#eb6f92",
		gold = "#f6c177",
		rose = "#ea9a97",
		pine = "#3e8fb0",
		foam = "#9ccfd8",
		iris = "#c4a7e7",
		highlight_low = "#2a283e",
		highlight_med = "#44415a",
		highlight_high = "#56526e",
		none = "NONE",
	},
}

return T
