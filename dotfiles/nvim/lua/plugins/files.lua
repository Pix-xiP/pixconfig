-- files.lua - plugins that deal with files and management of those files including VCS

return {

	-- replacement for netrw, allowing for large scale file changes
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		lazy = false,
	},

	-- yazi terminal file manager
	---@type LazySpec
	{
		"mikavilpas/yazi.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		-- stylua: ignore
		keys = {
			{ "<leader>-", function() require("yazi").yazi() end, desc = "Open the file manager", },
			{ "<leader>cw", function() require("yazi").yazi(nil, vim.fn.getcwd()) end, desc = "Open the file manager in nvim's working directory", },
		},
		---@type YaziConfig
		opts = {
			open_for_directories = false,
		},
	},
}
