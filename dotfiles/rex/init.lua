-- Rex configuration migrated from tmux, Ghostty and kitty.
-- cmd+k stays Rex's session picker (by decision).

-- Run an action and return to normal mode.
rex.action({
	name = "then_normal",
	title = "Run an action and return to normal mode",
	args = { action = "string", args = "object?" },
	run = function(ctx, args)
		rex.client.queue(args.action, args.args or {})
		rex.client.queue("client.mode.exit_all")
	end,
})

-- ---------------------------------------------------------------------------
-- tmux: prefix is ctrl+s
-- ---------------------------------------------------------------------------
rex.bind("ctrl+s>r", "client.config.reload")
rex.bind("ctrl+s>n", "pane.focus", { direction = "left" })
rex.bind("ctrl+s>i", "pane.focus", { direction = "down" })
rex.bind("ctrl+s>e", "pane.focus", { direction = "up" })
rex.bind("ctrl+s>o", "pane.focus", { direction = "right" })
rex.bind("ctrl+s>ctrl+s", "pane.send_key", { key = "ctrl+s" })

-- ---------------------------------------------------------------------------
-- Ghostty
-- ---------------------------------------------------------------------------
rex.bind("shift+pageup", "client.scroll.page_up")
rex.bind("shift+pagedown", "client.scroll.page_down")
rex.bind("ctrl+alt+\\", "pane.split", { direction = "right" })
rex.bind("ctrl+alt+-", "pane.split", { direction = "down" })
rex.bind("ctrl+alt+n", "pane.focus", { direction = "left" })
rex.bind("ctrl+alt+e", "pane.focus", { direction = "up" })
rex.bind("ctrl+alt+i", "pane.focus", { direction = "down" })
rex.bind("ctrl+alt+o", "pane.focus", { direction = "right" })
rex.bind("ctrl+alt+f", "pane.zoom")
rex.bind("ctrl+alt+shift+m", "pane.balance")
rex.bind("ctrl+alt+w", "pane.close")
rex.bind("ctrl+alt+j", "client.prompt.previous")
rex.bind("ctrl+alt+k", "client.prompt.next")

-- ---------------------------------------------------------------------------
-- kitty (the keys Ghostty also binds were kept from Ghostty)
-- ---------------------------------------------------------------------------
rex.bind("ctrl+shift+=", "client.font.increase")
rex.bind("ctrl+=", "client.font.increase")
rex.bind("ctrl+-", "client.font.decrease")
rex.bind("ctrl+shift+-", "client.font.decrease")
rex.bind("ctrl+0", "client.font.reset")

-- ---------------------------------------------------------------------------
-- Pix preferences: Maple Mono + Umbral Serenity
--
-- Client settings live in the app, not in init.lua, so these actions apply
-- them. "Set Up Pix Preferences (local)" writes the Ghostty theme beside this
-- file and imports it; use it when Rex.app and the server share a machine.
-- "Apply Pix Preferences" only selects the theme and font, so it works from a
-- remote server once the theme has been imported on the app's machine.
-- ---------------------------------------------------------------------------
local umbral_serenity = [[
# Umbral Serenity, imported from Ghostty.
palette = 0=#0b0b14
palette = 1=#d14e7c
palette = 2=#c081fa
palette = 3=#f1c4e0
palette = 4=#6f7ef0
palette = 5=#a048ed
palette = 6=#7aa6ff
palette = 7=#dfb7e8

palette = 8=#35355e
palette = 9=#f72d7c
palette =10=#c081fa
palette =11=#fca1e7
palette =12=#9ca7ff
palette =13=#c081fa
palette =14=#9ca7ff
palette =15=#eed6ee

background = #111119
foreground = #dfb7e8

cursor-color = #f1c4e0

selection-background = #262440
selection-foreground = #ff7ab2
]]

local function pix_config_dir()
	local home = os.getenv("HOME")
	if package.config:sub(1, 1) == "\\" then
		return (os.getenv("APPDATA") or (home .. "\\AppData\\Roaming")) .. "\\rex"
	end
	return (os.getenv("XDG_CONFIG_HOME") or (home .. "/.config")) .. "/rex"
end

local function pix_write_umbral_serenity()
	local path = pix_config_dir() .. "/umbral-serenity"
	local file = assert(io.open(path, "w"))
	file:write(umbral_serenity)
	file:close()
	return path
end

rex.action({
	name = "pix_setup_local",
	title = "Set Up Pix Preferences (local app + server)",
	description = "Writes and imports the Umbral Serenity theme, selects it as the dark theme, and sets the terminal font to Maple Mono. Use when Rex.app and the server are on the same machine.",
	category = "Pix",
	keywords = "setup maple mono umbral serenity theme font ghostty local",
	run = function()
		rex.client.queue("client.theme.import", { path = pix_write_umbral_serenity() })
		rex.client.queue("client.setting.themes.dark.palette", { value = "umbral-serenity" })
		rex.client.queue("client.setting.terminal.typography.font", { value = "Maple Mono" })
	end,
})

rex.action({
	name = "pix_apply_preferences",
	title = "Apply Pix Preferences (Maple Mono + Umbral Serenity)",
	description = "Selects the Umbral Serenity dark theme and sets the terminal font to Maple Mono. Pass theme_path to import the theme from a file on the app's machine first.",
	args = { theme_path = "string?" },
	category = "Pix",
	keywords = "apply maple mono umbral serenity theme font remote",
	run = function(ctx, args)
		args = args or {}
		if args.theme_path then
			rex.client.queue("client.theme.import", { path = args.theme_path })
		end
		rex.client.queue("client.setting.themes.dark.palette", { value = "umbral-serenity" })
		rex.client.queue("client.setting.terminal.typography.font", { value = "Maple Mono" })
	end,
})
