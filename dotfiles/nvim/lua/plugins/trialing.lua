-- This file is for plugins that I don't use often, but I want to try out.
return {
	{
		"gisketch/triforce.nvim",
		dependencies = { "nvzone/volt" },

		config = function()
			require("triforce").setup({
				keymap = {
					show_profile = "<leader>tp", -- Open profile with <leader>tp
				},
			})
		end,
	},

	-- VSCde style Diff view?
	{
		"esmuellert/vscode-diff.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		cmd = "CodeDiff",
	},
}
