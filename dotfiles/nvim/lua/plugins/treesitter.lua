-- treesitter.lua - This boi is just so heckin long it needs its own file to be easier to manage

-- Skip treesitter for now
return {

	-- treesitter syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		version = false,
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")
			-- create a standard install dir for easier management
			ts.setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})

			-- languages we want installed easy to find.
			ts.install({
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
				-- "jsonc",
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
				"ruby",
				"terraform",
				"tmux",
				"toml",
				"vim",
				"vimdoc",
				"yaml",
				"zig",
			})
		end,
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

	-- treesitter-textobjects since they've been moved out of nvim-treesitter
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		lazy = false,
		init = function()
			-- avoid builtin ftplugin mapping conflicts as per README
			vim.g.no_plugin_maps = true
		end,
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
					include_surrounding_whitespace = false,
				},
				move = {
					set_jumps = true,
				},
			})

			local sel = require("nvim-treesitter-textobjects.select")

			local function xo_keymap(lhs, query)
				vim.keymap.set({ "x", "o" }, lhs, function()
					sel.select_textobject(query, "textobjects")
				end, { silent = true, desc = "TS select " .. query })
			end

			xo_keymap("ak", "@block.outer")
			xo_keymap("ik", "@block.inner")
			xo_keymap("ac", "@class.outer")
			xo_keymap("ic", "@class.inner")
			xo_keymap("a?", "@conditional.outer")
			xo_keymap("i?", "@conditional.inner")
			xo_keymap("af", "@function.outer")
			xo_keymap("if", "@function.inner")
			xo_keymap("al", "@loop.outer")
			xo_keymap("il", "@loop.inner")
			xo_keymap("aa", "@parameter.outer")
			xo_keymap("ia", "@parameter.inner")

			local mv = require("nvim-treesitter-textobjects.move")

			local function nxo_keymap(lhs, fn)
				vim.keymap.set({ "n", "x", "o" }, lhs, fn, { silent = true })
			end

			nxo_keymap("]f", function()
				mv.goto_next_start("@function.outer", "textobjects")
			end)
			nxo_keymap("]c", function()
				mv.goto_next_start("@class.outer", "textobjects")
			end)
			nxo_keymap("]a", function()
				mv.goto_next_start("@parameter.inner", "textobjects")
			end)

			nxo_keymap("]F", function()
				mv.goto_next_end("@function.outer", "textobjects")
			end)
			nxo_keymap("]C", function()
				mv.goto_next_end("@class.outer", "textobjects")
			end)
			nxo_keymap("]A", function()
				mv.goto_next_end("@parameter.inner", "textobjects")
			end)

			nxo_keymap("[f", function()
				mv.goto_previous_start("@function.outer", "textobjects")
			end)
			nxo_keymap("[c", function()
				mv.goto_previous_start("@class.outer", "textobjects")
			end)
			nxo_keymap("[a", function()
				mv.goto_previous_start("@parameter.inner", "textobjects")
			end)

			nxo_keymap("[F", function()
				mv.goto_previous_end("@function.outer", "textobjects")
			end)
			nxo_keymap("[C", function()
				mv.goto_previous_end("@class.outer", "textobjects")
			end)
			nxo_keymap("[A", function()
				mv.goto_previous_end("@parameter.inner", "textobjects")
			end)
		end,
	},

	-- add Folke's ts comments
	{ "folke/ts-comments.nvim" },

	-- add hyprland treesitter in
	{ "luckasRanarison/tree-sitter-hyprlang" },

	-- auto add closing tags for HTML
	{ "windwp/nvim-ts-autotag", event = "LazyFile", opts = {} },
}
