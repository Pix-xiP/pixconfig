(import-macros {: tx : keymap} :pix-fnl.core.macros)

[
 	;; treesitter syntax highlighting
	(tx "nvim-treesitter/nvim-treesitter"
		{:branch "main"
		 :version false
		 :lazy false
		 :build ":TSUpdate"
		 :config (fn []
							 (let [ts (require :nvim-treesitter)]
								 (ts.setup {:install_dir (.. (vim.fn.stdpath "data") "/site")})
								 (ts.install ["bash"
															"c"
															"diff"
															"fennel"
															"fish"
															"git_config"
															"git_rebase"
															"gitattributes"
															"gitcommit"
															"gitignore"
															"go"
															"hcl"
															"html"
															"hyprlang"
															"ini"
															"json"
															"json5"
															;; "jsonc"
															"lua"
															"luadoc"
															"luap"
															"markdown"
															"markdown_inline"
															"nix"
															"odin"
															"printf"
															"query"
															"rasi"
															"regex"
															"ruby"
															"terraform"
															"tmux"
															"toml"
															"vim"
															"vimdoc"
															"yaml"
															"zig"])))})

]
