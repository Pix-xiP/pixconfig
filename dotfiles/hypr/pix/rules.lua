----- Window Rules -----

hl.window_rule({ match = { class = "^()$", title = "^()$" }, no_blur = true })
hl.window_rule({ match = { class = ".*" }, no_blur = true }) -- blur gone for everything

hl.window_rule({ match = { title = "^(Launcher)$" }, float = true })
hl.window_rule({ match = { title = "^(Marvel Rivals)$" }, float = true, stay_focused = true, monitor = "DP-2" })
hl.window_rule({ match = { class = "^(steam)$", title = "^(Friends List)$" }, float = true })
hl.window_rule({ match = { class = "^(steam)$", title = "^()$" }, stay_focused = true, min_size = { 1, 1 } })

hl.window_rule({ match = { title = "(.*)- Cricket$" }, float = true })
hl.window_rule({ match = { title = "(.*)- Cricket$" }, move = { 75, "44%" } })

-- Tearing rules

hl.window_rule({ match = { class = "^(steam_app).*" }, immediate = true })

-- Workspace Rules

hl.workspace_rule({ workspace = "special:special", gaps_out = 30 })

-- Screensharing
hl.window_rule({ match = { title = ".*is sharing (a window|your screen).*" }, float = true })
hl.window_rule({ match = { title = ".*is sharing (a window|your screen).*" }, pin = true })
hl.window_rule({
	match = { title = ".*is sharing (a window|your screen).*" },
	move = { "(monitor_w*.5-window_w*.5)", "(monitor_h-window_h-12)" },
})
