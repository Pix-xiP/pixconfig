local wezterm = require("wezterm")
local S = "|"

local ALT = "ALT"
local CTRL = "CTRL"
local SHIFT = "SHIFT"
local SUPER = "SUPER"

local CTRL_SHIFT = CTRL .. S .. SHIFT
local CTRL_ALT = CTRL .. S .. ALT
local CTRL_ALT_SHIFT = CTRL .. S .. ALT .. S .. SHIFT
local CTRL_SHIFT_SUPER = CTRL .. S .. SHIFT .. S .. SUPER

-- KEYBINDINGS
-- Defaults found at: https://wezfurlong.org/wezterm/config/default-keys.html
--
local act = wezterm.action
local keys = {
	-- Movements
	{ key = "n", mods = CTRL_ALT, action = act.ActivatePaneDirection("Left") },
	{ key = "o", mods = CTRL_ALT, action = act.ActivatePaneDirection("Right") },
	{ key = "e", mods = CTRL_ALT, action = act.ActivatePaneDirection("Up") },
	{ key = "i", mods = CTRL_ALT, action = act.ActivatePaneDirection("Down") },
	-- Panel Management
	{ key = "\\", mods = CTRL_ALT, action = act.SplitHorizontal },
	{ key = "-", mods = CTRL_ALT, action = act.SplitVertical },
	{ key = "w", mods = CTRL_ALT, action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "f", mods = CTRL_ALT, action = act.TogglePaneZoomState },
	{ key = "n", mods = CTRL_ALT_SHIFT, action = act.AdjustPaneSize({ "Left", 2 }) },
	{ key = "o", mods = CTRL_ALT_SHIFT, action = act.AdjustPaneSize({ "Right", 2 }) },
	{ key = "e", mods = CTRL_ALT_SHIFT, action = act.AdjustPaneSize({ "Up", 2 }) },
	{ key = "i", mods = CTRL_ALT_SHIFT, action = act.AdjustPaneSize({ "Down", 2 }) },

	-- Panel Movement.
	{ key = "o", mods = CTRL, action = act.PaneSelect({ alphabet = "arstqwfpzxcvneio", mode = "SwapWithActive" }) },
	{ key = "'", mods = CTRL, action = act.PaneSelect({ alphabet = "arstqwfpzxcvneio" }) },
}

return keys
