(import-macros {: tx} :pix-fnl.macros)


[
	(tx "neovim/nvim-lspconfig"
		{:event "LazyFile"
		 :dependencies ["mason.nvim" "mason-org/mason-lspconfig.nvim"]
		 :opts {
		   :diagnostics {
				 :underline true
				 :update_in_insert false
				 :virtual_text {:spacing 4 :source "if_many"}
				 :severity_sort true
				 :signs {:text {
									vim.diagnostic.severity.ERROR LazyVim.config.icons.diagnostics.Error
									vim.diagnostic.severity.WARN  LazyVim.config.icons.diagnostics.Warn
									vim.diagnostic.severity.HINT  LazyVim.config.icons.diagnostics.Hint
									vim.diagnostic.severity.INFO  LazyVim.config.icons.diagnostics.Info}}}

			:inlay_hints {:enabled false }
			:codelens {:enabled true }
			:format {:formatting_options nil :timeout_ms nil}

			:servers {
				:capabilities {
					:workspace {
						:fileOperations {:didRename true :willRename true }}}

				;; bash language server
				:bashls {
					:cmd ["bash-language-server" "start"]
					:filetypes ["sh" "zsh" "bash"]
					:settings {:bashIde {:globPattern "*@(.sh|.inc|.bash|.command)"}}}

				;; c, c++, swift, etc language server
				:clangd {
					:cmd ["clangd"]
					:filetypes ["c" "h" "cpp" "hpp" "objc"]}

				;; fennel, fnl
				:fennel_language_server {
					:settings {:fennel {:diagnostics {:globals ["vim" "Snacks" "LazyVim"]}}}}

				;; go, gomod, gosum, gowork, gotmpl, go language server
				:gopls {
					:cmd ["gopls"]
					:filetypes ["go" "gomod" "gowork" "gotmpl"]
					:rootPatterns ["go.work" "go.mod" ".git"]
					:gofumpt true
					:settings {:analyses {:nilness true 
																:staticcheck true 
																:unusedparams true 
																:unusedread true 
																:useany true}
										 :codelenses {:gc_details true
										              :generate true
																	:regenerate_cgo true
																	:run_govulncheck true
																	:test true
																	:tidy true
																	:upgrade_dependency true
																	:vendor true}
										 :hints {:assignVariableTypes true
														 :compositeLiteralFields true
														 :compositeLiteralTypes true
														 :constantValues true
														 :functionTypeParameters true
														 :parameterNames true
														 :rangeVariableTypes true}
										 :usePlaceholders true
										 :completeUnimported true
										 :staticcheck true
										 :semanticTokens true
										 :directoryFilters [ "-.git" "-.vscode" "-.idea" "-.vscode-test" "-node_modules" "-.nvim" ]}}

				;; hyprland language server
				:hyprls {
					:cmd ["hyprls" "--stdio"]
					:filetypes ["hyprlang"]}

				;; json language server
				:jsonls {
					:on_new_config (fn [new_config]
													(set new_config.settings.json.schemas
															(or new_config.settings.json.schemas []))

													(let [schema-store (require :schemastore)]
														(vim.list_extend
															new_config.settings.json.schemas
															schema-store.json.schemas)))}

				;; lua language server
				:lua_ls {
					:settings {
						:Lua {
							:workspace {:checkThirdParty false}
							:codeLens {:enable false}
							:completion {:callSnipped "Replace"}
							:doc {:privateName [ "^_" ]}
							:hint {:enable true
							       :setType false 
										 :paramType true
										 :paramName "Disable"
										 :semicolon "Disable"
										 :arrayIndex "Disable"}
							:diagnostics {:globals ["vim" "Snacks" "LazyVim"]}}}}

				;; toml language server and formatting
				:taplo {
					:cmd ["taplo" "lsp" "stdio"]
					:filetypes ["toml"]
					:root_dir (let [util (require :lspconfig.util)] (util.root_pattern "*.toml" ".git"))}

				}}})




				


	;; attempted fix for gopls
	(tx "neovim/nvim-lspconfig"
  	{:setup
			{:gopls (fn [_ _]
					;; workaround for gopls not supporting semanticTokensProvider
					;; https://github.com/golang/go/issues/54531#issuecomment-1464982242
					(LazyVim.lsp.on_attach
						(fn [client _]
							(when (not client.server_capabilities.semanticTokensProvider)
								(let [semantic client.config.capabilities.textDocument.semanticTokens]
									(set client.server_capabilities.semanticTokensProvider
											{:full true
												:legend {:tokenTypes semantic.tokenTypes
																:tokenModifiers semantic.tokenModifiers}
												:range true}))))
						"gopls"))}})


	;; manage lsp installation and cli tools
	(tx "mason-org/mason.nvim"
		{:cmd "Mason"
		 :keys [[ "<leader>cm" "<cmd>Mason<cr>" {:desc "Mason"} ]]
		 :build ":MasonUpdate"
		 :opts_extend [ "ensure_installed" ]
		 :opts {:ensure_installed [
				"bash-language-server"
				"clangd"
				"codelldb"
				"delve"
				"fennel-language-server"
				"gofumpt"
				"goimports"
				"golangci-lint"
				"golangci-lint-langserver"
				"golines"
				"gomodifytags"
				"gopls"
				"hyprls"
				"impl"
				"json-lsp"
				"lua-language-server"
				"markdown-toc"
				"markdownlint-cli2"
				"marksman"
				"ruby-lsp"
				"shellcheck"
				"shfmt"
				"stylua"
				"taplo"
				"yaml-language-server"
				"zls"]}})

	;; none-ls integration for gomodifytags && impl
	(tx "nvimtools/none-ls.nvim"
		{:optional true
		 :dependencies [(tx "mason-org/mason.nvim"
			{:opts { :ensure_installed ["gomodifytags" "impl"]}})]})
]
