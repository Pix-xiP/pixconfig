-- ui.lua - all the configuration for UI related things, colorschemes, statuslines, etc

return {
	{
		"umbral",
		name = "umbral",
		dir = "~/AdeptusCustodes/Lunar/nvim_plugins/umbral.nvim/",
		dev = true,
		config = function()
			vim.cmd.colorscheme("umbral")
		end,
	},
	-- {
	-- 	"pix-xip/umbral.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = function()
	-- 		vim.cmd.colorscheme("umbral")
	-- 	end,
	-- },
	-- {
	-- 	"LazyVim/LazyVim",
	-- 	opts = { colorscheme = "umbral" },
	-- },
	{
		"brenoprata10/nvim-highlight-colors",
		lazy = true,
		opts = {
			---Render style
			---@usage 'background'|'foreground'|'virtual'
			render = "background",

			---Set virtual symbol (requires render to be set to 'virtual')
			virtual_symbol = "■",

			---Set virtual symbol suffix (defaults to '')
			virtual_symbol_prefix = "",

			---Set virtual symbol suffix (defaults to ' ')
			virtual_symbol_suffix = " ",

			---Set virtual symbol position()
			---@usage 'inline'|'eol'|'eow'
			---inline mimics VS Code style
			---eol stands for `end of column` - Recommended to set `virtual_symbol_suffix = ''` when used.
			---eow stands for `end of word` - Recommended to set `virtual_symbol_prefix = ' ' and virtual_symbol_suffix = ''` when used.
			virtual_symbol_position = "inline",

			---Highlight hex colors, e.g. '#FFFFFF'
			enable_hex = true,

			---Highlight short hex colors e.g. '#fff'
			enable_short_hex = true,

			---Highlight rgb colors, e.g. 'rgb(0 0 0)'
			enable_rgb = true,

			---Highlight hsl colors, e.g. 'hsl(650deg 30% 40%)'
			enable_hsl = true,

			---Highlight CSS variables, e.g. 'var(--testing-color)'
			enable_var_usage = true,

			---Highlight named colors, e.g. 'green'
			enable_named_colors = true,

			---Highlight tailwind colors, e.g. 'bg-blue-500'
			enable_tailwind = false,

			---Set custom colors
			---Label must be properly escaped with '%' to adhere to `string.gmatch`
			--- :help string.gmatch
			custom_colors = {
				{ label = "%-%-theme%-primary%-color", color = "#0f1219" },
				{ label = "%-%-theme%-secondary%-color", color = "#5a5d64" },
			},

			-- Exclude filetypes or buftypes from highlighting e.g. 'exclude_buftypes = {'text'}'
			exclude_filetypes = {},
			exclude_buftypes = {},
		},
		init = function()
			require("nvim-highlight-colors").turnOn()
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			sections = {
				lualine_a = {
					{
						"mode",
						icons_enabled = true,
						separator = {
							-- left = "",
							-- right = "",
							right = "",
						},
						fmt = function()
							local mode_map = {
								n = "N (ᴗ_ ᴗ。)",
								nt = "N (ᴗ_ ᴗ。)",
								i = "I (•̀ - •́ )",
								R = "R ( •̯́ ₃ •̯̀)",
								v = "V (⊙ _ ⊙ )",
								V = "V (⊙ _ ⊙ )",
								no = "C Σ(°△°||)",
								["\22"] = "V (⊙ _ ⊙ )",
								t = "T (⌐■_■)",
								["!"] = "C Σ(°△°||)",
								c = "C Σ(°△°||)",
								s = "S SUB",
							}
							return mode_map[vim.api.nvim_get_mode().mode] or vim.api.nvim_get_mode().mode
						end,
					},
				},
			},
		},
	},
	---@type LazySpec
	{
		"mikavilpas/yazi.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		event = "VeryLazy",
		keys = {
			{
				"<leader>-",
				function()
					require("yazi").yazi()
				end,
				desc = "Open the file manager",
			},
			{
				"<leader>cw",
				function()
					require("yazi").yazi(nil, vim.fn.getcwd())
				end,
				desc = "Open the file manager in nvim's working directory",
			},
		},
		---@type YaziConfig
		opts = {
			open_for_directories = false,
		},
	},
	{ "echasnovski/mini.hipatterns", version = false },

	-- filetype icons
	{
		"echasnovski/mini.icons",
		opts = {
			file = {
				[".go-version"] = { glyph = "", hl = "MiniIconsBlue" },
			},
			filetype = {
				gotmpl = { glyph = "󰟓", hl = "MiniIconsGrey" },
			},
		},
	},
}
