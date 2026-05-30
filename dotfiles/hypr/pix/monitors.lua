hl.monitor({
	output = "DP-2",
	mode = "1920x1080@144",
	position = "0x0",
	scale = 1,
})

hl.monitor({
	output = "DP-1",
	mode = "3440x1440@144",
	position = "1920x0",
	scale = 1,
	vrr = 2,
})

hl.monitor({
	output = "HDMI-A-1",
	-- mode = "1920x1080@144",
	mode = "preferred",
	position = "5360x0",
	scale = 1,
})
