(import-macros {: tx : keymap : wk-spec : wk-entry} :pix-fnl.core.macros)

;; makes: { "lhs" group = "...", ...}

[
	(tx "folke/which-key.nvim"
		{:event "VeryLazy"
		 :opts_extend ["spec"]
		 :opts {
				:preset "helix"
				:defaults []
				:spec [(wk-spec ["n" "v"]
								[(wk-entry "<leader><tab>" {:group "tabs"})
								 (wk-entry "<leader>c" {:group "code"})
								 (wk-entry "<leader>d" {:group "debug" })
								 (wk-entry "<leader>dp" {:group "profiler" })
								 (wk-entry "<leader>f" {:group "file/find" })
								 (wk-entry "<leader>g" {:group "git" })
								 (wk-entry "<leader>gh" {:group "hunks" })
								 (wk-entry "<leader>q" {:group "quit/session" })
								 (wk-entry "<leader>s" {:group "search" })
								 (wk-entry "<leader>u" {:group "ui" :icon {:icon "󰙵 " :color "cyan"}})
								 (wk-entry "<leader>x" {:group "diagnostics/quickfix" :icon {:icon "󱖫 " :color "green"}})
								 (wk-entry "[" {:group "prev" })
								 (wk-entry "]" {:group "next" })
								 (wk-entry "g" {:group "goto" })
								 (wk-entry "gs" {:group "surround" })
								 (wk-entry "z" {:group "fold" })
								 (wk-entry "<leader>b" {:group "buffer"
													              :expand (fn [] (let [extras (require :which-key.extras)] ((. extras.expand :buf))))})
								 (wk-entry "<leader>w" {:group "windows" :proxy "<c-w>" :expand (fn []
																																									(let [extras (require :which-key.extras)]
																																										((. extras.expand :win))))})
								 (wk-entry "gx" {:desc "Open with system app"})])]}

				:keys [
					(keymap "<leader>?" (fn [] (let [wk (require :which-key)]
																			 (wk.show {:global false})))
									            {:desc "buffer keymaps (which-key)"})
					(keymap "<c-w><space>" (fn [] (let [wk (require :which-key)]
																					(wk.show {:keys "<c-w>" :loop true})))
															{:desc "window hydra mode (which-key)"})]

				:config (fn [_ opts] (let [wk (require :which-key)] (wk.setup opts)))})



]
