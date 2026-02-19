(import-macros {: tx } :pix-fnl.core.macros)

[
	(tx "ray-x/go.nvim"
		{:dependencies [ "ray-x/guihua.lua" "neovim/nvim-lspconfig" "nvim-treesitter/nvim-treesitter" ]
		 :opts (fn [_ opts]
				((. (require "go") :setup) opts)
				(local format_sync_grp (vim.api.nvim_create_augroup "GoFormat" {}))
				(vim.api.nvim_create_autocmd "BufWritePre" {:pattern "*.go"
																		 								:callback (fn [] ((. (require "go.format") :goimports)))
																										:group format_sync_grp}))

			:event ["CmdlineEnter"]
			:ft ["go" "gomod"]})
]

