(import-macros {: tx} :pix-fnl.core.macros)

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
															"zig"])
								{}))})

	;; easier way to wrap a second redeclare
	(tx "nvim-treesitter/nvim-treesitter"
		{:opts (fn [_ _]
						 (vim.filetype.add {:extension {:rasi "rasi" :rofi "rasi" :wofi "rasi"}
															  :filename {"vifmrc" "vim"}
																:pattern {
																	".*/waybar/config" "jsonc"
																	".*/mako/config" "dosini"
																	".*/hypr/.+%.conf" "hyprlang"
																	"%.env%.[%w_.-]+" "sh"}}))})

	;; treesitter-textobjects since they've been moved out of nvim-treesitter
	(tx "nvim-treesitter/nvim-treesitter-textobjects"
		{:branch "main"
		 :lazy false
		 :init (fn [] (set vim.g.no_plugin_maps true))
		 :config (fn [] (let [ntt (require :nvim-treesitter-textobjects)
													sel ntt.select
													mv ntt.move]

											(local xo_keymap (fn [lhs query]
																				 (vim.keymap.set ["x" "o"] 
																												 lhs 
																												 (fn [] (sel.select_textobject query "textobjects"))
																												 {:silent true :desc (.. "TS select " query)})))
											(local nxo_keymap (fn [lhs fun]
																					(vim.keymap.set ["n" "x" "o"] lhs fun {:silent true})))

											(ntt.setup {:select {:lookahead true :include_surrounding_whitespace false}
																  :move {:set_jumps true}})

											(xo_keymap "ak" "@block.outer")
											(xo_keymap "ik" "@block.inner")
											(xo_keymap "ac" "@class.outer")
											(xo_keymap "ic" "@class.inner")
											(xo_keymap "a?" "@conditional.outer")
											(xo_keymap "i?" "@conditional.inner")
											(xo_keymap "af" "@function.outer")
											(xo_keymap "if" "@function.inner")
											(xo_keymap "al" "@loop.outer")
											(xo_keymap "il" "@loop.inner")
											(xo_keymap "aa" "@parameter.outer")
											(xo_keymap "ia" "@parameter.inner")

											(nxo_keymap "]f" (fn [] (mv.goto_next_start "@function.outer" "textobjects")))
											(nxo_keymap "]c" (fn [] (mv.goto_next_start "@class.outer" "textobjects")))
											(nxo_keymap "]a" (fn [] (mv.goto_next_start "@parameter.inner" "textobjects")))
											(nxo_keymap "]F" (fn [] (mv.goto_next_end "@function.outer" "textobjects")))
											(nxo_keymap "]C" (fn [] (mv.goto_next_end "@class.outer" "textobjects")))
											(nxo_keymap "]A" (fn [] (mv.goto_next_end "@parameter.inner" "textobjects")))
											(nxo_keymap "[f" (fn [] (mv.goto_previous_start "@function.outer" "textobjects")))
											(nxo_keymap "[c" (fn [] (mv.goto_previous_start "@class.outer" "textobjects")))
											(nxo_keymap "[a" (fn [] (mv.goto_previous_start "@parameter.inner" "textobjects")))
											(nxo_keymap "[F" (fn [] (mv.goto_previous_end "@function.outer" "textobjects")))
											(nxo_keymap "[C" (fn [] (mv.goto_previous_end "@class.outer" "textobjects")))
											(nxo_keymap "[A" (fn [] (mv.goto_previous_end "@parameter.inner" "textobjects")))))})

	;; hyprland treesitter 
	["luckasRanarison/tree-sitter-hyprlang"]

	;; auto add closing tags for html
	(tx "windwp/nvim-ts-autotag" {:event "LazyFile" :opts {}})

]
