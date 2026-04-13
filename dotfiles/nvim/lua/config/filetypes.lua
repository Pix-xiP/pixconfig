vim.filetype.add({
	extension = {
		rasi = "rasi",
		rofi = "rasi",
		wofi = "rasi",
	},
	filename = {
		Brewfile = "ruby",
		vifmrc = "vim",
	},
	pattern = {
		[".*/hyprland%.conf"] = "hyprlang",
		[".*%.modulemap"] = "modulemap",
		[".*/waybar/config"] = "jsonc",
		[".*/mako/config"] = "dosini",
		[".*/hypr/.+%.conf"] = "hyprlang",
		["%.env%.[%w_.-]+"] = "sh",
	},
})
