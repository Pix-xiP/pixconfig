-- Adding coding related things to this file moving forward.
-- Basing the file layout design off of Folke's LazyVim cause I like it :>

return {
	-- Using Folke's mini surround from LazyVim cause I like this setup:
	{
		"echasnovski/mini.surround",
		version = "*",
		opts = {
			-- Add custom surroundings to be used on top of builtin ones. For more
			-- information with examples, see `:h MiniSurround.config`.
			custom_surroundings = nil,

			-- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
			highlight_duration = 500,

			mappings = {
				add = "gsa", -- Add surrounding in Normal and Visual modes
				delete = "gsd", -- Delete surrounding
				find = "gsf", -- Find surrounding (to the right)
				find_left = "gsF", -- Find surrounding (to the left)
				highlight = "gsh", -- Highlight surrounding
				replace = "gsr", -- Replace surrounding
				update_n_lines = "gsn", -- Update `n_lines`
			},
		},
	},
	{
		"ej-shafran/compile-mode.nvim",
		-- tag = "v5.*",
		branch = "latest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- if you want to enable coloring of ANSI escape codes in compilation output, add:
			{ "m00qek/baleia.nvim", tag = "v1.3.0" },
		},
		config = function()
			vim.g.compile_mode = {
				-- to add ANSI escape code support, add:
				baleia_setup = true,
				default_command = "",
				error_threshold = require("compile-mode").level.INFO,
				recompile_no_fail = true,
			}
		end,
	},
	{
		"Kicamon/markdown-table-mode.nvim",
		opts = {
			insert = true,
			insert_leave = true,
		},
	},
	{
		"yanskun/gotests.nvim",
		ft = "go",
		config = function()
			require("gotests").setup()
		end,
	},
	{
		"fredrikaverpil/godoc.nvim",
		version = "*",
		dependencies = {
			{ "ibhagwan/fzf-lua" },
			{
				"nvim-treesitter/nvim-treesitter",
				opts = {
					ensure_installed = { "go" },
				},
			},
		},
		build = "go install github.com/lotusirous/gostdsym/stdsym@latest",
		cmd = { "GoDoc" },
		opts = {
			picker = {
				type = "fzf_lua",

				fzf_lua = {
					winopts = {
						height = 0.8,
						width = 0.8,
						preview = {
							vertical = "right:50%",
							horizontal = "up:60%",
							layout = "verdical",
							title = "Go Docs",
						},
					},
	       -- stylua: ignore
				fzf_opts = {
					["--layout"] = "reverse",
					["--info"]   = "inline",
					["--border"] = "rounded",
				},
					keymap = {
						fzf = {
							["ctrl-f"] = "preview-page-down",
							["ctrl-b"] = "preview-page-up",
						},
					},
				},
			},
		},
	},
}
