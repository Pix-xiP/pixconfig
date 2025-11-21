-- treesitter.lua - This boi is just so heckin long it needs its own file to be easier to manage

return {

	-- treesitter syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		version = false,
		build = ":TSUpdate",
		event = { "LazyFile", "VeryLazy" },
		lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening file direct from commandline
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		opts_extend = { "ensure_installed" },
		---@type TSConfig
		---@diagnostic disable-next-line: missing-fields
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			matchup = { enable = true, enable_quotes = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["ak"] = { query = "@block.outer", desc = "around block" },
						["ik"] = { query = "@block.inner", desc = "inside block" },
						["ac"] = { query = "@class.outer", desc = "around class" },
						["ic"] = { query = "@class.inner", desc = "inside class" },
						["a?"] = { query = "@conditional.outer", desc = "around conditional" },
						["i?"] = { query = "@conditional.inner", desc = "inside conditional" },
						["af"] = { query = "@function.outer", desc = "around function " },
						["if"] = { query = "@function.inner", desc = "inside function " },
						["al"] = { query = "@loop.outer", desc = "around loop" },
						["il"] = { query = "@loop.inner", desc = "inside loop" },
						["aa"] = { query = "@parameter.outer", desc = "around argument" },
						["ia"] = { query = "@parameter.inner", desc = "inside argument" },
					},
				},
				move = {
					enable = true,
					goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
					goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
					goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
					goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
				},
			},

			-- languages we want installed easy to find.
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"fish",
				"git_config",
				"git_rebase",
				"gitattributes",
				"gitcommit",
				"gitignore",
				"go",
				"hcl",
				"html",
				"hyprlang",
				"ini",
				"json",
				"json5",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"nix",
				"odin",
				"printf",
				"query",
				"rasi",
				"regex",
				"terraform",
				"tmux",
				"toml",
				"vim",
				"vimdoc",
				"yaml",
				"zig",
			},
		},
	},

	-- easier way to wrap with a second redeclare
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, _)
			vim.filetype.add({
				extension = { rasi = "rasi", rofi = "rasi", wofi = "rasi" },
				filename = {
					["vifmrc"] = "vim",
				},
				pattern = {
					[".*/waybar/config"] = "jsonc",
					[".*/mako/config"] = "dosini",
					[".*/hypr/.+%.conf"] = "hyprlang",
					["%.env%.[%w_.-]+"] = "sh",
				},
			})
		end,
	},

	-- taken from the lazyvim treesitter to ensure textobjects have run :>
	-- {
	-- 	"nvim-treesitter/nvim-treesitter-textobjects",
	-- 	event = "VeryLazy",
	-- 	enabled = true,
	-- 	config = function()
	-- 		-- When in diff mode, we want to use the default
	-- 		-- vim text objects c & C instead of the treesitter ones.
	-- 		local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
	-- 		local configs = require("nvim-treesitter.configs")
	-- 		for name, fn in pairs(move) do
	-- 			if name:find("goto") == 1 then
	-- 				move[name] = function(q, ...)
	-- 					if vim.wo.diff then
	-- 						local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
	-- 						for key, query in pairs(config or {}) do
	-- 							if q == query and key:find("[%]%[][cC]") then
	-- 								vim.cmd("normal! " .. key)
	-- 								return
	-- 							end
	-- 						end
	-- 					end
	-- 					return fn(q, ...)
	-- 				end
	-- 			end
	-- 		end
	-- 	end,
	-- },

	-- add Folke's ts comments
	{ "folke/ts-comments.nvim" },

	-- add hyprland treesitter in
	{ "luckasRanarison/tree-sitter-hyprlang" },

	-- auto add closing tags for HTML
	{ "windwp/nvim-ts-autotag", event = "LazyFile", opts = {} },
}
