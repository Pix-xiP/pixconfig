-- editor.lua - interactions with the editor not already handled by [ui.lua]

return {

	-- symbols and quick code lookup of current buffer
	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline" },
		keys = { { "<leader>co", "<cmd>Outline<CR>", desc = "Toggle Outline" } },
		opts = function()
			local defaults = require("outline.config").defaults
			local opts = {
				symbols = {
					icons = {},
					filter = vim.deepcopy(LazyVim.config.kind_filter),
				},
				keymaps = {
					up_and_jump = "<up>",
					down_and_jump = "<down>",
				},
			}

			for kind, symbol in pairs(defaults.symbols.icons) do
				opts.symbols.icons[kind] = {
					icon = LazyVim.config.icons.kinds[kind] or symbol.icon,
					hl = symbol.hl,
				}
			end
			return opts
		end,
	},

	-- complete undo history
	{
		"mbbill/undotree",
		lazy = true,
		keys = { { "<leader>cu", "<cmd>UndotreeToggle<cr>", desc = "Toggle undotree" } },
	},

	-- search and replace cross project
	{
		"MagicDuck/grug-far.nvim",
		cmd = "GrupFar",
		keys = {
			{
				"<leader>sr",
				function()
					local gf = require("grug-far")
					local ext = vim.bo.buftopy == "" and vim.fn.expand("%:e")
					gf.open({
						transient = true,
						prefills = {
							filesFilter = ext and ext ~= "" and "*." .. ext or nil,
						},
					})
				end,
				mode = { "n", "v" },
				desc = "Search and Replace",
			},
		},
		opts = { headerMaxWidth = 80 },
	},

	-- jump to locations in a matter of keystrokes
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		-- stylua: ignore
		keys = {
			{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
		},
		opts = {},
	},

	-- improved diagnostics list etc
	{
		"folke/trouble.nvim",
		cmd = { "Trouble" },
		opts = { modes = { lsp = { win = { position = "right" } } } },
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
			{ "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
			{
				"[q",
				function()
					if require("trouble").is_open() then
						require("trouble").prev({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cprev)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Previous Trouble/Quickfix Item",
			},
			{
				"]q",
				function()
					if require("trouble").is_open() then
						require("trouble").next({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cnext)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Next Trouble/Quickfix Item",
			},
		},
	},
}
