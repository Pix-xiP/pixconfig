-- lsp.lua - lsp config, management and installation

return {

	{
		"neovim/nvim-lspconfig",
		event = "LazyFile",
		dependencies = {
			"mason.nvim",
			{ "mason-org/mason-lspconfig.nvim", config = function() end },
		},
		opts = {
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					-- prefix = "●",
					-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
					-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
					-- prefix = "icons",
				},
				serverity_sort = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
						[vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
						[vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
						[vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
					},
				},
			},

			inlay_hints = { enabled = false }, -- turn off the inlay hints.
			codelens = { enabled = true },
			capabilities = {
				workspace = {
					fileOperations = {
						didRename = true,
						willRename = true,
					},
				},
			},
			-- options for vim.lsp.buf.format
			-- when using LazyVim 'bufnr' and 'filter' are handled by LazyVim formatter
			format = {
				formatting_options = nil,
				timeout_ms = nil,
			},

			-- lsp servers to setup!
			servers = {

				-- bash
				bashls = {
					cmd = { "bash-language-server", "start" },
					filetypes = { "sh" },
					settings = {
						bashIde = {
							globPattern = "*@(.sh|.inc|.bash|.command)",
						},
					},
				},

				-- c, c++, swift, etc
				clangd = {
					cmd = { "clangd" },
					filetypes = { "c", "h", "cpp", "hpp" },
				},

				-- go, gomod, gosum, gowork, gotmpl
				gopls = {
					cmd = { "gopls" },
					filetypes = { "go", "gomod", "gowork", "gotmpl" },
					rootPatterns = { "go.work", "go.mod", ".git" },
					gofumpt = true, -- enable gofumpt formatting
					settings = {
						analyes = {
							nilness = true,
							staticcheck = true,
							unusedparams = true,
							unusedread = true,
							useany = true,
						},
						codelenses = {
							gc_details = true,
							generate = true,
							regenerate_cgo = true,
							run_govulncheck = true,
							test = true,
							tidy = true,
							upgrade_depeendency = true,
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
				},

				-- hyprland language server
				hyprls = {
					cmd = { "hyprls", "--stdio" },
					filetypes = { "hyprlang" },
				},

				-- json language server
				jsonls = {
					-- lazy-load schemastore when needed
					on_new_config = function(new_config)
						new_config.settings.json.schemas = new_config.settings.json.schemas or {}
						vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
					end,
					settings = {
						json = {
							format = { enable = true },
							validate = { enabled = true },
						},
					},
				},

				-- lua language server
				lua_ls = {
					settings = {
						-- Remove the missing 'vim' from neovim config files :>
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							codeLens = {
								enable = false,
							},
							completion = {
								callSnipped = "Replace",
							},
							doc = {
								privateName = { "^_" },
							},
							hint = {
								enable = true,
								setType = false,
								paramType = true,
								paramName = "Disable",
								semicolon = "Disable",
								arrayIndex = "Disable",
							},
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				},

				-- toml language server and formatting
				taplo = {
					cmd = { "taplo", "lsp", "stdio" },
					filetypes = { "toml" },
					root_dir = function(fname)
						return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
					end,
				},

				-- -- Odin Language Server
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

				-- -- C# language server
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

				-- -- Swift language servers
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

				-- zig language server
				zls = {
					cmd = { "zls" },
					filetypes = { "zig" },
					single_file_support = true,
				},
			},
		},
	},

	-- attempted fix for gopls
	{
		"neovim/nvim-lspconfig",
		setup = {
			gopls = function(_, opts)
				-- workaround for gopls not supporting semanticTokensProvider
				-- https://github.com/golang/go/issues/54531#issuecomment-1464982242
				LazyVim.lsp.on_attach(function(client, _)
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
	},

	-- manage lsp installation and cli tools
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts_extend = { "ensure_installed" },

		opts = {
			ensure_installed = {
				"bash-language-server",
				"clangd",
				"codelldb",
				"delve",
				"gofumpt",
				"goimports",
				"golangci-lint",
				"golangci-lint-langserver",
				"golines",
				"gomodifytags",
				"gopls",
				"hyprls",
				"impl",
				"json-lsp",
				"lua-language-server",
				"markdown-toc",
				"markdownlint-cli2",
				"marksman",
				"nil",
				"shellcheck",
				"shfmt",
				"stylua",
				"taplo",
				"yaml-language-server",
				"zls",
			},
		},
	},

	-- none-ls integration for gomodifytags && impl
	{
		"nvimtools/none-ls.nvim",
		optional = true,
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = { ensure_installed = { "gomodifytags", "impl" } },
			},
		},
		opts = function(_, opts)
			local nls = require("null-ls")
			opts.sources = vim.list_extend(opts.sources or {}, {
				nls.builtins.code_actions.gomodifytags,
				nls.builtins.code_actions.impl,
				nls.builtins.formatting.goimports,
				nls.builtins.formatting.gofumpt,
			})
		end,
	},

	-- LazyVim currently pins to this mason version due to a problem with
	-- lazy.nvim and mason having upgraded recently to 2.0 - will adjust later.
	-- { "mason-org/mason.nvim", version = "^1.0.0" },
	-- { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
}
