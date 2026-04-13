-- files.lua - plugins that deal with files and management of those files including VCS

return {

	-- replacement for netrw, allowing for large scale file changes
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		dependencies = { { "nvim-mini/mini.icons", opts = {} } },
		cmd = { "Oil" },
		keys = {
			{ "-", "<cmd>Oil<cr>", desc = "Open Oil" },
		},
		init = function()
			-- If nvim starts with a directory argument (e.g. `nvim .`), open Oil for it.
			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function()
					local arg = vim.fn.argv(0)
					if arg and arg ~= "" and vim.fn.isdirectory(arg) == 1 then
						require("lazy").load({ plugins = { "oil.nvim" } })
						vim.schedule(function()
							vim.cmd("Oil")
						end)
					end
				end,
			})
		end,
	},

	-- yazi terminal file manager
	---@type LazySpec
	-- {
	-- 	"mikavilpas/yazi.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- 	event = "VeryLazy",
	-- 	-- stylua: ignore
	-- 	keys = {
	-- 		{ "<leader>-", function() require("yazi").yazi() end, desc = "Open the file manager", },
	-- 		{ "<leader>cw", function() require("yazi").yazi(nil, vim.fn.getcwd()) end, desc = "Open the file manager in nvim's working directory", },
	-- 	},
	-- 	---@type YaziConfig
	-- 	opts = {
	-- 		open_for_directories = false,
	-- 	},
	-- },
}
