(import-macros {: tx : keymap } :pix-fnl.core.macros)

[
	; (tx "ray-x/go.nvim"
	; 	{:dependencies [ "ray-x/guihua.lua" "neovim/nvim-lspconfig" "nvim-treesitter/nvim-treesitter" ]
	; 	 :opts (fn [_ opts]
	; 			((. (require "go") :setup) opts)
	; 			(local format_sync_grp (vim.api.nvim_create_augroup "GoFormat" {}))
	; 			(vim.api.nvim_create_autocmd "BufWritePre" {:pattern "*.go"
	; 																	 								:callback (fn [] ((. (require "go.format") :goimports)))
	; 																									:group format_sync_grp}))
	;
	; 		:event ["CmdlineEnter"]
	; 		:ft ["go" "gomod"]})

  (tx "martindur/zdiff.nvim"
		{:cmd ["Zdiff"]
		 :keys [
		 	(keymap "<leader>zd" "<cmd>Zdiff<cr>" {:desc "Zdiff (uncommitted)"})
			(keymap "<leader>zD" "<cmd>Zdiff main<cr>" {:desc "Zdiff (vs main)"})]
			; (keymap "<leader>zp" "<cmd>Zdiff TODO: ask for input and zdiff input
		 :opts {
		 	:default_expanded true
			:default_branch "main"
			:syntax {:max_lines 20000 :mode "projection"}
		 }})
]

