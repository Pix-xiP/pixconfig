(import-macros {: tx : keymap} :pix-fnl.core.macros)

[
 	;; conform formatter
	(tx "stevearc/conform.nvim"
		{:dependencies ["mason.nvim"]
		 :lazy true
		 :cmd "ConformInfo"
		 :keys [
				(keymap "<leader>cF" (fn [] 
															 (let [conform (require :conform)]
																 (conform.format {:formatters ["injected"] :timeout_ms 3000})))
								{:mode ["n" "v"]
								:desc "format injected langs"})]
		 :opts {:default_format_opts {:timeout_ms 3000
		 															:async false
																	:quiet false
																	:lsp_format "fallback"}
						:formatters_by_ft {:c ["clang-format"]
															 :fish ["fish_indent"]
															 :go ["goimports" "gofumpt"]
															 :nix ["nixfmt"]
															 :sh ["shfmt"]
															 :toml ["taplo"]
															 :zig ["zigfmt"]}
						:formatters {:injected {:options {:ignore_errors true}}}}})

	(tx "mfussenegger/nvim-lint"
		{:event "LazyFile"
		 :opts {:events ["BufWritePost" "BufReadPost" "InsertLeave"]
		 				:linters_by_ft {:fish ["fish"]}
						:linters {}}})

]
