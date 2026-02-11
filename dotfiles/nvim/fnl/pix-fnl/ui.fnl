(import-macros {: tx} :pix-fnl.macros)

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
			[ "<leader>bp" "<cmd>BufferLineTogglePin<cr>" :desc "toggle pin" ]
			[ "<leader>bP" "<cmd>BufferLineGroupClose ungrouped<cr>" :desc "delete non-pinned buffers" ]
			[ "<leader>br" "<cmd>BufferLineCloseRight<cr>" :desc "close buffers to the right" ]
			[ "<leader>bl" "<cmd>BufferLineCloseLeft<cr>" :desc "close buffers to the left" ]
			[ "<leader>bb" "<cmd>BufferLineCycleNext<cr>" :desc "cycle through buffers" ]
			[ "<S-l>" "<cmd>BufferLineCycleNext<cr>" :desc "next buffer" ]
			[ "<S-h>" "<cmd>BufferLineCyclePrev<cr>" :desc "prev buffer" ]
			[ "[B" "<cmd>BufferLineMovePrev<cr>" :desc "move buffer left" ]
			[ "]B" "<cmd>BufferLineMoveNext<cr>" :desc "move buffer right" ]]
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
				:keys [ [ "<leader>ps" (fn [] (Snacks.profiler.scratch)) :desc "profiler scratch buffer" ] ] }
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
				[ "<leader><space>" (fn [] (Snacks.picker.smart) ) :desc "Smart Find Files" ]
				[ "<leader>," (fn [] (Snacks.picker.buffers)) :desc "Buffers" ]
				[ "<leader>/" (fn [] (Snacks.picker.grep)) :desc "Grep" ]
				[ "<leader>:" (fn [] (Snacks.picker.command_history)) :desc "Command History" ]
				; [ "<leader>n" (fn [] (Snacks.picker.notifications)) :desc "Notification History" ]
				;; find commands 
				[ "<leader>fb" (fn [] (Snacks.picker.buffers)) :desc "Buffers" ]
				[ "<leader>fx" (fn [] (Snacks.picker.files {:cwd (vim.fn.stdpath "config")})) :desc "Find Config File" ]
				[ "<leader>ff" (fn [] (Snacks.picker.files)) :desc "Find Files" ]
				[ "<leader>fg" (fn [] (Snacks.picker.git_files)) :desc "Find Git Files" ]
				[ "<leader>fp" (fn [] (Snacks.picker.projects)) :desc "Projects" ]
				[ "<leader>fr" (fn [] (Snacks.picker.recent)) :desc "Recent" ]
				;; git commands
				[ "<leader>gb" (fn [] (Snacks.picker.git_branches)) :desc "Git Branches" ]
				[ "<leader>gl" (fn [] (Snacks.picker.git_log)) :desc "Git Log" ]
				[ "<leader>gL" (fn [] (Snacks.picker.git_log_line)) :desc "Git Log Line" ]
				[ "<leader>gs" (fn [] (Snacks.picker.git_status)) :desc "Git Status" ]
				[ "<leader>gS" (fn [] (Snacks.picker.git_stash)) :desc "Git Stash" ]
				[ "<leader>gd" (fn [] (Snacks.picker.git_diff)) :desc "Git Diff (Hunks)" ]
				[ "<leader>gf" (fn [] (Snacks.picker.git_log_file)) :desc "Git Log File" ]
				;; search commands 
				[ "<leader>s\"" (fn [] (Snacks.picker.registers)) :desc "Registers" ]
				[ "<leader>s/" (fn [] (Snacks.picker.search_history)) :desc "Search History" ]
				[ "<leader>sa" (fn [] (Snacks.picker.autocmds)) :desc "Autocmds" ]
				[ "<leader>sb" (fn [] (Snacks.picker.lines)) :desc "Buffer Lines" ]
				[ "<leader>sc" (fn [] (Snacks.picker.command_history)) :desc "Command History" ]
				[ "<leader>sC" (fn [] (Snacks.picker.commands)) :desc "Commands" ]
				[ "<leader>sd" (fn [] (Snacks.picker.diagnostics)) :desc "Diagnostics" ]
				[ "<leader>sD" (fn [] (Snacks.picker.diagnostics_buffer)) :desc "Buffer Diagnostics" ]
				[ "<leader>sh" (fn [] (Snacks.picker.help)) :desc "Help Pages" ]
				[ "<leader>sH" (fn [] (Snacks.picker.highlights)) :desc "Highlights" ]
				[ "<leader>si" (fn [] (Snacks.picker.icons)) :desc "Icons" ]
				[ "<leader>sj" (fn [] (Snacks.picker.jumps)) :desc "Jumps" ]
				[ "<leader>sk" (fn [] (Snacks.picker.keymaps)) :desc "Keymaps" ]
				[ "<leader>sl" (fn [] (Snacks.picker.loclist)) :desc "Location List" ]
				[ "<leader>sm" (fn [] (Snacks.picker.marks)) :desc "Marks" ]
				[ "<leader>sM" (fn [] (Snacks.picker.man)) :desc "Man Pages" ]
				[ "<leader>sp" (fn [] (Snacks.picker.lazy)) :desc "Search for Plugin Spec" ]
				[ "<leader>sq" (fn [] (Snacks.picker.qflist)) :desc "Quickfix List" ]
				[ "<leader>sR" (fn [] (Snacks.picker.resume)) :desc "Resume" ]
				[ "<leader>su" (fn [] (Snacks.picker.undo)) :desc "Undo History" ]
				[ "<leader>uC" (fn [] (Snacks.picker.colorschemes)) :desc "Colorschemes" ]
				;; lsp comamnds
				[ "gd" (fn [] (Snacks.picker.lsp_definitions)) :desc "Goto Definition" ]
				[ "gD" (fn [] (Snacks.picker.lsp_declarations)) :desc "Goto Declarationnnn" ]
				[ "gr" (fn [] (Snacks.picker.lsp_references)) :nowait true :desc "References" ]
				[ "gI" (fn [] (Snacks.picker.lsp_implementations)) :desc "Goto Implementation" ]
				[ "gy" (fn [] (Snacks.picker.lsp_type_definitions)) :desc "Goto T[y]pe Definition" ]
				[ "<leader>ss" (fn [] (Snacks.picker.lsp_symbols)) :desc "LSP Symbols" ]
				[ "<leader>sS" (fn [] (Snacks.picker.lsp_workspace_symbols)) :desc "LSP Workspace Symbols" ]
				;; bonus commands
				[ "<leader>n"  (fn [] (Snacks.notifier.show_history)) :desc "Notification History" ]
				[ "<leader>bd" (fn [] (Snacks.bufdelete)) :desc "Delete Buffer" ]
				[ "<leader>cR" (fn [] (Snacks.rename.rename_file)) :desc "Rename File" ]
				[ "<leader>gB" (fn [] (Snacks.gitbrowse)) :desc "Git Browse" :mode [ "n" "v" ] ]
				[ "<leader>gg" (fn [] (Snacks.lazygit)) :desc "Lazygit" ] ]
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
					[[ "<leader>sn" "" :desc "+noice" ]
					[ "<S-Enter>" (fn [] (noice.redirect (vim.fn.getcmdline))) :mode "c" :desc "redirect cmdline" ]
					[ "<leader>snl" (fn [] (noice.cmd "last")) :desc "Noice Last Message" ]
					[ "<leader>snh" (fn [] (noice.cmd "history")) :desc "Noice History" ]
					[ "<leader>sna" (fn [] (noice.cmd "all")) :desc "Noice All" ]
					[ "<leader>snd" (fn [] (noice.cmd "dismiss")) :desc "Dismiss All" ]
					[ "<leader>snt" (fn [] (noice.cmd "pick")) :desc  "Noice Picker (Telescope/FzfLua)" ]
					[ "<c-f>" (fn [] (if (not (lsp.scroll 4)) "<c-f>")) 
						:silent true :expr true :desc "Scroll Forward" :mode ["i" "n" "s"] ]
					[ "<c-b>" (fn [] (if (not (lsp.scroll -4)) "<c-b>")) 
						:silent true :expr true :desc "Scroll Backward" :mode ["i" "n" "s"]]])
		}) 


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
					[ "]t" (fn [] (let [todo (require :todo-comments)] (todo.jump_next))) :desc "next todo comment" ] 
					[ "[t" (fn [] (let [todo (require :todo-comments)] (todo.jump_prev))) :desc "prev todo comment" ]
					[ "<leader>xt" "<cmd>Trouble todo toggle<cr>" :desc "Todo (trouble)" ]
					[ "<leader>xT" "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>" :desc "Todo/Fix/Fixme (Trouble)" ]
          [ "<leader>st" "<cmd>TodoTelescope<cr>" :desc "Todo (telescope)" ]
          [ "<leader>sT" "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>" :desc "todo/fix/fixme (telescope)" ] ]}})


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
