local wezterm = require("wezterm")
local utils = require("utils.utils")
local theme = require("themes.theme")

local S = "|"

local ALT = "ALT"
local CTRL = "CTRL"
local SHIFT = "SHIFT"
local SUPER = "SUPER"

local CTRL_SUPER = CTRL .. S .. SUPER
local CTRL_SHIFT = CTRL .. S .. SHIFT
local CTRL_ALT = CTRL .. S .. ALT
local ALT_SHIFT = ALT .. S .. SHIFT
local CTRL_ALT_SHIFT = CTRL .. S .. ALT .. S .. SHIFT
local CTRL_SHIFT_SUPER = CTRL .. S .. SHIFT .. S .. SUPER
local ALT_SUPER_SHIFT = ALT .. S .. SUPER .. S .. SHIFT

-- KEYBINDINGS
-- Defaults found at: https://wezfurlong.org/wezterm/config/default-keys.html
local keys = {}
local act = wezterm.action

-- TODO: Smarter way to do this would be to remap the above CTRL_ALT etc to be
-- os agnostic.
-- TODO: TODO: Actualy do the above, have all the utils and stuff good to go.

-- Check for Linux
if utils.os == "Linux" then
	keys = {

		-- TEST

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
		{
			key = "p",
			mods = CTRL_ALT,
			action = act.PromptInputLine({
				description = wezterm.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Foreground = { AnsiColor = "Fuchsia" } },
					{ Text = "Enter name for workspace" },
				}),
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
			mods = CTRL_ALT,
			action = wezterm.action_callback(function(window, pane)
				local choices = {}
				for n = 1, 20 do
					table.insert(choices, { label = tostring(n) .. "workspace" })
				end

				window:perform_action(
					act.InputSelector({
						action = wezterm.action_callback(function(window, pane, id, label)
							if not id and not label then
								wezterm.log_info("cancelled")
							else
								wezterm.log_info("you selected: ", id, label)
								pane:send_text(label)
							end
						end),
						title = "Title Text",
						choices = choices,
						alphabet = "123456789",
						description = " Testing pressing keys, using / to search",
					}),
					pane
				)
			end),
		},
		-- Tab Management
		{
			key = "n",
			mods = ALT_SHIFT,
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
elseif utils.os == "Darwin" then
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
		-- Switch to the default workspace
		{ key = "r", mods = CTRL_SUPER, action = wezterm.action.SwitchToWorkspace({ name = "default" }) },
		-- Switch to a monitoring workspace, which will have `top` launched into it
		{
			key = "s",
			mods = CTRL_SUPER,
			action = wezterm.action.SwitchToWorkspace({
				name = "scratch_pad",
				spawn = {
					args = { "vim" },
				},
			}),
		},
		{
			key = "p",
			mods = CTRL_SUPER,
			action = act.PromptInputLine({
				description = wezterm.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Foreground = { AnsiColor = "Fuchsia" } },
					{ Text = "Enter name for workspace" },
				}),
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
			mods = CTRL_SUPER,
			action = wezterm.action_callback(function(window, pane)
				local choices = {}
				for n = 1, 20 do
					table.insert(choices, { label = tostring(n) .. "workspace" })
				end

				window:perform_action(
					act.InputSelector({
						action = wezterm.action_callback(function(window, pane, id, label)
							if not id and not label then
								wezterm.log_info("cancelled")
							else
								wezterm.log_info("you selected: ", id, label)
								pane:send_text(label)
							end
						end),
						title = "Title Text",
						choices = choices,
						alphabet = "123456789",
						description = " Testing pressing keys, using / to search",
					}),
					pane
				)
			end),
		},
	}
end

return keys
