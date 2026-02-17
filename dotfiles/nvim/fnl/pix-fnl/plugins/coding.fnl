(import-macros {: tx : keymap} :pix-fnl.core.macros)

[
	(tx "saghen/blink.cmp"
		{:version (and (not vim.g.lazyvim_blink_main) "*")
		 :build (and vim.g.lazyvim_blink_main "cargo build --release")

		 :opts_extend ["sources.completion.enabled_providers"
									 "sources.compat"
									 "sources.default"]

		 :event ["InsertEnter" "CmdlineEnter"]

		 :opts {:appearance {:use_nvim_cmp_as_default false
												 :nerd_font_variant "mono"}
						:completion {:accept {:auto_brackets {:enabled true}}
												 :list {:selection {:preselect false}}
												 :menu {:draw {:treesitter ["lsp"]}}
												 :documentation {:auto_show true :auto_show_delay_ms 200}
												 :ghost_text {:enabled vim.g.ai_cmp}}

						:sources {:compat [] :default ["lsp" "path" "snippets" "buffer"]}

						:keymap {:preset "enter" "C-y" ["select_and_accept"]}}

		 :config (fn [_ opts]
							 ;; setup compat sources
							 (let [enabled (. opts :sources :default)]
								 (each [_ source (ipairs (or (. opts :sources :compat) {}))]
									 (tset opts.sources.providers source
												 (vim.tbl_deep_extend 
													 "force"
													 {:name source :module "blink.compat.source"}
													 (or (. opts.sources.providers source) {})))
									 (when (and (= (type enabled) "table")
															(not (vim.tbl_contains enabled source)))
										 (table.insert enabled source))))

							 ;; add ai_accept to <tab> key
							 (when (not (. opts :keymap "<Tab>"))
								 (if (= (. opts.keymap :preset) "super-tab")
										 ;; super-tab
										 (tset opts.keymap "<Tab>"
													 [(. (require "blink.cmp.keymap.presets") "super-tab" "<Tab>" 1)
														(LazyVim.cmp.map ["snippet_forward" "ai_accept"])
														"fallback"])
										 ;; other presets
										 (tset opts.keymap "<Tab>"
													 [(LazyVim.cmp.map ["snipper_forward" "ai_accept"])
														"fallback"])))
							 
							 ;; unset custom prop to pass blink.cmp validation
							 (tset opts :sources :compat nil)


							 ;; check if we need to override symbol kinds
							 (each [_ provider (pairs (or (. opts.sources.providers) {}))]
								 (when provider.kind
									 (let [CompletionItemKind (. (require "blink.cmp.types") :CompletionItemKind)
												 kind-idx (+ (# CompletionItemKind) 1)]

										 (tset CompletionItemKind kind-idx provider.kind)
										 (tset CompletionItemKind provider.kind kind-idx)

										 (let [transform-items provider.transform_items]
											 (set provider.transform_items
														(fn [ctx items]
															(let [items (or (and transform-items (transform-items ctx items)) items)]
																(each [_ item (ipairs items)]
																	(set item.kind (or kind-idx item.kind))
																	(set item.kind_icon 
																			 (or (. LazyVim.config.icons.kinds item.kind_name)
																					 item.kind_icon
																					 nil)))
																items))))
										 ;; unset custom prop to pass blink.cmp validation
										 (set provider.kind nil))))

							 ;; finally, setup blink.cmp
							 ((. (require "blink.cmp") :setup) opts)
							)})

	;; add lazydev to blink completion
	(tx "saghen/blink.cmp"
		{:opts {:sources {:default ["lazydev"]
											:providers {:lazydev {:name "LazyDev"
																						:module "lazydev.integrations.blink"
																						:score_offset 100}}}}})

	;; add icons to blink	
	(tx "saghen/blink.cmp"
		{:opts (fn [_ opts]
						 (set opts.appearance (or opts.appearance {}))
						 (set opts.appearance.kind_icons 
									(vim.tbl_extend 
										"force" 
										(or opts.appearance.kind_icons {}) 
										LazyVim.config.icons.kinds)))})

	;; comments
	(tx "folke/ts-comments.nvim" {:event "VeryLazy" :opts {}})

	;; quick add and delete surroundings
	(tx "nvim-mini/mini.surround"
		{:opts {:custom_surroundings nil
						:highlight_duration 500
						:mapping {:add "gsa" ;; add surrounding in Normal and Visual
											:delete "gsd" ;; delete surrounding
											:find "gsf" ;; find surrounding to the right
											:find_left "gsF" ;; find surrounding to the left
											:highlight "gsh" ;; highlight surrounding
											:replace "gsr" ;; replace surrounding
											:update_n_lines "gsn"} ;; update `n_lines`
						:keys [(keymap "gz" "" {:desc "+surround"})]}})

	;; better text-objects
	(tx "nvim-mini/mini.ai"
		{:event "VeryLazy"
		 :opts (fn []
						 (let [ai (require "mini.ai")]
								{:n_lines 500
								 :custom_textobjects {
								 			:o (ai.gen_spec.treesitter {:a ["@block.outer" ;; code-blocks
																											"@conditional.outer" 
																											"@loop.outer"]
																									:i ["@block.inner" 
																											"@conditional.inner" 
																											"@loop.inner"]})
											:f (ai.gen_spec.treesitter {:a "@function.outer" ;; functions
																									:i "@function.inner"})
											:c (ai.gen_spec.treesitter {:a "@class.outer" :i "@class.inner"}) ;; class
											:t ["<([%p%w]-)%f[^<%w][^<>]->.-</%1>" "^<.->().*()</[^/]->$"] ;; tags
											:d ["%f[%d]%d+"] ;; digits 
											:e [["%u[%l%d]+%f[^%l%d]" "%f[%S][%l%d]+%f[^%l%d]" "%f[%P][%l%d]+%f[^%l%d]" "^[%l%d]+%f[^%l%d]"]
														"^().*()$"]
											:g LazyVim.mini.ai_buffer ;; buffer
											:u (ai.gen_spec.function_call) ;; u for "usage"
											:U (ai.gen_spec.function_call {:name_pattern "[%w_]"})}}))})

	;; lazydev for plugin dev
	(tx "folke/lazydev.nvim"
		{:ft "lua"
		 :cmd "LazyDev"
		 :opts {:library [{:path "${3rd}/luv/library" :words ["vim%.uv"]}
											{:path "LazyVim" :words ["LazyVim"]}
											{:path "snacks.nvim" :words ["Snacks"]}
											{:path "lazy.nvim" :words ["LazyVim"]}]}})

	;; explicit nil if not vim.g.ai_cmp
	(and vim.g.ai_cmp 
			 (tx "saghen/blink.cmp"
					{:optional true
					 :dependencies ["supermaven-nvim" "saghen/blink.compat"]
					 :opts {:sources {:compat ["supermaven"]
					 									:providers {:supermaven {:kind "Supermaven"
																										 :score_offset 100
																										 :async true}}}}}))

	;; ai improved autocomplete
	(tx "supermaven-inc/supermaven-nvim"
		{:event "InsertEnter"
		 :cmd ["SupermavenUseFree" "SupermavenUsePro"]
		 :config (fn [] (let [sm (require :supermaven-nvim)] (sm.setup {})))
		 :opts {:keymaps {:accept_suggestion nil}
		  			:disable_inline_completion vim.g.ai_cmp
						:ignore_filetypes ["bigfile" "snacks_input"]}})

	;; supermaven into noice
	(tx "folke/noice.nvim"
		{:optional true
		 :opts (fn [_ opts]
						 (vim.list_extend 
							 opts.routes 
							 [{:filter {:event "msg_show"
													:any [{:find "Starting Supermaven"}
																{:find "Supermaven Free Tier"}]}}]))})

	;; json extras
	(tx "b0o/SchemaStore" {:lazy true :version false})

	;; refactoring from Primeagen
	(tx "ThePrimeagen/refactoring.nvim"
		{:event ["BufReadPre" "BufNewFile"]
		 :dependencies ["nvim-lua/plenary.nvim" "nvim-treesitter/nvim-treesitter"]
		 :keys
				[(keymap "<leader>r" "" {:desc "+refactor" :mode ["n" "v"]})
				(keymap "<leader>rs" (fn [] (let [r (require :refactoring)] 
																			(r.select_refactor))) {:desc "refactor" :mode ["v"]})
				(keymap "<leader>ri" (fn [] (let [r (require :refactoring)] 
																			(r.refactor "Extract Block"))) {:desc "inline variable" :mode ["n" "v"]})
				(keymap "<leader>rb" (fn [] (let [r (require :refactoring)] 
																			(r.refactor "extract block")) {:desc "extract block"}))
				(keymap "<leader>rf" (fn [] (let [r (require :refactoring)] 
																			(r.refactor "Extract Block To File")) {:desc "extract block to file"}))
				(keymap "<leader>rP" (fn [] (let [r (require :refactoring)] 
																			(r.debug.printf {:below false}) {:desc "debug print"})))
				(keymap "<leader>rp" (fn [] (let [r (require :refactoring)] 
																			(r.debug.print_var {:normal true}) {:desc "debug print variable"})))
				(keymap "<leader>rc" (fn [] (let [r (require :refactoring)] 
																			(r.debug.cleanup {})) {:desc "debug cleanup"}))
				(keymap "<leader>rf" (fn [] (let [r (require :refactoring)] 
																			(r.refactor "Extract Function")) {:mode ["v"] :desc "extract function"}))
				(keymap "<leader>rF" (fn [] (let [r (require :refactoring)] 
																			(r.refactor "Extract Function To File")) {:mode ["v"] :desc "extract function to file"}))
				(keymap "<leader>rx" (fn [] (let [r (require :refactoring)] 
																			(r.refactor "Extract Variable")) {:mode ["v"] :desc "extract variable"}))
				(keymap "<leader>rp" (fn [] (let [r (require :refactoring)] 
																			(r.debug.print_var)) {:mode ["v"] :desc "debug print variable"}))]

		 :opts {:prompt_func_return_type {:go false
		 																  :java false
																			:cpp false
																			:c false
																			:h false
																			:hpp false
																			:cxx false}
						:prompt_func_param_type {:go false
		 																  :java false
																			:cpp false
																			:c false
																			:h false
																			:hpp false
																			:cxx false}
						:printf_statements {}
						:print_var_statements {}
						:show_success_message true }});; shows a message with information about the refactor on success
						;; i.e [Refactor] Inlined 3 variable occurrences

	;; nvim debug adapter
	(tx "mfussenegger/nvim-dap"
		{:dependencies [(tx "mason-org/mason.nvim" 
											{:opts {:ensure_installed ["delve"]}
											 :cmd ["Mason" "MasonInstall" "MasonUpdate" "MasonUninstall" "MasonLog"]})
										(tx "leoluz/nvim-dap-go" {:ft ["go"]})]
		 :cmd ["DapContinue"
						"DapToggleBreakpoint"
						"DapStepOver"
						"DapStepInto"
						"DapStepOut"
						"DapTerminate"]})

	;; neotest for various languages
	(tx "nvim-neotest/neotest"
		{:dependencies [["nvim-neotest/nvim-nio"]
										["lawrence-laz/neotest-zig"]
										["fredrikaverpil/neotest-golang"]]
		 :opts {:adapters {"neotest-zig" []
		 									 "neotest-golang" {:dap_go_enabled true}}}
		 :cmd ["Neotest"
					"NeotestRun"
					"NeotestSummary"
					"NeotestOutput"
					"NeotestOutputPanel"
					"NeotestStop"] })

	;; compile mode builtin to neovim
	(tx "ej-shafran/compile-mode.nvim"
		{:lazy true
		 :branch "latest"
		 :dependencies ["nvim-lua/plenary.nvim" (tx "m00qek/baleia.nvim" {:tag "v1.3.0"})]
		 :config (fn []
							 (let [cm (require :compile-mode)]
							 (set vim.g.compile_mode {:baleia_setup true
																				:default_command ""
																				:error_threshold cm.level.INFO
																				:recompile_no_fail true})))})

	;; markdown table mode for auto formatting
	(tx "Kicamon/markdown-table-mode.nvim" {:ft ["markdown"] :opts {:insert true :insert_leave true}})

	;; go autotests
	(tx "yanskun/gotests.nvim" {:ft "go" :config (fn [] (let [gt (require :gotests)] (gt.setup)))})

	;; godoc
	(tx "fredrikaverpil/godoc.nvim"
		{:version "*"
		 :dependencies [["ibhagwan/fzf-lua"]
										[(tx "nvim-treesitter/nvim-treesitter" {:opts {:ensure_installed ["go"]}})]]
		 :build "go install github.com/lotusirous/gostdsym/stdsym@latest"
		 :cmd ["GoDoc"]
		 :opts {:picker {:type "fzf_lua"
		 								 :fzf_lua {:winopts {:height 0.8
										 										 :width 0.8
																				 :preview {:vertical "right:50%"
																				 					 :horizontal "up:60%"
																									 :layout "vertical"
																									 :title "Go Docs"}}
															 :fzf_opts {"--layout" "reverse"
																					"--info" "inline"
																					"--border" "rounded"}
															 :keymap {:fzf {"ctrl-f" "preview-page-down"
															 								"ctrl-b" "preview-page-up"}}}}}})


	;; fennel in neovim!
	(tx "Olical/nfnl" {:ft "fennel"})

	;; wakatime coding tracking
	(tx "wakatime/vim-wakatime" {:lazy false})
]
