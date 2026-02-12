if true then
	return {}
end
return {
	-- ensure we have mason
	{ "mason-org/mason.nvim" },

	-- Ensure we have some lsp's
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			automatic_enable = true,
			ensure_installed = {
				"bashls",
				"clangd",
				"fennel_language_server",
				"golangci_lint_ls",
				"gopls",
				"lua_ls",
				"ruby_lsp",
				"stylua",
				"taplo",
				"zls",
			},
		},
	},

	-- Setup lintrs?
	-- "shellcheck",
	-- "golangci_lint",
	-- Setup formatters?
	-- "gofumpt",
	-- "goimports",
	-- "shfmt",
	-- "tree-sitter-cli",
	-- "golines",
}
