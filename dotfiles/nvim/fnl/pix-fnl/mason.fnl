; (import-macros {: tx} :pix-fnl.macros)
;
; [
;  ;; mason for insalling
;  (tx "mason-org/mason.nvim")
;  ;; mason-lspconfig for lsp auto install
;  (tx "mason-org/mason-lspconfig.nvim"
; 	{ :dependencies [ "mason-org/mason.nvim" "neovim/nvim-lspconfig" ]
; 		:opts {
; 			:automatic_enable true
; 			:ensure_installed [
; 				"bashls"
; 				"clangd"
; 				"fennel_language_server"
; 				"golangci_lint_ls"
; 				"gopls"
; 				"lua_ls"
; 				"ruby_lsp"
; 				"stylua"
; 				"taplo"
; 				"zls"
; 			] }})
;  ;; TODO: linters, formatters
; ]
{}
