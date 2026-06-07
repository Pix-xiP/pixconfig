-- Hearthfiles
vim.filetype.add({
	filename = {
		["Hearthfile"] = "lua",
	},
})

-- Gofiles
vim.filetype.add({
	extension = {
		go = "go",
		s = "asm",
		tmpl = "gotexttmpl",
		gotext = "gotexttmpl",
		gohtml = "gohtmltmpl",
		mod = "gomod",
		MOD = "gomod",
	},
	filename = {
		["go.sum"] = "gosum",
		["go.work.sum"] = "gosum",
		["go.work"] = "gowork",
	},
})

-- Generic
vim.filetype.add({
	extension = {
		modulemap = "modulemap",
		rpy = "renpy",
		service = "systemd",
	},
})
