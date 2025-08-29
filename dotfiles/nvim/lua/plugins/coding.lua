-- coding.lua - all the configuration for coding related things, lsps, highlighting, linting, etc
--   TODO: turn parts of the config into seperate tables for easier management and oragnisation
--   instead of using files for everything.

local mason_conf = {
	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				"bash-language-server",
				"clangd",
				"delve",
				"gofumpt",
				"goimports",
				"golangci-lint",
				"golangci-lint-langserver",
				"golines",
				"gomodifytags",
				"gopls",
				"impl",
				"json-lsp",
				"lua-language-server",
				"shellcheck",
				"shfmt",
				"stylua",
				"taplo",
				"yaml-language-server",
				"zls",
			},
		},
	},
}
local lspconfig = {
	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = { enabled = false },
			servers = {
				bashls = {
					cmd = { "bash-language-server", "start" },
					filetypes = { "sh" },
					settings = {
						bashIde = {
							globPattern = "*@(.sh|.inc|.bash|.command)",
						},
					},
				},
				clangd = {
					cmd = { "clangd" },
					filetypes = { "c", "h", "cpp", "hpp" },
				},
				gopls = {
					cmd = { "gopls" },
					filetypes = { "go", "gomod", "gowork", "gotmpl" },
					rootPatterns = { "go.work", "go.mod", ".git" },
					gofumpt = true, -- Enable gofumpt formatting
					settings = {
						analyses = {
							unusedparams = true,
							nilness = true,
							unusedwrite = true,
							useany = true,
							-- staticcheck = true,
							-- st1003 = false,
						},
						codelenses = {
							gc_details = true,
							generate = true,
							regenerate_cgo = true,
							run_govulncheck = true,
							test = true,
							tidy = true,
							upgrade_dependency = true,
							vendor = true,
						},
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
						usePlaceholders = true,
						completeUnimported = true,
						staticcheck = true,
						directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules", "-.nvim" },
						semanticTokens = true,
					},
					setup = function(_, _)
						-- workaround for gopls not supporting semanticTokensProvider
						vim.lsp.on_attach(function(client, _)
							if not client.server_capabilities.semanticTokensProvider then
								local semantic = client.config.capabilities.textDocument.semanticTokens
								client.server_capabilities.semanticTokensProvider = {
									full = true,
									legend = {
										tokenTypes = semantic.tokenTypes,
										tokenModifiers = semantic.tokenModifiers,
									},
									range = true,
								}
							end
						end, "gopls")
						-- end workaround
					end,
				},
				hyprls = {
					cmd = { "hyprls", "--stdio" },
					filetypes = { "hyprlang" },
				},
				lua_ls = {
					settings = {
						-- Remove the missing 'vim' from neovim config files :>
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				},
				taplo = {
					cmd = { "taplo", "lsp", "stdio" },
					filetypes = { "toml" },
					root_dir = function(fname)
						return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
					end,
				},
				-- ols = {
				--   cmd = { "ols" },
				--   filetypes = { "odin" },
				--   rootPatterns = { "ols.json", ".git" },
				--   init_options = {
				--     enable_format = true,
				--     enable_hover = true,
				--     enable_document_symbols = true,
				--     -- enable_semantic_tokens = true, -- Don't want highlighting
				--     enable_inlay_hints = true,
				--     enable_snippets = false,
				--     enable_references = true,
				--     enable_rename = true,
				--     enable_label_details = true,
				--   },
				-- },
				-- omnisharp = {
				--   cmd = { "omnisharp" },
				--   enable_editorconfig_support = true,
				--   enable_ms_build_load_projects_on_demand = false,
				--   -- Enables support for roslyn analyzers, code fixes and rulesets.
				--   enable_roslyn_analyzers = true,
				--   organize_imports_on_format = true,
				--   enable_import_completion = true,
				--   sdk_include_prereleases = true,
				--   analyze_open_documents_only = false,
				--   filetypes = { "cs", "vb" },
				--   init_options = {},
				--   rootPatterns = { "*.sln", "*.csproj", "omnisharp.json", "function.json" },
				--   -- For go-to-definition functionality and decompliatino you require omnisharp-extended.
				--   handlers = {
				--     ["textDocument/definition"] = function(...)
				--       return require("omnisharp_extended").handler(...)
				--     end,
				--   },
				--   keys = {
				--     {
				--       "gd",
				--       function()
				--         require("omnisharp_extended").telescope_lsp_definitions()
				--       end,
				--       desc = "Goto Definition",
				--     },
				--   },
				-- },
				-- sourcekit = {
				--   cmd = { "sourcekit-lsp" },
				--   filetypes = { "swift" },
				--   rootPatterns = { "compile_commands.json", "Package.swift", ".git" },
				--   opts = {
				--     capabilities = {
				--       workspace = {
				--         didChangeWatchedFiles = {
				--           dynamicRegistration = true,
				--         },
				--       },
				--     },
				--   },
				-- },
				zls = {
					cmd = { "zls" },
					filetypes = { "zig" },
					single_file_support = true,
				},
			},
		},
	},
}

