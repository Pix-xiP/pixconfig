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

	-- This will only work at home due to where its hosting, could use Zerotier to hook through?
	{
		"wakatime/vim-wakatime",
		lazy = false,
	},

	-- Fennel in Neovim
	{
		"Olical/nfnl",
		ft = "fennel",
	},
}
