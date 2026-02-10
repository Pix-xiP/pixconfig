-- pix.lua - stuff I built, however jank they be, they get the job done.
if true then
	return {}
end

-- PIXTODO: turn this into an actual plugin I can pull from github.
local pixpad = require("pix.pixpad")
local pixutils = require("pix.utils")

return {

	-- Scratchie pad and command run and collect output
	{
		name = "pix.nvim",
		dir = "~/.config/nvim/lua/pix", -- my directory of lua helpers and random code
		-- stylua: ignore
		keys = {
			-- scratchie pad and command runner with collected output
			{ "<leader>pw", function() pixpad:spawn_pixpad({""}) end, desc = "Spawn scratchpad" },
			{ "<leader>pcw", function() pixpad:toggle_pixpad() end, desc = "Run command, collect output" },

			-- buffer helpers
			{ "<leader>pmc", pixutils.switch_case, desc = "Toggle camelCase|snake_case" },
		},
	},
}