return {
	mason_conf,
	lspconfig,
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
	--  --  To make omnisharp not trash
	--  { "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },
	{
		"stevearc/conform.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		lazy = true,
		cmd = "ConformInfo",
		keys = {
			-- Leader, Code, Format
			{
				"<leader>cF",
				mode = { "n", "v" },
				function()
					require("conform").format({ formatters = { "injected" } })
				end,
				desc = "Format injected languages from lsp",
			},
		},
		opts = {
			default_format_opts = {
				timeout_ms = 5000,
				async = false,
				quiet = false,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "goimports", "gofumpt" },
				fish = { "fish_indent" },
				sh = { "shfmt" },
				c = { "clang-format" },
				zig = { "zigfmt" },
				-- toml = { "taplo" },
				-- odin = { "odinfmt" },
				-- swift = { "swift_format" },
			},
			formatters = {
				injected = { options = { ignore_errors = true } },
				-- -- Formatting for Swift since nothing built in x(
				-- swift_format = {
				--   command = "swift-format",
				--   args = { "--configuration", "/Users/pix/.config/formatting/swift-config.json" },
				--   stdin = true,
				-- },
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
				disable = { "odin" },
			},
			matchup = {
				enable = true,
				enable_quotes = true,
			},
			incremental_selection = { enable = true },
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
			},
			ensure_installed = {
				"bash",
				"c",
				"fish",
				"go",
				"gomod",
				"gowork",
				"gosum",
				"ini",
				"lua",
				"markdown",
				"nix",
				"tmux",
				"zig",
			},
		},
	},
	{
		"luckasRanarison/tree-sitter-hyprlang",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	-- fix for supremaven and blink fighting for text.
	-- will not preselect the first option unless you manually select
	-- while still allowing for preview, enter selection and inesrting as normal
	{
		"Saghen/blink.cmp",
		opts = {
			completion = {
				list = {
					selection = {
						preselect = false,
					},
				},
			},
		},
	},
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- Optional dependencies
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
	},
	{
		"nvim-neotest/neotest",
		optional = true,
		dependencies = {
			"fredrikaverpil/neotest-golang",
		},
		opts = {
			adapters = {
				["neotest-golang"] = {
					-- Here we can set options for neotest-golang, e.g.
					-- go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
					dap_go_enabled = true, -- requires leoluz/nvim-dap-go
				},
			},
		},
	},
	{
		"mfussenegger/nvim-dap",
		optional = true,
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
	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({
				-- keymaps = {
				-- 	accept_suggestion = "<S-Tab>",
				-- 	clear_suggestion = "<C-]>",
				-- },
			})

			-- 	keymaps = {
			-- 		accept_suggestion = "<Tab>",
			-- 		clear_suggestion = "<C-]>",
			-- 		accept_word = "<C-j>",
			-- 	},
			-- 	-- log_level = "off",
			-- })
		end,
	},

	-- TODO: can I make this work with conform or nvim-lint?
	-- {
	-- 	"nvimtools/none-ls.nvim",
	-- 	opts = function(_, opts)
	-- 		local nls = require("null-ls")
	-- 		opts.sources = vim.list_extend(opts.sources or {}, {
	-- 			-- this relies on goimports, gofumpt, gomodifytags and impl installed from mason.
	-- 			nls.builtins.code_actions.gomodifytags,
	-- 			nls.builtins.code_actions.impl,
	-- 			nls.builtins.formatting.goimports,
	-- 			nls.builtins.formatting.gofumpt,
	-- 		})
	-- 	end,
	-- },
}

