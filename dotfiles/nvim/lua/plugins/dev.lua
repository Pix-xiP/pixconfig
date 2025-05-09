return {
	-- This comes from lazy, wont actually need to include myself.
	-- {
	-- "stevearc/quicker.nvim",
	-- event = "FileType qf",
	-- --- @module "quicker"
	-- --- @type quicker.SetupOptions
	-- opts = {},
	-- },

	-- {
	--   "Zeioth/compiler.nvim",
	--   cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
	--   dependencies = { "steavearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
	--   opts = {},
	-- },
	-- { -- The task runner we use
	--   "stevearc/overseer.nvim",
	--   commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
	--   cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
	--   opts = {
	--     task_list = {
	--       direction = "bottom",
	--       min_height = 25,
	--       max_height = 25,
	--       default_detail = 1,
	--     },
	--   },
	-- },

	-- { "mrjones2014/smart-splits.nvim"}

	-- quick fixes for mason 2.0 breaking changes in lazy
	{ "mason-org/mason.nvim", version = "1.11.0" },
	{ "mason-org/mason-lspconfig.nvim", version = "1.32.0" },
}
