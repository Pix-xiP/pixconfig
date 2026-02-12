
(vim.filetype.add {:pattern {".*/hyprland%.conf" "hyprlang"}})
(vim.filetype.add {:pattern {"*.modulemap" "modulemap" }})
(vim.filetype.add {:pattern {"^Brewfile$" "ruby"}})

(vim.api.nvim_create_augroup "RpyFileSettings" {:clear true})
(vim.api.nvim_create_autocmd 
	["BufEnter" "BufWinEnter"] {:pattern "*.rpy"
	                            :group "RpyFileSettings"
															:desc "Settings for rpy files"
															:callback (fn []
																(set vim.opt_local.shiftwidth 4)
																(set vim.opt_local.tabstop 4)
																(set vim.opt_local.softtabstop 4)
																(set vim.opt_local.expandtab true)
																(set vim.opt_local.autoindent true)
																(set vim.opt_local.smartindent true)
																(set vim.opt_local.textwidth 0)
																(set vim.opt_local.wrap false))})

;; treesitter enabled for files (this could be done per filetype)
;; Treesitter autocommand all wrapped up in one:
;; -> Highlights
;; -> Indent
;; -> Folding
(vim.api.nvim_create_autocmd
	"FileType" {:callback
		(fn [args]
			;; do a let name:value chain to extract ft from bo and then lang from ft
			;; local ft = vim.bo[bufnr].filetype
			;; local lang = vim.treesitter.language.get_lang(ft)
			(let [bufnr args.buf
						bo (. vim.bo bufnr)
						ft bo.filetype
						lang (vim.treesitter.language.get_lang ft)]

				(when (and lang
									 ;; ensure language is registered
									 (pcall vim.treesitter.language.add lang)
									 ;; make sure parser is created for this buffer
									 (pcall vim.treesitter.get_parser bufnr lang)
									 ;; highlights
									 (pcall vim.treesitter.start bufnr lang))

					(let [win (vim.fn.bufwinid bufnr)]
						(when (not= win -1)
							(let [wo (. vim.wo win)]
								;; folding (window-local)
								(set wo.foldexpr "v:lua.vim.treesitter.foldexpr()")
								(set wo.foldmethod "expr"))))

					;; indent (buffer-local)
					(set bo.indentexpr "v:lua.require'nvim-treesitter'.indentexpr()"))))})

{}
