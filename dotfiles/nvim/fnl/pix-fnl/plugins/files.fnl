(import-macros {: tx} :pix-fnl.core.macros)

[
 ;; replacement for netrw, allowing for large scale file management
	(tx "stevearc/oil.nvim"
		{:opts {}
		 :dependencies ["nvim-mini/mini.icons"]
		 :lazy false})

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
