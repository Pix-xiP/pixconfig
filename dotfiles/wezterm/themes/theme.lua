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
	-- T.font = wez.font("Maple Mono", { weight = "Regular", italic = false})
	T.font = wez.font("FiraCode", { weight = "Bold", italic = false })
	T.font_size = 11.0
elseif utils.os == "Darwin" then
	-- T.font = wez.font("FiraCode Nerd Font", { weight = "Regular", italic = false })
	T.font = wez.font("Maple Mono", {
		weight = "Regular",
		italic = false,
		-- harfbuzz_features = { "ss01=1", "ss02=1", "ss03=1", "ss04=1", "ss05=1", "cv01=1" },
	})
	T.font_size = 11.0
else
	T.font = wez.font("JetBrains Mono", { weight = "Bold", italic = true })
	T.font_size = 12.0
end

T.icons = {
	heart = " ",
	battery = "󰁹",
}

function T.select_theme(window, pane)
	window:perform_action(
		wez.action.InputSelector({
			-- selene: allow(unused_variable)
			---@diagnostic disable-next-line: unused-local, redefined-local
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
		dim_text = "#bebccf",
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

T.status_bar_colors = {
	wez_purple = {
		"#3c1361",
		"#52307c",
		"#663a82",
		"#7c5295",
		"#b491c8",
	},
}

-- selene:allow(unused_variable)
---@diagnostic disable-next-line: unused-local, redefined-local
wez.on("update-status", function(window, pane)
	-- Get the current workspace:
	local workspace = wez.mux.get_active_workspace()

	local elements = {
		{ Foreground = { Color = T.rose_pallete.moon.dim_text } },
		{ Background = { Color = T.status_bar_colors.wez_purple[1] } },
		{ Text = " WS: " .. tostring(workspace) .. " " },

		{ Background = { Color = T.status_bar_colors.wez_purple[2] } },
		{ Foreground = { Color = T.status_bar_colors.wez_purple[1] } },
		{ Text = "" .. wez.nerdfonts.pl_left_hard_divider },

		{ Foreground = { Color = T.rose_pallete.moon.dim_text } },
		{ Text = " " .. T.icons.heart .. " " },

		{ Foreground = { Color = T.status_bar_colors.wez_purple[2] } },
		{ Text = "" .. wez.nerdfonts.pl_left_hard_divider },
	}

	window:set_left_status(wez.format(elements))
end)

wez.on("update-right-status", function(window, pane)
	-- Each element holds the text for a cell in a "powerline" style << fade
	local cells = {}

	-- Figure out the cwd and host of the current pane.
	-- This will pick up the hostname for the remote host if your
	-- shell is using OSC 7 on the remote host.
	local cwd_uri_data = pane:get_current_working_dir()

	if cwd_uri_data then
		local cwd_uri = tostring(cwd_uri_data)
		if cwd_uri ~= nil then
			cwd_uri = cwd_uri:sub(8)
			local slash = cwd_uri:find("/")
			local cwd = ""
			local hostname = ""
			if slash then
				hostname = cwd_uri:sub(1, slash - 1)
				-- Remove the domain name portion of the hostname
				local dot = hostname:find("[.]")
				if dot then
					hostname = hostname:sub(1, dot - 1)
				end
				-- and extract the cwd from the uri
				cwd = cwd_uri:sub(slash)

				table.insert(cells, cwd)
				table.insert(cells, hostname)
			end
		end
	end

	-- Wez likes his date/time in this style: "Wed Mar 3 08:14"
	local date = wez.strftime("%a %b %-d %H:%M")
	table.insert(cells, date)

	-- An entry for each battery (typically 0 or 1 battery)
	for _, b in ipairs(wez.battery_info()) do
		table.insert(cells, string.format("%.0f%%" .. T.icons.battery, b.state_of_charge * 100))
	end

	-- Foreground color for the text across the fade
	-- local text_fg = "#c0c0c0"
	local text_fg = T.rose_pallete.moon.dim_text

	-- The elements to be formatted
	local elements = {}
	-- How many cells have been formatted
	local num_cells = 0

	-- Translate a cell into elements
	local function push(text, is_last)
		local cell_no = num_cells + 1
		table.insert(elements, { Foreground = { Color = text_fg } })
		table.insert(elements, { Background = { Color = T.status_bar_colors.wez_purple[cell_no] } })
		table.insert(elements, { Text = " " .. text .. " " })
		if not is_last then
			table.insert(elements, { Foreground = { Color = T.status_bar_colors.wez_purple[cell_no + 1] } })
			table.insert(elements, { Text = wez.nerdfonts.pl_right_hard_divider })
		end
		num_cells = num_cells + 1
	end

	while #cells > 0 do
		local cell = table.remove(cells, 1)
		push(cell, #cells == 0)
	end

	-- print("Setting right status")
	window:set_right_status(wez.format(elements))
end)

return T
