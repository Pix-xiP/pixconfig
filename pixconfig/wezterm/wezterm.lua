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
local utils = require("utils.utils")
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

C.colors = {
	tab_bar = {
		-- The active tab is the one that has focus in the window
		active_tab = {
			-- The color of the background area for the tab
			bg_color = "#2b2042",
			-- The color of the text for the tab
			fg_color = "#c0c0c0",

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
			italic = false,

			-- Specify whether you want the text to be rendered with strikethrough (true)
			-- or not for this tab.  The default is false.
			strikethrough = false,
		},

		-- Inactive tabs are the tabs that do not have focus
		inactive_tab = {
			bg_color = "#1b1032",
			fg_color = "#808080",

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `inactive_tab`.
		},

		-- You can configure some alternate styling when the mouse pointer
		-- moves over inactive tabs
		inactive_tab_hover = {
			bg_color = "#3b3052",
			fg_color = "#909090",
			italic = true,

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `inactive_tab_hover`.
		},

		-- The new tab button that let you create new tabs
		new_tab = {
			bg_color = "#1b1032",
			fg_color = "#808080",

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `new_tab`.
		},

		-- You can configure some alternate styling when the mouse pointer
		-- moves over the new tab button
		new_tab_hover = {
			bg_color = "#3b3052",
			fg_color = "#909090",
			italic = true,

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `new_tab_hover`.
		},
	},
}

C.window_decorations = "RESIZE"
C.use_fancy_tab_bar = true
-- C.enable_tab_bar = false
C.hide_tab_bar_if_only_one_tab = true
C.tab_bar_at_bottom = true

-- Background loaded by local lua
local bg_config = require("background.wallpaper")
C.window_background_image = bg_config

C.window_background_image_hsb = {
	brightness = 0.1, -- Darken background by x..
	hue = 1.0, -- Default, 1.0 leaves it unchanged.
	saturation = 1.0,
}

-- MULTIPLEXER
-- Setup for different multiplex domains.
-- TODO: Setup with the rest of the workspaces :>
C.unix_domains = {
	{ name = "pix_std", no_serve_automatically = false },
	{ name = "other", no_serve_automatically = false },
}

-- Scrollback
C.scrollback_lines = 10000

-- Terminal padding inside the window.
C.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

C.adjust_window_size_when_changing_font_size = false

local keymaps_for_conf = require("keymaps.keymaps")
C.keys = keymaps_for_conf

-- and finally, return the configuration to wezterm
return C
