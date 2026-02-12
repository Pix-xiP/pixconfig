-- ui.lua - everything that affects the viewing experience of the editor
if true then
	return {}
end

return {
	-- my theme <3
	{
		"umbral",
		name = "umbral",
		dir = "~/AdeptusCustodes/Lunar/nvim_plugins/umbral.nvim",
		dev = true,
		config = function()
			vim.cmd.colorscheme("umbral")
		end,
	},

	-- tabs / buffers along the top
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
			{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
			{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
			{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
			{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
			{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
			{ "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
			{ "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
		},
		opts = {
			options = {
        -- stylua: ignore
				close_command = function(n) Snacks.bufdelete(n) end,
        -- stylua: ignore
        right_mouse_command = function(n) Snacks.bufdelete(n) end,
				diagnostics = "nvim_lsp",
				always_show_bufferline = false,
				diagnostics_indicator = function(_, _, diag)
					local icons = LazyVim.config.icons.diagnostics
					local ret = (diag.error and icons.Error .. diag.error .. " " or "")
						.. (diag.warning and icons.Warn .. diag.warning or "")
					return vim.trim(ret)
				end,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
					{
						filetype = "snacks_layout_box",
					},
				},
				---@param opts bufferline.IconFetcherOpts
				get_element_icon = function(opts)
					return LazyVim.config.icons.ft[opts.filetype]
				end,
			},
		},
		config = function(_, opts)
			require("bufferline").setup(opts)
			-- Fix bufferline when restoring a session
			vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
				callback = function()
					vim.schedule(function()
						pcall(nvim_bufferline)
					end)
				end,
			})
		end,
	},

	-- dashboard for when you just run 'nvim'
	{
		"folke/snacks.nvim",
		---@type snacks.Config
		opts = {
			dashboard = {
				preset = {
					header = [[
	      ██████╗ ██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗
	      ██╔══██╗██║╚██╗██╔╝██║   ██║██║████╗ ████║
	      ██████╔╝██║ ╚███╔╝ ██║   ██║██║██╔████╔██║
	      ██╔═══╝ ██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║
	      ██║     ██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
	      ╚═╝     ╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
	        ]],
				},
				sections = {
					{ section = "header" },
					{ section = "startup" },
					{
						{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
						{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
						{ icon = " ", key = "/", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
						{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
						-- stylua: ignore
						{ icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})", },
						{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
				},
			},
		},
	},

	-- rest of the snacks QoL inclusions
	{
		"folke/snacks.nvim",
		opts = {
			bigfile = { -- configurations for largefiles
				notify = true, -- tell me it YUUUGE
				size = 1024 * 1024 * 1.5, -- 1.5MB -- also set in options.lua
				line_length = 1000,
			},
			dim = { enabled = false }, -- don't want to dim based on scope
			explorer = { enabled = false }, -- replaced with 'oil.nvim'
			indent = { -- the bar that appears between { } to show scope and indentation.
				enabled = true,
				only_current = false, -- show in all buffers
				animate = { enabled = false }, -- instant instead of growing.
			},
			input = { enabled = true },
			lazygit = { enabled = true, configure = true },
			notifier = { enabled = true, timeout = 3000 },
			picker = { enabled = true },
			profiler = {
				enabled = true,
				opts = function()
					Snacks.toggle.profiler():map("<leader>pp")
					Snacks.toggle.profiler():map("<leader>ph")
				end,
				-- stylua: ignore
				keys = { { "<leader>ps", function() Snacks.profiler.scratch() end, desc = "Profiler scratch buffer" }, },
			},
			rename = { enabled = true }, -- global rename, grug-far|fastmod replace?
			scroll = { enabled = false }, -- disable smooth scroll
			statuscolumn = { enabled = true }, -- icons next to numerso
			terminal = { enabled = false }, -- just split ghostty/zellij
			words = {
				enabled = true,
				debounce = 200,
				notify_jump = false,
				notify_end = true,
				foldopen = true,
				jumplist = true,
				mode = { "n", "i", "c" },
				filter = function(buf) -- what bufferes to enabled on
					return vim.g.snacks_words ~= false and vim.b[buf].snacks_words ~= false
				end,
			},
		},
		-- stylua: ignore
		keys = {
			-- picker commands
			{ "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
			{ "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
			{ "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
			{ "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
			-- { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
			-- find commands 
			{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
			{ "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
			{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
			{ "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
			{ "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
			{ "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
			-- git commands
			{ "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
			{ "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
			{ "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
			{ "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
			{ "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
			{ "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
			{ "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
			-- search commands 
			{ '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
			{ '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
			{ "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
			{ "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
			{ "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
			{ "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
			{ "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
			{ "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
			{ "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
			{ "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
			{ "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
			{ "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
			{ "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
			{ "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
			{ "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
			{ "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
			{ "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
			{ "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
			{ "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
			{ "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
			{ "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
			-- lsp comamnds
			{ "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
			{ "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
			{ "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
			{ "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
			{ "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
			{ "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
			{ "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
			-- bonus commands
			{ "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
			{ "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
			{ "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
			{ "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
			{ "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
		},
	},

	-- lualine component to show profilered captured events from snacks.
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			table.insert(opts.sections.lualine_x, Snacks.profiler.status())
		end,
	},

	-- Folke's replacement UI for everything loosk gewd
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
						},
					},
					view = "mini",
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
			},
		},
    -- stylua: ignore
    keys = {
      { "<leader>sn", "", desc = "+noice"},
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
      { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
    },
		config = function(_, opts)
			if vim.o.filetype == "lazy" then
				vim.cmd([[messages clear]])
			end
			require("noice").setup(opts)
		end,
	},

	-- lualine status bar
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		init = function()
			vim.g.lualine_laststatus = vim.o.laststatus
			if vim.fn.argc(-1) > 0 then
				-- set an empty statusline till lualine loads
				vim.o.statusline = " "
			else
				-- hide the status line on the dashbaord
				vim.o.laststatus = 0
			end
		end,
		opts = function()
			local lualine_require = require("lualine_require")
			lualine_require.require = require

			local icons = LazyVim.config.icons
			vim.o.laststatus = vim.g.lualine_laststatus

			local opts = {
				options = {
					theme = "auto",
					globalstatus = vim.o.laststatus == 3,
					disabled_filetypes = { statusline = { "dashboard", "snacks_dashboard", "ministarter" } },
				},
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
					lualine_b = { "branch" },
					lualine_c = {
						LazyVim.lualine.root_dir(),
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
						},
						{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						{ LazyVim.lualine.pretty_path() },
					},
					lualine_x = {
						Snacks.profiler.status(),
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = function() return { fg = Snacks.util.color("Statement") } end,
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = function() return { fg = Snacks.util.color("Constant") } end,
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = function() return { fg = Snacks.util.color("Debug") } end,
            },
            -- stylua: ignore
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = function() return { fg = Snacks.util.color("Special") } end,
            },
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
							source = function()
								local gitsigns = vim.b.gitsigns_status_dict
								if gitsigns then
									return {
										added = gitsigns.added,
										modified = gitsigns.changed,
										removed = gitsigns.removed,
									}
								end
							end,
						},
					},
					lualine_y = {
						{ "progress", seperator = " ", padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 0, right = 1 } },
					},
					lualine_z = {
						function()
							return " " .. os.date("%R")
						end,
					},
				},
				extensions = { "neo-tree", "lazy", "fzf" },
			}

			-- do not add trouble symbols if aerial is enabled
			-- And allow it to be overriden for some buffer types (see autocmds)
			if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
				local trouble = require("trouble")
				local symbols = trouble.statusline({
					mode = "symbols",
					groups = {},
					title = false,
					filter = { range = true },
					format = "{kind_icon}{symbol.name:Normal}",
					hl_group = "lualine_c_normal",
				})
				table.insert(opts.sections.lualine_c, {
					symbols and symbols.get,
					cond = function()
						return vim.b.trouble_lualine ~= false and symbols.has()
					end,
				})
			end

			return opts
		end,
	},

	-- icons!
	{
		"nvim-mini/mini.icons",
		lazy = true,
		opts = {
			file = {
				[".go-version"] = { glyph = "", hl = "MiniIconsBlue" },
				[".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
				["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
			},
			filetype = {
				dotenv = { glyph = "", hl = "MiniIconsYellow" },
				gotmpl = { glyph = "󰟓", hl = "MiniIconsGrey" },
			},
		},
	},

	-- ui framework
	{ "MunifTanjim/nui.nvim", lazy = true },

	-- key preview for various commands
	{
		"folke/which-key.nvim",
		opts = {
			plugins = { spelling = true },
			spec = {
				mode = { "n", "v" },
				{ "<leader>p", group = "pix", icon = "Px" }, -- add my own commands underneath leader-p
			},
		},
	},

	-- todo comment highlighting extended to include my own
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "TodoTrouble", "TodoTelesecope" },
		event = "LazyFile",
		opts = {
			colors = {
				error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
				warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
				info = { "DiagnosticInfo", "#2563EB" },
				hint = { "DiagnosticHint", "#10B981" },
				default = { "Identifier", "#7C3AED" },
				test = { "Identifier", "#FF00FF" },
				pix_todo = { "#3e8fb0" },
				pix_note = { "#c4a7e7" },
				pix_hack = { "#eb6f92" },
				pix_improve = { "#ea9d34" },
			},
			keywords = {
				PIXNOTE = { icon = "", color = "pix_note", alt = { "THOUGHT" } },
				PIXHACK = { icon = "", color = "pix_hack", alt = { "HACKFIX" } },
				PIXTODO = { icon = "", color = "pix_todo", alt = { "PIXTODO" } },
				IMPROVEMENT = { icon = "󰟶", color = "pix_improve", alt = { "IMPROVE", "IDEA", "IMPROV" } },
				-- Preview:
				-- PIXTODO:     Sphinx of Black Quartz, Judge my Vow
				-- TODO:        Sphinx of Black Quartz, Judge my Vow
				-- IMPROVEMENT: Sphinx of Black Quartz, Judge my Vow
				-- IDEA:        Sphinx of Black Quartz, Judge my Vow
				-- IMPROV:      Sphinx of Black Quartz, Judge my Vow
				-- PIXHACK:     Sphinx of Black Quartz, Judge my Vow
				-- HACKFIX:     Sphinx of Black Quartz, Judge my Vow
				-- THOUGHT:     Sphinx of Black Quartz, Judge my Vow
				-- PIXNOTE:     Sphinx of Black Quartz, Judge my Vow
				-- NOTE:        Sphinx of Black Quartz, Judge my Vow
				-- HACK:        Sphinx of Black Quartz, Judge my Vow
				-- WARN:        Sphinx of Black Quartz, Judge my Vow
				-- FIXME:       Sphinx of Black Quartz, Judge my Vow
			},
			--stylua: ignore
			keys = {
				{ "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
				{ "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
				{ "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
				{ "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
				{ "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
				{ "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
			},
		},
	},

	-- highlight patterns
	{ "nvim-mini/mini.hipatterns", version = false },

	-- highlight hex codes and colours in neovim!
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
}
