local wezterm = require("wezterm")
local utils = require("utils.utils")
local theme = require("themes.theme")
local act = wezterm.action

local S = "|"

local ALT = "ALT"
local CTRL = "CTRL"
local SHIFT = "SHIFT"
local SUPER = "SUPER"

-- NOTE:
-- LEADER -> L: Ctrl + Alt
--           D: Ctrl + Super
-- SHIFT LEADER -> L: Ctrl + Alt + Shift
--                 D: Ctrl + Super + Shift

local LEADER = ""
local SHIFT_LEADER = ""
local ALT_SHIFT = ALT .. S .. SHIFT
local ALT_SUPER_SHIFT = ALT .. S .. SUPER .. S .. SHIFT
---@diagnostic disable-next-line: unused-local
local WEZLEADER = CTRL .. S .. SHIFT

if utils.os == "Linux" then
	LEADER = CTRL .. S .. ALT
	SHIFT_LEADER = LEADER .. S .. SHIFT
elseif utils.os == "Darwin" then
	LEADER = CTRL .. S .. SUPER
	SHIFT_LEADER = LEADER .. S .. SHIFT
end

-- KEYBINDINGS
-- Defaults found at: https://wezfurlong.org/wezterm/config/default-keys.html

local keys = {
	-- Movements
	{ key = "n", mods = LEADER, action = act.ActivatePaneDirection("Left") },
	{ key = "o", mods = LEADER, action = act.ActivatePaneDirection("Right") },
	{ key = "e", mods = LEADER, action = act.ActivatePaneDirection("Up") },
	{ key = "i", mods = LEADER, action = act.ActivatePaneDirection("Down") },
	-- Pane Management
	{ key = "\\", mods = LEADER, action = act.SplitHorizontal },
	{ key = "-", mods = LEADER, action = act.SplitVertical },
	{ key = "w", mods = LEADER, action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "f", mods = LEADER, action = act.TogglePaneZoomState },
	{ key = "n", mods = SHIFT_LEADER, action = act.AdjustPaneSize({ "Left", 2 }) },
	{ key = "o", mods = SHIFT_LEADER, action = act.AdjustPaneSize({ "Right", 2 }) },
	{ key = "e", mods = SHIFT_LEADER, action = act.AdjustPaneSize({ "Up", 2 }) },
	{ key = "i", mods = SHIFT_LEADER, action = act.AdjustPaneSize({ "Down", 2 }) },
	-- Pane Movement.
	{ key = "o", mods = CTRL, action = act.PaneSelect({ alphabet = "arstqwfpzxcvneio", mode = "SwapWithActive" }) },
	{ key = "'", mods = CTRL, action = act.PaneSelect({ alphabet = "arstqwfpzxcvneio" }) },
	-- Workspace Management
	{
		key = "p",
		mods = LEADER,
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Enter name for workspace" },
			}),
			---@diagnostic disable-next-line: unused-local
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:perform_action(
						act.SwitchToWorkspace({
							name = line,
						}),
						pane
					)
				end
			end),
		}),
	},
	{
		key = "g",
		mods = LEADER,
		action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES", title = "WORKSPACES" }),
	},
	{ key = "r", mods = LEADER, action = wezterm.action.SwitchToWorkspace({ name = "default" }) },
	{
		key = "s",
		mods = LEADER,
		action = wezterm.action.SwitchToWorkspace({
			name = "scratch_pad",
			spawn = {
				args = { "nvim", ".scratchpad" },
			},
		}),
	},
	-- Tab Management
	{
		key = "n",
		mods = ALT_SUPER_SHIFT,
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			-- selene: allow(unused_variable)
			---@diagnostic disable-next-line: unused-local
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},

	-- Theme Selection and Hotloading.
	{
		key = "t",
		mods = ALT_SUPER_SHIFT,
		action = wezterm.action_callback(function(window, pane)
			theme.select_theme(window, pane)
		end),
	},
}

return keys
