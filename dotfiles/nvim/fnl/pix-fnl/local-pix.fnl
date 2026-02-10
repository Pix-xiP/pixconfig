; (import-macros {: tx} :pix-fnl.macros)

(local pixpad (require :pix.pixpad))
(local pixutils (require :pix.utils))

[
 ; (tx 
	{
	:name "pix.nvim"
	:dir "~/.config/nvim/lua/pix" ;; directory of lua helpers and random code?
	:keys [
		;; scratchpad and command runner
		["<leader>pw" (fn [] (pixpad:spawn_pixpad [""])) :desc "Spawn scratchpad"]
		["<leader>pcw" (fn [] (pixpad:toggle_pixpad)) :desc "Run command, collect output"]
		;; buffer helpers
		["<leader>pmc" (fn [] (pixutils.switch_case)) :desc "Toggle camelCase|snake_cace"]
	]
	}
	; )
]
