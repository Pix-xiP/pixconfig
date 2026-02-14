(import-macros {: tx : keymap} :pix-fnl.core.macros)

(local flash (require :flash))

[
	;; symbols and quick code lookup of current buffer
  (tx "hedyhli/outline.nvim"
		{:lazy true
		 :cmd ["Outline"]
		 :keys [(keymap "<leader>co" "<cmd>Outline<cr>" {:desc "toggle outline"})]
		 :opts (fn []
			      (let [oc (require :outline.config)
									defaults oc.defaults
									opts {:symbols {:icons []
																	:filter (vim.deepcopy LazyVim.config.kind_filter)}
																	:keymaps {:up_and_jump "<up>"
																						:down_and_jump "<down>"}}]
							
							(each [kind symbol (pairs defaults.symbols.icons)]
								(tset opts.symbols.icons kind
										{:icon (or (. LazyVim.config.icons.kinds kind)
															 symbol.icon)
										:hl symbol.hl}))

							opts))})

	;; complete undo history
	(tx "mbbill/undotree"
		{:lazy true
		 :keys [(keymap "<leader>cu" "<cmd>UndotreeToggle<cr>" {:desc "toggle undotree"})]})

	;; search and replace cross project
	(tx "MagicDuck/grug-far.nvim"
		{:cmd "GrugFar"
		 :keys [(keymap "<leader>sr" (fn [] 
																	 (let [gf (require :grug-far)
																				 ext (if (= vim.bo.buftype "")
																								 (vim.fn.expand "%:e")
																								 nil)
																				 filesFilter (if (and ext (not= ext ""))
																												 (.. "*." ext)
																												 nil)]
																		 (gf.open {:transient true
																							 :prefills {:filesFilter filesFilter}})))
										             {:desc "search and replace"
																 :mode ["n" "v"]})]

		 :opts {:headerMaxWidth 80}})

	;; jump to locations in minimal keystrokes
	(tx "folke/flash.nvim"
		{:event "VeryLazy"
		 :keys [
			 (keymap "s" 
							 (fn [] (flash.jump)) 
							 {:mode ["n" "x" "o"] 
							 :desc "flash"})
			 (keymap "S" 
							 (fn [] (flash.treesitter)) 
							 {:mode ["n" "x" "o"] 
							 :desc "flash treesitter"})
			 (keymap "r" 
							 (fn [] (flash.remote)) 
							 {:mode ["o"] 
							 :desc "remote flash"})
			 (keymap "R" 
							 (fn [] (flash.treesitter_search)) 
							 {:mode ["o" "x"] 
							 :desc "treesitter search"})
			 (keymap "<c-s>" 
							 (fn [] (flash.toggle)) 
							 {:mode ["c"] 
							 :desc "toggle flash search"})]
		 :opts {}})

	;; improved diagnostics
	(tx "folke/trouble.nvim"
  {:cmd ["Trouble"]
   :opts {:modes {:lsp {:win {:position "right"}}}}
   :keys
   [(keymap "<leader>xx"
            "<cmd>Trouble diagnostics toggle<cr>"
            {:desc "Diagnostics (Trouble)"})

    (keymap "<leader>xX"
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>"
            {:desc "Buffer Diagnostics (Trouble)"})

    (keymap "<leader>cs"
            "<cmd>Trouble symbols toggle<cr>"
            {:desc "Symbols (Trouble)"})

    (keymap "<leader>cS"
            "<cmd>Trouble lsp toggle<cr>"
            {:desc "LSP references/definitions/... (Trouble)"})

    (keymap "<leader>xL"
            "<cmd>Trouble loclist toggle<cr>"
            {:desc "Location List (Trouble)"})

    (keymap "<leader>xQ"
            "<cmd>Trouble qflist toggle<cr>"
            {:desc "Quickfix List (Trouble)"})

    ;; [q
    (keymap "[q" (fn []
              (let [trouble (require :trouble)]
                (if (trouble.is_open)
                    (trouble.prev {:skip_groups true
                                   :jump true})
                    (let [[ok err] (pcall vim.cmd.cprev)]
                      (when (not ok)
                        (vim.notify err vim.log.levels.ERROR))))))
            {:desc "Previous Trouble/Quickfix Item"})

    ;; ]q
    (keymap "]q" (fn []
              (let [trouble (require :trouble)]
                (if (trouble.is_open)
                    (trouble.next {:skip_groups true
                                   :jump true})
                    (let [[ok err] (pcall vim.cmd.cnext)]
                      (when (not ok)
                        (vim.notify err vim.log.levels.ERROR))))))
            {:desc "Next Trouble/Quickfix Item"})]})
]

