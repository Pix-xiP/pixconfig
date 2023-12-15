local wezterm = require("wezterm")
local get_os = require("keymaps.which_os")

local S = "|"

local ALT = "ALT"
local CTRL = "CTRL"
local SHIFT = "SHIFT"
local SUPER = "SUPER"

local CTRL_SUPER = CTRL .. S .. SUPER
local CTRL_SHIFT = CTRL .. S .. SHIFT
local CTRL_ALT = CTRL .. S .. ALT
local CTRL_ALT_SHIFT = CTRL .. S .. ALT .. S .. SHIFT
local CTRL_SHIFT_SUPER = CTRL .. S .. SHIFT .. S .. SUPER

-- KEYBINDINGS
-- Defaults found at: https://wezfurlong.org/wezterm/config/default-keys.html
-- Which OS are we running on?
local the_os = get_os()
print(the_os)
local keys = {}
local act = wezterm.action

-- Check for Linux
if the_os == "Linux" then
	keys = {
		-- Movements
		{ key = "n", mods = CTRL_ALT, action = act.ActivatePaneDirection("Left") },
		{ key = "o", mods = CTRL_ALT, action = act.ActivatePaneDirection("Right") },
		{ key = "e", mods = CTRL_ALT, action = act.ActivatePaneDirection("Up") },
		{ key = "i", mods = CTRL_ALT, action = act.ActivatePaneDirection("Down") },
		-- Pane Management
		{ key = "\\", mods = CTRL_ALT, action = act.SplitHorizontal },
		{ key = "-", mods = CTRL_ALT, action = act.SplitVertical },
		{ key = "w", mods = CTRL_ALT, action = act.CloseCurrentPane({ confirm = true }) },
		{ key = "f", mods = CTRL_ALT, action = act.TogglePaneZoomState },
		{ key = "n", mods = CTRL_ALT_SHIFT, action = act.AdjustPaneSize({ "Left", 2 }) },
		{ key = "o", mods = CTRL_ALT_SHIFT, action = act.AdjustPaneSize({ "Right", 2 }) },
		{ key = "e", mods = CTRL_ALT_SHIFT, action = act.AdjustPaneSize({ "Up", 2 }) },
		{ key = "i", mods = CTRL_ALT_SHIFT, action = act.AdjustPaneSize({ "Down", 2 }) },

		-- Pane Movement.
		{ key = "o", mods = CTRL, action = act.PaneSelect({ alphabet = "arstqwfpzxcvneio", mode = "SwapWithActive" }) },
		{ key = "'", mods = CTRL, action = act.PaneSelect({ alphabet = "arstqwfpzxcvneio" }) },
	}
end

if the_os == "Darwin" then
	keys = {
		{ key = "n", mods = CTRL_SUPER, action = act.ActivatePaneDirection("Left") },
		{ key = "o", mods = CTRL_SUPER, action = act.ActivatePaneDirection("Right") },
		{ key = "e", mods = CTRL_SUPER, action = act.ActivatePaneDirection("Up") },
		{ key = "i", mods = CTRL_SUPER, action = act.ActivatePaneDirection("Down") },
		-- Pane Management
		{ key = "\\", mods = CTRL_SUPER, action = act.SplitHorizontal },
		{ key = "-", mods = CTRL_SUPER, action = act.SplitVertical },
		{ key = "w", mods = CTRL_SUPER, action = wezterm.action.CloseCurrentPane({ confirm = true }) },
		{ key = "f", mods = CTRL_SUPER, action = wezterm.action.TogglePaneZoomState },
		{ key = "n", mods = CTRL_SHIFT_SUPER, action = act.AdjustPaneSize({ "Left", 2 }) },
		{ key = "o", mods = CTRL_SHIFT_SUPER, action = act.AdjustPaneSize({ "Right", 2 }) },
		{ key = "e", mods = CTRL_SHIFT_SUPER, action = act.AdjustPaneSize({ "Up", 2 }) },
		{ key = "i", mods = CTRL_SHIFT_SUPER, action = act.AdjustPaneSize({ "Down", 2 }) },
		-- Pane Movement
		{ key = "o", mods = CTRL, action = act.PaneSelect({ alphabet = "arstqwfpzxcvneio", mode = "SwapWithActive" }) },
		{ key = "'", mods = CTRL, action = act.PaneSelect({ alphabet = "arstqwfpzxcvneio" }) },
	}
end

return keys