-- {
-- 	"mfussenegger/nvim-lint",
-- 	opts = {
-- 		events = { "BufWritePost", "BufReadPost", "InsertLeave" },
-- 		-- linters = {
-- 		-- 	golangcilint = {
-- 		-- 		exe = "golangcilint",
-- 		-- 		cmd = "golangci-lint --config " .. os.getenv("HOME") .. "/config/formatting/golangci.yml",
-- 		-- 		args = {},
-- 		-- 		stdin = true,
-- 		-- 		to_stdin = true,
-- 		-- 		format = "line",
-- 		-- 		offset = 0,
-- 		-- 		check_exit_code = 1,
-- 		-- 		--env = {},
-- 		-- 		--on_output = function(output, exit_code)
-- 		-- 		--    print(output)
-- 		-- 		--end,
-- 		-- 	},
-- 		-- },
-- 	},
-- },

-- if true then
-- 	return {}
-- end

-- Use <tab> for completion and snippets (supertab)
-- first: disable default <tab> and <s-tab> behavior in LuaSnip

-- local function border(hl_name)
-- 	return {
-- 		{ "╭", hl_name },
-- 		{ "─", hl_name },
-- 		{ "╮", hl_name },
-- 		{ "│", hl_name },
-- 		{ "╯", hl_name },
-- 		{ "─", hl_name },
-- 		{ "╰", hl_name },
-- 		{ "│", hl_name },
-- 	}
-- end

-- return {
-- {
-- 	"L3MON4D3/LuaSnip",
-- 	keys = function()
-- 		return {}
-- 	end,
-- },
-- then: setup supertab in cmp
-- {
-- 	"hrsh7th/nvim-cmp",
-- 	dependencies = {
-- 		"hrsh7th/cmp-emoji",
-- 	},
--
-- 	--    ---@param opts cmp.ConfigSchema
-- 	opts = function(_, opts)
-- 		local has_words_before = function()
-- 			unpack = unpack or table.unpack
-- 			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
-- 			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- 		end
--
-- 		local luasnip = require("luasnip")
-- 		local cmp = require("cmp")
--
-- 		opts.mapping = vim.tbl_extend("force", opts.mapping, {
-- 			["<Tab>"] = cmp.mapping(function(fallback)
-- 				if cmp.visible() then
-- 					cmp.select_next_item()
-- 				-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
-- 				-- this way you will only jump inside the snippet region
-- 				elseif luasnip.expand_or_locally_jumpable() then
-- 					luasnip.expand_or_jump()
-- 				-- Not sure why, but need to take this out for it to work..
-- 				elseif has_words_before() then
-- 					cmp.complete()
-- 				else
-- 					fallback()
-- 				end
-- 			end, { "i", "s" }),
-- 			["<S-Tab>"] = cmp.mapping(function(fallback)
-- 				if cmp.visible() then
-- 					cmp.select_prev_item()
-- 				elseif luasnip.jumpable(-1) then
-- 					luasnip.jump(-1)
-- 				else
-- 					fallback()
-- 				end
-- 			end, { "i", "s" }),
-- 		})
--
-- 		-- opts.window = {
-- 		--   completion = cmp.config.window.bordered(),
-- 		--   documentation = cmp.config.window.bordered(),
-- 		-- }
--
-- 		opts.window = {
-- 			completion = {
-- 				side_padding = 1,
-- 				-- winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
-- 				scrollbar = false,
-- 				border = border("CmpBorder"),
-- 			},
-- 			documentation = {
-- 				border = border("CmpDocBorder"),
-- 				winhighlight = "Normal:CmpDoc",
-- 			},
-- 		}
--
-- 		opts.sorting = {
-- 			comparators = {
-- 				cmp.config.compare.offset,
-- 				cmp.config.compare.exact,
-- 				cmp.config.compare.sort_text,
-- 				cmp.config.compare.score,
-- 				-- require("cmp-under-comparator").under,
-- 				cmp.config.compare.recently_used,
-- 				cmp.config.compare.kind,
-- 				cmp.config.compare.length,
-- 				cmp.config.compare.order,
-- 			},
-- 		}
-- 	end,
-- },
-- }
