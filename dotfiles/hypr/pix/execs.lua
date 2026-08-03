hl.on("hyprland.start", function()
	hl.exec_cmd("ghostty", { workspace = "5 silent" })
	hl.exec_cmd("zen-browser", { workspace = "7 silent" })
	-- hl.exec_cmd("discord", { workspace = 8, silent = true })
	-- hl.exec_cmd("signal-desktop", { workspace = 9, silent = true })

	-- Steam Stuff
	hl.exec_cmd("xrandr --output DP-1 --primary")

	hl.exec_cmd("hyprctl setcursor GoogleDot-Black 24")
end)
