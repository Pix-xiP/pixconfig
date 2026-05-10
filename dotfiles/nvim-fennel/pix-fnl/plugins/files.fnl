(import-macros {: tx} :pix-fnl.core.macros)

[
 ;; replacement for netrw, allowing for large scale file management
	; (tx "stevearc/oil.nvim"
	; 	{:opts {}
	; 	 :dependencies ["nvim-mini/mini.icons"]
	; 	 ; :cmd ["Oil"]})
	; 	 :lazy false})

	(tx "stevearc/oil.nvim"
  {:cmd ["Oil"]
   :keys [["-" "<cmd>Oil<cr>"]]
   :init (fn []
           ;; If nvim is started with a directory (e.g. `nvim .`), load Oil and open it.
           (vim.api.nvim_create_autocmd "VimEnter"
             {:callback (fn []
                          (let [arg (vim.fn.argv 0)
																lazy (require :lazy)]
                            (when (and arg
                                       (not= arg "")
                                       (= (vim.fn.isdirectory arg) 1))
                              lazy.load {:plugins ["oil.nvim"]}
                              (vim.schedule (fn [] (vim.cmd "Oil"))))))}))
   :opts {}})


 ;; yazi term file manager
	; (tx "mikavilpas/yazi.nvim"
	; 	{:event "VeryLazy"
	; 	 :dependencies ["nvim-lua/plenary.nvim"]
	; 	 :opts {:open_for_directories false}
	; 	 :keys [
	; 					(keymap "<leader>-" (fn [] (let [yazi (require :yazi)] (yazi))) {:desc "Open yazi"})
	; 					(keymap "<leader>cw" (fn [] (let [yazi (require :yazi)] (yazi nil (vim.fn.getcwd)))) {:desc "Open yazi in current directory"})
	; 					]})
]
