-- This file is for trying out new plugins without polluting the main config
return {
	{
		"martindur/zdiff.nvim",
		cmd = "Zdiff",
		keys = {
			{ "<leader>zd", "<cmd>Zdiff<cr>", desc = "Zdiff (uncommitted)" },
			{ "<leader>zD", "<cmd>Zdiff main<cr>", desc = "Zdiff (vs main)" },
		},
		opts = {},
	},

	{
		"rachartier/tiny-cmdline.nvim",
		init = function()
			vim.o.cmdheight = 1
			vim.g.tiny_cmdline = {
				width = { value = "70%" },
			}
		end,
		config = function()
			require("tiny-cmdline").setup({
				on_reposition = require("tiny-cmdline").adapters.blink,
			})
		end,
	},
}
