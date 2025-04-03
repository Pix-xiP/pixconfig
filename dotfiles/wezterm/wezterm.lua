-- PIX WEZTERM CONFIG
-- Featureing my own brand of terrible LUA!
--

-- ===============
-- Setup and Requires
-- ===============
-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local C = {}
if wezterm.config_builder then
	C = wezterm.config_builder()
end

local theme = require("themes.theme")
local keys = require("keymaps.keymaps")
-- local utils = require("utils.utils") -- TODO: Put a global helper utils into the lua path.
local bg_config = require("background.wallpaper")
local secrets = require("secrets.servers") -- For stuff I don't want on the hub
-- ===============
-- Actual Config :>
-- ===============

-- Hotload Helpers
wezterm.add_to_config_reload_watch_list(wezterm.config_dir)
wezterm.add_to_config_reload_watch_list("/home/pix/AdeptusCustodes/pix_hyprland/pixconfig/wezterm")
-- This is where you actually apply your config choices

-- Remove window decoration bar along the top
C.window_decorations = "RESIZE"

-- Colors and theme configuration in theme.lua
C.color_scheme = theme.default
C.font = theme.font
C.font_size = theme.font_size

C.keys = keys

local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

C.colors = {
	tab_bar = {
		background = theme.rose_pallete.moon.surface,
		-- The active tab is the one that has focus in the window
		active_tab = {
			-- The color of the background area for the tab
			bg_color = theme.rose_pallete.moon.subtle,
			-- The color of the text for the tab
			fg_color = theme.rose_pallete.moon.base,
			-- Specify whether you want "Half", "Normal" or "Bold" intensity for the
			-- label shown for this tab.
			-- The default is "Normal"
			intensity = "Normal",
			-- Specify whether you want "None", "Single" or "Double" underline for
			-- label shown for this tab.
			-- The default is "None"
			underline = "None",
			-- Specify whether you want the text to be italic (true) or not (false)
			-- for this tab.  The default is false.
			italic = true,
			-- Specify whether you want the text to be rendered with strikethrough (true)
			-- or not for this tab.  The default is false.
			strikethrough = false,
		},
		inactive_tab = {
			bg_color = theme.rose_pallete.moon.overlay,
			fg_color = theme.rose_pallete.moon.subtle,
		},
		-- You can configure some alternate styling when the mouse pointer
		-- moves over inactive tabs
		inactive_tab_hover = {
			bg_color = theme.rose_pallete.moon.base,
			fg_color = theme.rose_pallete.moon.text,
			italic = true,
		},

		-- The new tab button that let you create new tabs
		new_tab = {
			bg_color = theme.rose_pallete.moon.surface,
			fg_color = theme.rose_pallete.moon.text,
		},
		new_tab_hover = {
			bg_color = theme.rose_pallete.moon.base,
			fg_color = theme.rose_pallete.moon.text,
			italic = true,
		},
	},
}

local function tab_title(tab_info)
	local title = tab_info.tab_title
	if title and #title > 0 then
		return title
	end

	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = tab_title(tab)
	if tab.is_active then
		return {
			{ Text = " " .. SOLID_LEFT_ARROW .. " " .. title .. " " },
		}
	end
	return " " .. title .. " "
end)

C.use_fancy_tab_bar = false
C.hide_tab_bar_if_only_one_tab = false
C.tab_bar_at_bottom = false

C.window_background_image = bg_config.image
C.window_background_image_hsb = bg_config.window_hsb

-- Workspaces
---- Startup Specific.
-- local mux = wezterm.mux

-- wezterm.on("gui-startup", function(cmd)
-- 	local args = {}
-- 	if cmd then
-- 		args = cmd.args
-- 	end
--
-- 	---@diagnostic disable-next-line: unused-local
-- 	local tab, monitor_pane, window = mux.spawn_window({
-- 		workspace = "monitoring",
-- 		cwd = "~",
-- 		args = args,
-- 	})
-- 	monitor_pane:send_text("btop\n")
--
-- 	---@diagnostic disable-next-line: unused-local, redefined-local
-- 	local tab, pane, window = mux.spawn_window({
-- 		workspace = "default",
-- 		args = args,
-- 	})
--
-- 	---@diagnostic disable-next-line: unused-local
-- 	local splitter = pane:split({
-- 		direction = "Right",
-- 		size = 0.5,
-- 	})
-- 	pane:send_text("ls\n")
--
-- 	mux.set_active_workspace("default")
-- end)

-- wezterm.on("mux-startup", function()
-- 	wezterm.mux.spawn_window({ width = 100, height = 100 })
-- end)

-- MULTIPLEXER
-- Setup for different multiplex domains.
-- TODO: Setup with the rest of the workspaces :>
C.unix_domains = {
	{
		name = "pix",
		no_serve_automatically = false,
		local_echo_threshold_ms = 1000,
	},
	{ name = "backup", no_serve_automatically = false },
}

-- C.default_gui_startup_args = { "connect", "pix" }

C.ssh_domains = secrets.ssh_domains

-- Scrollback
C.scrollback_lines = 10000
-- Terminal padding inside the window.
C.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
C.adjust_window_size_when_changing_font_size = false

C.status_update_interval = 500

-- and finally, return the configuration to wezterm
return C
