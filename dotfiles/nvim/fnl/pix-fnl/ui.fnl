(import-macros {: tx : keymap} :pix-fnl.macros)

(local {: colorscheme} (require :pix-fnl.core.utils))

[
  ;; my theme <3
	(tx "umbral"
		{:name "umbral"
		 :dir "~/AdeptusCustodes/Lunar/nvim_plugins/umbral.nvim"
		 :dev true
		 :config (fn [] (colorscheme :umbral)) })

	;; tabs / buffers along the top
  (tx "akinsho/bufferline.nvim"
		{:event "VeryLazy"
		 :keys [
			(keymap "<leader>bp" "<cmd>BufferLineTogglePin<cr>" {:desc "toggle pin"} )
			(keymap  "<leader>bP" "<cmd>BufferLineGroupClose ungrouped<cr>" {:desc "delete non-pinned buffers"} )
			(keymap  "<leader>br" "<cmd>BufferLineCloseRight<cr>" {:desc "close buffers to the right" })
			(keymap  "<leader>bl" "<cmd>BufferLineCloseLeft<cr>" {:desc "close buffers to the left" })
			(keymap  "<leader>bb" "<cmd>BufferLineCycleNext<cr>" {:desc "cycle through buffers" })
			(keymap  "<S-l>" "<cmd>BufferLineCycleNext<cr>" {:desc "next buffer" })
			(keymap  "<S-h>" "<cmd>BufferLineCyclePrev<cr>" {:desc "prev buffer" })
			(keymap  "[B" "<cmd>BufferLineMovePrev<cr>" {:desc "move buffer left" })
			(keymap  "]B" "<cmd>BufferLineMoveNext<cr>" {:desc "move buffer right" })]
		 :opts { 
		   :options {
					:close_command (fn [n] (Snacks.bufdelete n))
					:right_mouse_command (fn [n] (Snacks.bufdelete n))
					:diagnostics "nvim_lsp"
					:always_show_bufferline false
					:diagnostics_indicator 
						(fn [_ _ diag]
							(let [icons LazyVim.config.icons.diagnostics
												error-part (if diag.error
																			(.. icons.Error diag.error " ")
																			"")
												warn-part (if diag.warning
																			(.. icons.Warn diag.warning)
																			"")
												ret (.. error-part warn-part)]
							(vim.trim ret)))
					:offsets [
						{:filetype "neo-tree" :text "Neo-tree" :highlight "Directory" :text_align "left" }
						{:filetype "snacks_layout_box"} ]
					:get_element_icon (fn [opts] (. LazyVim.config.icons.ft opts.filetype)) } }
		 :config (fn [_ opts]
							 (local bufline (require :bufferline))
							 (bufline.setup opts)
							 (vim.api.nvim_create_autocmd [ "BufAdd" "BufDelete" ] 
									{:callback (fn []
										(vim.schedule #(pcall nvim_bufferline)))}))
	}) 
	
	;; dashboard for when you just run 'nvim'
  (tx "folke/snacks.nvim"
		{:opts {
		  :dashboard {
				:preset {
					:header "
       ██████╗ ██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗
       ██╔══██╗██║╚██╗██╔╝██║   ██║██║████╗ ████║
       ██████╔╝██║ ╚███╔╝ ██║   ██║██║██╔████╔██║
       ██╔═══╝ ██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║
       ██║     ██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
       ╚═╝     ╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
"
	      }
				:sections [
				  { :section :header }
          { :section :startup }
					[ { :icon " " :key "f" :desc "Find File" :action ":lua Snacks.dashboard.pick('files')" }
						{ :icon " " :key "n" :desc "New File" :action ":ene | startinsert" }
						{ :icon " " :key "/" :desc "Find Text" :action ":lua Snacks.dashboard.pick('live_grep')" }
						{ :icon " " :key "r" :desc "Recent Files" :action ":lua Snacks.dashboard.pick('oldfiles')" }
						{ :icon " " :key "c" :desc "Config" :action ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" }
						{ :icon " " :key "s" :desc "Restore Session" :section "session" }
						{ :icon " " :key "q" :desc "Quit" :action ":qa" } ] ]
      } } } )

	;; rest of snacks qol inclusions
  (tx "folke/snacks.nvim"
	  {:opts {
      :bigfile {
			  :notify true ; tell me if its YUUUUGE
				:size (* 1024 1024 1.5) ; 1.5Mb
				:line_length 1000 }
			:dim { :enabled false }
			:explorer { :enabled false }
			:indent { :enabled true :only_current false :animate { :enabled false }}
			:input { :enabled true }
			:lazygit { :enabled true :configure true }
			:notifier { :enabled true :timeout 3000 }
			:picker { :enabled true }
			:profiler {
			  :enabled true
				:opts (fn [] 
								(Snacks.toggle.profiler:map "<leader>pp")
								(Snacks.toggle.profiler:map "<leader>ph")) 
				:keys [ (keymap "<leader>ps" (fn [] (Snacks.profiler.scratch)) {:desc "profiler scratch buffer" }) ] }
			:rename { :enabled true } ;; global rename, grug-far|fastmod replace this?
			:scroll { :enabled false } ;; disable smooth scrolling
			:statuscolumn { :enabled true } ;; icons next to numbers
			:terminal { :enabled false } ;; just split ghostty|tmux|zellij|kitty
			:words {
			  :enabled true
				:debounce 200
				:notify_jump false
				:notify_end true
				:foldopen true
				:jumplist true
				:mode [ "n" "i" "c" ]
				:filter (fn [buf] ;; what buffers to enable on
								 (let [bvars (. vim.b buf)]
									 (and (not= vim.g.snacks_words false)
												(not= bvars.snacks_words false)))) }
			:keys  [
				(keymap "<leader><space>" (fn [] (Snacks.picker.smart) ) {:desc "Smart Find Files" })
				(keymap "<leader>," (fn [] (Snacks.picker.buffers)) {:desc "Buffers" })
				(keymap "<leader>/" (fn [] (Snacks.picker.grep)) {:desc "Grep" })
				(keymap "<leader>:" (fn [] (Snacks.picker.command_history)) {:desc "Command History" })
				; [ "<leader>n" (fn [] (Snacks.picker.notifications)) :desc "Notification History" ]
				;; find commands 
				(keymap "<leader>fb" (fn [] (Snacks.picker.buffers)) {:desc "Buffers" })
				(keymap "<leader>fx" (fn [] (Snacks.picker.files {:cwd (vim.fn.stdpath "config")})) {:desc "Find Config File"})
				(keymap "<leader>ff" (fn [] (Snacks.picker.files)) {:desc "Find Files" })
				(keymap "<leader>fg" (fn [] (Snacks.picker.git_files)) {:desc "Find Git Files" })
				(keymap "<leader>fp" (fn [] (Snacks.picker.projects)) {:desc "Projects" })
				(keymap "<leader>fr" (fn [] (Snacks.picker.recent)) {:desc "Recent" })
				;; git commands
				(keymap "<leader>gb" (fn [] (Snacks.picker.git_branches)) {:desc "Git Branches" })
				(keymap "<leader>gl" (fn [] (Snacks.picker.git_log)) {:desc "Git Log" })
				(keymap "<leader>gL" (fn [] (Snacks.picker.git_log_line)) {:desc "Git Log Line" })
				(keymap "<leader>gs" (fn [] (Snacks.picker.git_status)) {:desc "Git Status" })
				(keymap "<leader>gS" (fn [] (Snacks.picker.git_stash)) {:desc "Git Stash" })
				(keymap "<leader>gd" (fn [] (Snacks.picker.git_diff)) {:desc "Git Diff (Hunks)" })
				(keymap "<leader>gf" (fn [] (Snacks.picker.git_log_file)) {:desc "Git Log File" })
				;; search commands 
				(keymap "<leader>s\"" (fn [] (Snacks.picker.registers)) {:desc "Registers" })
				(keymap "<leader>s/" (fn [] (Snacks.picker.search_history)) {:desc "Search History" })
				(keymap "<leader>sa" (fn [] (Snacks.picker.autocmds)) {:desc "Autocmds" })
				(keymap "<leader>sb" (fn [] (Snacks.picker.lines)) {:desc "Buffer Lines" })
				(keymap "<leader>sc" (fn [] (Snacks.picker.command_history)) {:desc "Command History" })
				(keymap "<leader>sC" (fn [] (Snacks.picker.commands)) {:desc "Commands" })
				(keymap "<leader>sd" (fn [] (Snacks.picker.diagnostics)) {:desc "Diagnostics" })
				(keymap "<leader>sD" (fn [] (Snacks.picker.diagnostics_buffer)) {:desc "Buffer Diagnostics" })
				(keymap "<leader>sh" (fn [] (Snacks.picker.help)) {:desc "Help Pages" })
				(keymap "<leader>sH" (fn [] (Snacks.picker.highlights)) {:desc "Highlights" })
				(keymap "<leader>si" (fn [] (Snacks.picker.icons)) {:desc "Icons" })
				(keymap "<leader>sj" (fn [] (Snacks.picker.jumps)) {:desc "Jumps" })
				(keymap "<leader>sk" (fn [] (Snacks.picker.keymaps)) {:desc "Keymaps" })
				(keymap "<leader>sl" (fn [] (Snacks.picker.loclist)) {:desc "Location List" })
				(keymap "<leader>sm" (fn [] (Snacks.picker.marks)) {:desc "Marks" })
				(keymap "<leader>sM" (fn [] (Snacks.picker.man)) {:desc "Man Pages" })
				(keymap "<leader>sp" (fn [] (Snacks.picker.lazy)) {:desc "Search for Plugin Spec" })
				(keymap "<leader>sq" (fn [] (Snacks.picker.qflist)) {:desc "Quickfix List" })
				(keymap "<leader>sR" (fn [] (Snacks.picker.resume)) {:desc "Resume" })
				(keymap "<leader>su" (fn [] (Snacks.picker.undo)) {:desc "Undo History" })
				(keymap "<leader>uC" (fn [] (Snacks.picker.colorschemes)) {:desc "Colorschemes" })
				;; lsp comamnds
				(keymap "gd" (fn [] (Snacks.picker.lsp_definitions)) {:desc "Goto Definition" })
				(keymap "gD" (fn [] (Snacks.picker.lsp_declarations)) {:desc "Goto Declarationnnn" })
				(keymap "gr" (fn [] (Snacks.picker.lsp_references)) {:nowait true :desc "References" })
				(keymap "gI" (fn [] (Snacks.picker.lsp_implementations)) {:desc "Goto Implementation" })
				(keymap "gy" (fn [] (Snacks.picker.lsp_type_definitions)) {:desc "Goto T[y]pe Definition" })
				(keymap "<leader>ss" (fn [] (Snacks.picker.lsp_symbols)) {:desc "LSP Symbols" })
				(keymap "<leader>sS" (fn [] (Snacks.picker.lsp_workspace_symbols)) {:desc "LSP Workspace Symbols" })
				;; bonus commands
				(keymap "<leader>n"  (fn [] (Snacks.notifier.show_history)) {:desc "Notification History" })
				(keymap "<leader>bd" (fn [] (Snacks.bufdelete)) {:desc "Delete Buffer" })
				(keymap "<leader>cR" (fn [] (Snacks.rename.rename_file)) {:desc "Rename File" })
				(keymap "<leader>gB" (fn [] (Snacks.gitbrowse)) {:desc "Git Browse" :mode [ "n" "v" ] })
				(keymap "<leader>gg" (fn [] (Snacks.lazygit)) {:desc "Lazygit" })]
				} } )

	;; lualine component to show profilered captured events from snacks
  (tx "nvim-lualine/lualine.nvim"
		{:opts (fn [_ opts] (table.insert opts.sections.lualine_x (Snacks.profiler.status))) })

	;; folke's replacement UI for everything looks gewd
	(tx "folke/noice.nvim"
		{:event "VeryLazy"
		 :opts {:lsp {:override { :vim.lsp.util.convert_input_to_markdown_lines true
															:vim.lsp.util.stylize_markdown true
															:cmp.entry.get_documentation true } }
						:routes [{:filter {:event "msg_show" 
															:any [{ :find "%d+L, %d+B" }
																		{ :find "; after #%d+" }
																		{ :find "; before #%d+" }]}
											:view :mini }]
						:presets {:bottom_search true
											:command_palette true
											:long_message_to_split true }}
		:keys (let [noice (require :noice)
				  lsp (require :noice.lsp)] 
					[(keymap "<leader>sn" "" {:desc "+noice" })
					(keymap "<S-Enter>" (fn [] (noice.redirect (vim.fn.getcmdline))) {:mode "c" :desc "redirect cmdline" })
					(keymap "<leader>snl" (fn [] (noice.cmd "last")) {:desc "Noice Last Message" })
					(keymap "<leader>snh" (fn [] (noice.cmd "history")) {:desc "Noice History" })
					(keymap "<leader>sna" (fn [] (noice.cmd "all")) {:desc "Noice All" })
					(keymap "<leader>snd" (fn [] (noice.cmd "dismiss")) {:desc "Dismiss All" })
					(keymap "<leader>snt" (fn [] (noice.cmd "pick")) {:desc  "Noice Picker (Telescope/FzfLua)" })
					(keymap "<c-f>" (fn [] (if (not (lsp.scroll 4)) "<c-f>")) {:silent true :expr true :desc "Scroll Forward" :mode ["i" "n" "s"]})
					(keymap "<c-b>" (fn [] (if (not (lsp.scroll -4)) "<c-b>")) {:silent true :expr true :desc "Scroll Backward" :mode ["i" "n" "s"]}) ])
		  :config (fn [_ opts]
							  (when (= vim.o.filetype "lazy")
									(vim.cmd "messages clear"))
								(let [noice (require :noice)]
									(noice.setup opts)))
		}) 

	;; lualine status bar
	(tx "nvim-lualine/lualine.nvim"
		{:event "VeryLazy"

		:init (fn []
						(set vim.g.lualine_laststatus vim.o.laststatus)
						(if (> (vim.fn.argc -1) 0)
							(set vim.o.statusline " ")
							(set vim.o.laststatus 0)))

		:opts (fn []
						(local lualine-require (require :lualine_require))
						(set lualine-require.require require)

						(local icons LazyVim.config.icons)
						(set vim.o.laststatus vim.g.lualine_laststatus)

						(local noice (require :noice))
						(local lazy-status (require :lazy.status))

						(local opts
							{:options {:theme "auto"
												 :globalstatus (= vim.o.laststatus 3)
												 :disabled_filetypes {:statusline ["dashboard" "snacks_dashboard" "ministarter"]}}

							:sections 
								{:lualine_a
								[["mode"
									:icons_enabled true
									:separator {:right ""}
									:fmt (fn []
													(let [mode-map {:n  "N (ᴗ_ ᴗ。)"
																					:nt "N (ᴗ_ ᴗ。)"
																					:i  "I (•̀ - •́ )"
																					:R  "R ( •̯́ ₃ •̯̀)"
																					:v  "V (⊙ _ ⊙ )"
																					:V  "V (⊙ _ ⊙ )"
																					:no "C Σ(°△°||)"
																					"\22" "V (⊙ _ ⊙ )"
																					:t  "T (⌐■_■)"
																					"!"  "C Σ(°△°||)"
																					:c  "C Σ(°△°||)"
																					:s  "S SUB"}
																mode (vim.api.nvim_get_mode)]
														(or (. mode-map mode.mode)
																mode.mode)))]]

								:lualine_b ["branch"]

								:lualine_c 
								[(LazyVim.lualine.root_dir)

									["diagnostics"
									:symbols {:error icons.diagnostics.Error
													:warn icons.diagnostics.Warn
													:info icons.diagnostics.Info
													:hint icons.diagnostics.Hint }]

									["filetype" :icon_only true :separator "" :padding {:left 1 :right 0}]
									[(LazyVim.lualine.pretty_path)]]

								:lualine_x 
								[(Snacks.profiler.status)

									[(fn [] (noice.api.status.mode.get))
									:cond (fn [] (and (. package.loaded "noice")
																		(noice.api.status.command.has)))
									:color (fn [] {:fg (Snacks.util.color "Statement")})]

									[(fn [] (noice.api.status.mode.get))
									:cond (fn [] (and (. package.loaded "noice")
																	(noice.api.status.command.has)))
									:color (fn [] {:fg (Snacks.util.color "Constant")})]

									[(fn [] (let [dap (require :dap)]
											(.. "  " (dap.status))))
									:cond (fn []
													(let [dap (require :dap)]
														(and (. package.loaded "dap")
																(not= (dap.status) ""))))
									:color (fn [] {:fg (Snacks.util.color "Debug")})]

									[lazy-status.updates
									:cond lazy-status.has_updates
									:color (fn [] {:fg (Snacks.util.color "Special")})]

									["diff"
									:symbols {:added icons.git.added
														:modified icons.git.modified
														:removed icons.git.removed}
									:source (fn []
														(let [gitsigns vim.b.gitsigns_status_dict]
															(when gitsigns
																{:added gitsigns.added
																	:modified gitsigns.changed
																	:removed gitsigns.removed})))]]

								:lualine_y
								[["progress" :separator " " :padding {:left 1 :right 0}]
									["location" :padding {:left 0 :right 1}]]

								:lualine_z
								[(fn [] (.. " " (os.date "%R")))]}

							:extensions ["neo-tree" "lazy" "fzf"]})

							;; do not add trouble symbols if aerial is enabled
							;; and allow it to be overriden for som ebuffer tyse (see autocmds)
							(when (and vim.g.trouble_lualine (LazyVim.has "trouble.nvim"))
								(local trouble (require :trouble))
								(local symbols
									(trouble.statusline
										{:mode "symbols"
											:groups []
											:title false
											:filter {:range true}
											:format "{kind_icon}{symbol.name:Normal}"
											:hl_group "lualine_c_normal"}))

								(table.insert
									opts.sections.lualine_c
									[(and symbols symbols.get)
										:cond (fn []
														(and (not= vim.b.trouble_lualine false)
																(symbols.has)))]))

							opts)})

	;; icons!
  (tx "nvim-mini/mini.icons"
		{:lazy true
		 :opts {:file {".go-version" { :glyph "" :hl "MiniIconsBlue" }
		               ".keep" {:glyph "󰊢" :hl "MiniIconsGrey" }
									 "devcontainer.json" {:glyph "" :hl "MiniIconsAzure" }}
						:filetype {:dotenv {:glyph "" :hl "MiniIconsYellow" }
											 :gotmpl {:glyph "󰟓" :hl "MiniIconsGrey" }}}})

	;; ui framework
  (tx "MunifTanjim/nui.nvim" {:lazy true})

	;; key preview for commands
	(tx "folke/which-key.nvim"
		{:opts {
		  :plugins { :spelling true }
			:spec (let [spec []]
							(tset spec :mode ["n" "v"])
							(table.insert spec ["<leader>p" {:group "pix" :icon "Px"}])
							spec)}})

	;; todo comments highlighting extended to include my own
 	(tx "folke/todo-comments.nvim"
		{:dependencies ["nvim-lua/plenary.nvim"]
			:cmd [ :TodoTrouble :TodoTelescope ]
			:event :LazyFile
		 	:opts {
				:colors {
					:error [ :DiagnosticError :ErrorMsg "#DC2626" ] 
					:warning [ :DiagnosticWarn :WarningMsg "#FBBF24" ]
					:info [ :DiagnosticInfo "#2563EB" ]
					:hint [ :DiagnosticHint "#10B981" ]
					:default [ :Identifier "#7C3AED" ]
					:test [ :Identifier "#FF00FF" ]
					:pix_todo [ "#5e7fd0" ]
					:pix_note [ "#c4a7e7" ]
					:pix_hack [ "#eb6f92" ]
					:pix_improve [ "#ea9d34" ] }
				:keywords {
					:PIXNOTE { :icon "" :color "pix_note" :alt [ "THOUGHT" ] }
					:PIXHACK { :icon "" :color "pix_hack" :alt [ "HACKFIX" ] }
					:PIXTODO { :icon "" :color "pix_todo" :alt [ "PIXTODO" ] }
					:IMPROVEMENT { :icon "󰟶" :color "pix_improve" :alt [ "IMPROVE" "IDEA" "IMPROV" ] } }
					;; Preview:
					;; PIXTODO:     Sphinx of Black Quartz, Judge My Vow
					;; TODO:        Sphinx of Black Quartz, Judge My Vow
					;; IMPROVEMENT: Sphinx of Black Quartz, Judge My Vow
					;; IDEA:        Sphinx of Black Quartz, Judge My Vow
					;; IMPROV:      Sphinx of Black Quartz, Judge My Vow
					;; PIXHACK:     Sphinx of Black Quartz, Judge My Vow
					;; HACKFIX:     Sphinx of Black Quartz, Judge My Vow
					;; THOUGHT:     Sphinx of Black Quartz, Judge My Vow
					;; PIXNOTE:     Sphinx of Black Quartz, Judge My Vow
					;; NOTE:        Sphinx of Black Quartz, Judge My Vow
					;; HACK:        Sphinx of Black Quartz, Judge My Vow
					;; WARN:        Sphinx of Black Quartz, Judge My Vow
					;; FIXME:       Sphinx of Black Quartz, Judge My Vow
				:keys [
					(keymap "]t" (fn [] (let [todo (require :todo-comments)] (todo.jump_next))) {:desc "next todo comment"}) 
					(keymap "[t" (fn [] (let [todo (require :todo-comments)] (todo.jump_prev))) {:desc "prev todo comment"})
					(keymap "<leader>xt" "<cmd>Trouble todo toggle<cr>" {:desc "Todo (trouble)" })
					(keymap "<leader>xT" "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>" {:desc "Todo/Fix/Fixme (Trouble)" })
          (keymap "<leader>st" "<cmd>TodoTelescope<cr>" {:desc "Todo (telescope)" })
          (keymap "<leader>sT" "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>" {:desc "todo/fix/fixme (telescope)" }) ]}})

	;; highlight patterns
  (tx "nvim-mini/mini.hipatterns" {:version false})

	;; highlight hex codes on colours in neovim
  (tx "brenoprata10/nvim-highlight-colors"
		{:lazy true 
		 :opts {
				:render :background
				:virtual_symbol "■"
				:virtual_symbol_prefix ""
				:virtual_symbol_suffix " " 
				:enable_hex true 
				:enable_short_hex true 
				:enable_rgb true 
				:enable_hsl true
				:enable_var_usage true
				:enable_named_colors true
				:enable_tailwind false
				:custom_colors [
				  { :label "%-%-theme%-primary%-color" :color "#0f1219" }
					{ :label "%-%-theme%-secondary%-color" :color "#5a5d64" }]
				:exclude_filetypes []
				:exclude_buftypes []
		}
		:init (fn [] (let [nhc (require :nvim-highlight-colors)] (nhc.turnOn)))
	})
]
