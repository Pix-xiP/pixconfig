-- pix.lua - all of my lua plugins
local pad = require("pix.pixpad")

return {
	{
		dir = "~/.config/nvim/lua/pix",
		keys = {
			{
				"<leader>pw",
				function()
					pad:spawn_pixpad({ "" })
				end,
			},
			{
				"<leader>pcw",
				function()
					pad:toggle_pixpad()
				end,
			},
		},
	},
}
