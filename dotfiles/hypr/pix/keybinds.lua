-- Workspaces:
--   't' -> Term
--   'b' -> Browser
--   's' -> Signal
--   'd' -> Discord
--   'g' -> Gaming

-- stylua: ignore start
local vars = {
	term         = "ghostty",
	term2        = "kitty",
	file         = "dolphin",
	browser      = "zen-browser",
	settings_app = "XDG_CURRENT_DESKTOP=gnome ~/.config/hypr/hyprland/scripts/launch_first_available.sh 'qs -p ~/.config/quickshell/$qsConfig/settings.qml' 'systemsettings' 'gnome-control-center' 'better-control'",
}
-- stylua: ignore end

-- Unbind 'ii' default keys before binding my own.
-- NOTE: Unbind must match exactly, Super != SUPER and Super_L != SUPER_L etc
hl.unbind("Ctrl+Alt + T")
hl.unbind("Ctrl+Super+P")
hl.unbind("SUPER+Shift+B")
hl.unbind("SUPER+Shift+G")
hl.unbind("SUPER+Shift+S") -- screenshot
hl.unbind("SUPER+Shift+T")
hl.unbind("SUPER+Return")
hl.unbind("SUPER+SUPER_L") -- quickshell toggle
hl.unbind("SUPER+SUPER_R")
hl.unbind("SUPER+B")
hl.unbind("SUPER+C")
hl.unbind("SUPER+D")
hl.unbind("SUPER+E")
hl.unbind("SUPER+G")
hl.unbind("SUPER+I")
hl.unbind("SUPER+J")
hl.unbind("SUPER+N") -- spawn right sidebar
hl.unbind("SUPER+O") -- left toggle
hl.unbind("SUPER+Q") -- close window
hl.unbind("SUPER+S")
hl.unbind("SUPER+T") -- spawning terms
hl.unbind("SUPER+W")
-- End unbinds

-- stylua: ignore start
-- {
-- Quickshell replacement keys
hl.bind("SUPER+Space",   hl.dsp.global("quickshell:serachToggleRelease"), { desc = "Shell: Toggle search" })
hl.bind("SUPER+R",       hl.dsp.global("quickshell:sidebarRightToggle"),  { desc = "Shell: Toggle right sidebar" })
hl.bind("SUPER+P",       hl.dsp.global("quickshell:regionScreenshot"),    { desc = "Shell: Screen snip" })
hl.bind("SUPER+SHIFT+I", hl.dsp.exec_cmd(vars.settings_app),              { desc = "Launch settings app" })
hl.bind("CTRL+SUPER+G",  hl.dsp.global("quickshell:overlayToggle"),       { desc = "Shell: Toggle quickshell overlay" })

-- General // Misc
hl.bind("SUPER+SHIFT+F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Launch Binaries
hl.bind("SUPER+ALT+T", hl.dsp.exec_cmd(vars.term),        { desc = "Launch: Terminal"     })
hl.bind("SUPER+ALT+B", hl.dsp.exec_cmd(vars.browser),     { desc = "Launch: Browser"      })
hl.bind("SUPER+ALT+G", hl.dsp.exec_cmd("steam"),          { desc = "Launch: Steam"        })
hl.bind("SUPER+ALT+S", hl.dsp.exec_cmd("signal-desktop"), { desc = "Launch: Signal"       })
hl.bind("SUPER+ALT+Y", hl.dsp.exec_cmd(vars.file),        { desc = "Launch: File browser" })
hl.bind("SUPER+ALT+D", hl.dsp.exec_cmd("discord"),        { desc = "Launch: Discord"      })

hl.bind("CTRL+ALT+SUPER+P", hl.dsp.exec_cmd("hyprpicker -a"))

hl.bind(
	"SUPER+SHIFT+K",
	hl.dsp.exec_cmd("fish -c 'source ~/.config/fish/pix/pix-functions/linux/toggle-keyboard.fish; toggle-keyboard'")
)

-- Windows // Session Actions
hl.bind("SUPER+Q",      hl.dsp.window.close(), { desc = "Window: Close" })
hl.bind("SUPER+DELETE", hl.dsp.exit(),         { desc = "Exit Hyprland" })

-- Media Controls
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { desc = "Media: Play/Pause" })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { desc = "Media: Play/Pause" })
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { desc = "Media: Next"       })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { desc = "Media: Previous"   })
hl.bind("XF86AudioStop",  hl.dsp.exec_cmd("playerctl stop"),       { desc = "Media: Stop"       })

-- Groups
hl.bind("CTRL+SUPER+I", hl.dsp.group.next(), { desc = "Group: Next"     })
hl.bind("CTRL+SUPER+E", hl.dsp.group.prev(), { desc = "Group: Previous" })

--Window Management && Focus
local directions = { "left", "right", "up", "down" }
local dir_keys = { "N", "O", "E", "I" }
for i, dir in ipairs(directions) do
	hl.bind("SUPER+" .. dir_keys[i], hl.dsp.focus({ direction = dir }))
	hl.bind("SUPER+SHIFT+CTRL+" .. dir_keys[i], hl.dsp.window.move({ direction = dir }))
end

hl.bind("SUPER+W", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER+SHIFT+ALT+G", hl.dsp.group.toggle())

-- Resize Windows
hl.bind("SUPER+SHIFT+Right", hl.dsp.window.resize({ x = 30, y = 0,  "relative" }))
hl.bind("SUPER+SHIFT+Left",  hl.dsp.window.resize({ x = -30, y = 0, "relative" }))
hl.bind("SUPER+SHIFT+Up",    hl.dsp.window.resize({ x = 0, y = -30, "relative" }))
hl.bind("SUPER+SHIFT+Down",  hl.dsp.window.resize({ x = 0, y = 30,  "relative" }))

-- Named Workspaces and Bindings
local workspaces = {
	{ id = "5", key = "T", monitor = "DP-1",     name = "Term"    },
	{ id = "6", key = "G", monitor = "DP-1",     name = "Steam"   },
	{ id = "7", key = "B", monitor = "DP-2",     name = "Browser" },
	{ id = "8", key = "D", monitor = "HDMI-A-1", name = "Discord" },
	{ id = "9", key = "S", monitor = "HDMI-A-1", name = "Signal"  },
}
for _, ws in ipairs(workspaces) do
    hl.workspace_rule({ workspace = ws.id, monitor = ws.monitor, default_name = ws.name, default = true })
    hl.bind("SUPER+"       .. ws.key, hl.dsp.focus({ workspace = ws.id }))
    hl.bind("SUPER+SHIFT+" .. ws.key, hl.dsp.window.move({ workspace = ws.id, follow = false }))
end

for i = 1, 4 do
	hl.bind("SUPER+SHIFT+" .. i, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Toggle Quickshell
hl.bind("SUPER+CTRL+J", hl.dsp.global("quickshell:barToggle"), { desc = "Shell: Toggle quickshell bar" })
-- Toggle tiled splits
hl.bind("SUPER+J", hl.dsp.layout("togglesplit"))
hl.bind("SUPER+SHIFT+J", hl.dsp.layout("swapsplit"))

-- Move between special workspace || scratchpad
hl.bind("SUPER+Z", hl.dsp.workspace.toggle_special("special"))
hl.bind("SUPER+SHIFT+Z", hl.dsp.window.move({ workspace = "special:special", follow = false }))

-- MISC
hl.bind("SUPER+SHIFT+ALT+T", hl.dsp.global("quickshell:screenTranslate"))
-- }
-- stylua: ignore end
