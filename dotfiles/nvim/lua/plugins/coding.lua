-- coding.lua - All the config for coding
-- TODO: split up language specifics into their own file for ease of management.

return {

	-- completion
	{
		"saghen/blink.cmp",
		version = not vim.g.lazyvim_blink_main and "*",
		build = vim.g.lazyvim_blink_main and "cargo build --release",
		opts_extend = {
			"sources.completion.enabled_providers",
			"sources.compat",
			"sources.default",
		},
		event = { "InsertEnter", "CmdlineEnter" },
		opts = {

			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono",
			},

			completion = {
				accept = {
					-- experiental autobrackets support
					auto_brackets = { enabled = true },
				},
				list = {
					selection = {
						preselect = false,
					},
				},
				menu = {
					draw = {
						treesitter = { "lsp" },
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
				},
				ghost_text = {
					enabled = vim.g.ai_cmp,
				},
			},

			sources = {
				compat = {}, -- set by the part under supermaven for when thats on
				default = { "lsp", "path", "snippets", "buffer" },
			},

			cmdline = { enabled = false },

			keymap = {
				preset = "enter",
				["C-y"] = { "select_and_accept" },
			},
		},

		---@param opts blink.cmp.Config | { sources: { compat: string[] } }
		config = function(_, opts)
			-- setup compat sources
			local enabled = opts.sources.default
			for _, source in ipairs(opts.sources.compat or {}) do
				opts.sources.providers[source] = vim.tbl_deep_extend(
					"force",
					{ name = source, module = "blink.compat.source" },
					opts.sources.providers[source] or {}
				)
				if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
					table.insert(enabled, source)
				end
			end

			-- add ai_accept to <Tab> key
			if not opts.keymap["<Tab>"] then
				if opts.keymap.preset == "super-tab" then -- super-tab
					opts.keymap["<Tab>"] = {
						require("blink.cmp.keymap.presets")["super-tab"]["<Tab>"][1],
						LazyVim.cmp.map({ "snippet_forward", "ai_accept" }), -- TODO: figure out how to map to own keymaps.
						"fallback",
					}
				else -- other presets
					opts.keymap["<Tab>"] = {
						LazyVim.cmp.map({ "snipper_forward", "ai_accept" }),
						"fallback",
					}
				end
			end

			-- unset custom prop to pass blink.cmp validation
			opts.sources.compat = nil

			-- check if we need to override symbol kinds
			for _, provider in pairs(opts.sources.providers or {}) do
				---@cast provider blink.cmp.SourceProviderConfig|{kind?:string}
				if provider.kind then
					local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
					local kind_idx = #CompletionItemKind + 1

					CompletionItemKind[kind_idx] = provider.kind
					---@diagnostic disable-next-line: no-unknown
					CompletionItemKind[provider.kind] = kind_idx

					---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[]): blink.cmp.CompletionItem[]
					local transform_items = provider.transform_items
					---@param ctx blink.cmp.Context
					---@param items blink.cmp.CompletionItem[]
					provider.transform_items = function(ctx, items)
						items = transform_items and transform_items(ctx, items) or items
						for _, item in ipairs(items) do
							item.kind = kind_idx or item.kind
							item.kind_icon = LazyVim.config.icons.kinds[item.kind_name] or item.kind_icon or nil
						end
						return items
					end

					-- unset custom prop to pass blink.cmp validation
					provider.kind = nil
				end
			end

			require("blink.cmp").setup(opts)
		end,
	},

	-- add lazydev to blink completion
	{
		"saghen/blink.cmp",
		opts = {
			sources = {
				default = { "lazydev" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
		},
	},

	-- add icons to blink
	{
		"saghen/blink.cmp",
		opts = function(_, opts)
			opts.appearance = opts.appearance or {}
			opts.appearance.kind_icons = vim.tbl_extend("force", opts.appearance.kind_icons or {}, LazyVim.config.icons.kinds)
		end,
	},

	-- -- auto pairs
	-- {
	-- 	"nvim-mini/mini.pairs",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		modes = { insert = true, command = true, terminal = false },
	-- 		-- skip autopair when next character is one of these
	-- 		skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
	-- 		-- skip autopair when the cursor is inside these treesitter nodes
	-- 		skip_ts = { "string" },
	-- 		-- skip autopair when next character is closing pair
	-- 		-- and there are more closing pairs than opening pairs
	-- 		skip_unbalanced = true,
	-- 		-- better deal with markdown code blocks
	-- 		markdown = true,
	-- 	},
	-- },

	-- comments!
	{
		"folke/ts-comments.nvim",
		event = "VeryLazy",
		opts = {},
	},

	-- quick add and delete surroundings
	{
		"nvim-mini/mini.surround",
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

			keys = {
				{ "gz", "", desc = "+surround" },
			},
		},
	},

	-- better text-objects
	{
		"nvim-mini/mini.ai",
		event = "VeryLazy",
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({ -- code block
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
					t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
					d = { "%f[%d]%d+" }, -- digits
					e = { -- Word with case
						{ "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
						"^().*()$",
					},
					g = LazyVim.mini.ai_buffer, -- buffer
					u = ai.gen_spec.function_call(), -- u for "Usage"
					U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
				},
			}
		end,
	},

	-- lazydev for plugin dev
	{
		"folke/lazydev.nvim",
		ft = "lua",
		cmd = "LazyDev",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "LazyVim", words = { "LazyVim" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
				{ path = "lazy.nvim", words = { "LazyVim" } },
			},
		},
	},

	vim.g.ai_cmp and {
		"saghen/blink.cmp",
		optional = true,
		dependencies = { "supermaven-nvim", "saghen/blink.compat" },
		opts = {
			sources = {
				compat = { "supermaven" },
				providers = {
					supermaven = {
						kind = "Supermaven",
						score_offset = 100,
						async = true,
					},
				},
			},
		},
	} or nil,

	-- ai improved autocomplete
	{
		"supermaven-inc/supermaven-nvim",
		event = "InsertEnter",
		cmd = {
			"SupermavenUseFree",
			"SupermavenUsePro",
		},
		config = function()
			require("supermaven-nvim").setup({})
		end,
		opts = {
			keymaps = {
				accept_suggestion = nil,
			},
			disable_inline_completion = vim.g.ai_cmp,
			ignore_filetypes = { "bigfile", "snacks_input", "snacks_input" },
		},
	},

	{
		"folke/noice.nvim",
		optional = true,
		opts = function(_, opts)
			vim.list_extend(opts.routes, {
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "Starting Supermaven" },
							{ find = "Supermaven Free Tier" },
						},
					},
				},
			})
		end,
	},

	-- json extras
	{
		"b0o/SchemaStore",
		lazy = true,
		version = false,
	},

	-- refactoring in place from Primeagen
	{
		"ThePrimeagen/refactoring.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			{ "<leader>r", "", desc = "+refactor", mode = { "n", "v" } },
			{
				"<leader>rs",
				function()
					require("refactoring").select_refactor()
				end,
				-- pick,
				mode = "v",
				desc = "Refactor",
			},
			{
				"<leader>ri",
				function()
					require("refactoring").refactor("Inline Variable")
				end,
				mode = { "n", "v" },
				desc = "Inline Variable",
			},
			{
				"<leader>rb",
				function()
					require("refactoring").refactor("Extract Block")
				end,
				desc = "Extract Block",
			},
			{
				"<leader>rf",
				function()
					require("refactoring").refactor("Extract Block To File")
				end,
				desc = "Extract Block To File",
			},
			{
				"<leader>rP",
				function()
					require("refactoring").debug.printf({ below = false })
				end,
				desc = "Debug Print",
			},
			{
				"<leader>rp",
				function()
					require("refactoring").debug.print_var({ normal = true })
				end,
				desc = "Debug Print Variable",
			},
			{
				"<leader>rc",
				function()
					require("refactoring").debug.cleanup({})
				end,
				desc = "Debug Cleanup",
			},
			{
				"<leader>rf",
				function()
					require("refactoring").refactor("Extract Function")
				end,
				mode = "v",
				desc = "Extract Function",
			},
			{
				"<leader>rF",
				function()
					require("refactoring").refactor("Extract Function To File")
				end,
				mode = "v",
				desc = "Extract Function To File",
			},
			{
				"<leader>rx",
				function()
					require("refactoring").refactor("Extract Variable")
				end,
				mode = "v",
				desc = "Extract Variable",
			},
			{
				"<leader>rp",
				function()
					require("refactoring").debug.print_var()
				end,
				mode = "v",
				desc = "Debug Print Variable",
			},
		},
		opts = {
			prompt_func_return_type = {
				go = false,
				java = false,
				cpp = false,
				c = false,
				h = false,
				hpp = false,
				cxx = false,
			},
			prompt_func_param_type = {
				go = false,
				java = false,
				cpp = false,
				c = false,
				h = false,
				hpp = false,
				cxx = false,
			},
			printf_statements = {},
			print_var_statements = {},
			show_success_message = true, -- shows a message with information about the refactor on success
			-- i.e. [Refactor] Inlined 3 variable occurrences
		},
	},

	-- nvim debug adapter
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = { ensure_installed = { "delve" } },
			},
			{
				"leoluz/nvim-dap-go",
				opts = {},
			},
		},
	},

	-- neo test for various languages
	{
		"nvim-neotest/neotest",
		dependencies = {
			-- required for neotest.
			{ "nvim-neotest/nvim-nio" },
			-- zig
			{ "lawrence-laz/neotest-zig" },
			-- go
			{ "fredrikaverpil/neotest-golang" },
		},
		opts = {
			adapters = {
				["neotest-zig"] = {},
				["neotest-golang"] = {
					-- Here we can set options for neotest-golang, e.g.
					-- go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
					dap_go_enabled = true,
				},
			},
		},
	},

	-- compile mode builtin to neovim
	{
		"ej-shafran/compile-mode.nvim",
		lazy = true,
		branch = "latest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "m00qek/baleia.nvim", tag = "v1.3.0" },
		},
		config = function()
			vim.g.compile_mode = {
				baleia_setup = true,
				default_command = "",
				error_threshold = require("compile-mode").level.INFO,
				recompile_no_fail = true,
			}
		end,
	},

	-- markdown table mode for auto formatting
	{
		"Kicamon/markdown-table-mode.nvim",
		opts = {
			insert = true,
			insert_leave = true,
		},
	},

	-- go autotests
	{
		"yanskun/gotests.nvim",
		ft = "go",
		config = function()
			require("gotests").setup()
		end,
	},

	-- godoc
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
							layout = "vertical",
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
