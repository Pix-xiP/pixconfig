-- pix.lua - stuff I built, however jank they be, they get the job done.
-- PIXTODO: turn this into an actual plugin I can pull from github.

return {

	-- Scratchie pad and command run and collect output
	{
		name = "pix.nvim",
		dir = "~/.config/nvim/lua/pix", -- my directory of lua helpers and random code
		-- stylua: ignore
		keys = {
			-- scratchie pad and command runner with collected output
			{
				"<leader>pw",
				function() require("pix.pixpad"):spawn_pixpad({ "" }) end,
				desc = "Spawn scratchpad",
			},
			{
				"<leader>pcw",
				function() require("pix.pixpad"):toggle_pixpad() end,
				desc = "Run command, collect output",
			},

			-- buffer helpers
			{
				"<leader>pmc",
				function() require("pix.utils").switch_case() end,
				desc = "Toggle camelCase|snake_case",
			},
		},
	},
}
