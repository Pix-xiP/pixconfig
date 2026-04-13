-- This file is for plugins that I don't use often, but I want to try out.
return {
	-- Fennel in Neovim
	{ "Olical/nfnl", ft = "fennel" },
	{
		"martindur/zdiff.nvim",
		cmd = "Zdiff",
		keys = {
			{ "<leader>zd", "<cmd>Zdiff<cr>", desc = "Zdiff (uncommitted)" },
			{ "<leader>zD", "<cmd>Zdiff main<cr>", desc = "Zdiff (vs main)" },
		},
		opts = {},
	},
}
