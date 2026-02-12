(let [g vim.g
			opt vim.opt
			vfn vim.fn
			env vim.env]

	;; leader key
	(set g.mapleader " ")
	(set g.localleader " ")
	(set g.pix_var "Pix's Neovim")

	;; opt commands
	(set opt.relativenumber true)
	(set opt.scrolloff 10) ;; number of lines above and below cursor
	(set opt.signcolumn "yes") ;; always show the signcolumn, otherwise it would shift the text each time
	(set opt.colorcolumn "120") ;; line to show 'max width'
	(set opt.termguicolors true)
	(set opt.ignorecase true) ;; search case insensitive
	(set opt.smartcase true) ;; search case sensitive IF capitial starting letter
	(set opt.inccommand "split") ;; preview of changes during 'sub' (s/to/from/g)
	(set opt.autowrite true) ;; enable autowrite
	(set opt.clipboard (if env.SSH_TTY "" "unnamedplus")) ;; sync with system clipboard
	(set opt.completeopt "menu,menuone,noselect")
	(set opt.conceallevel 2) ;; hide * markup for bold and italic but not marks with substitutions
	(set opt.confirm true) ;; confirm to save changes before exiting modified buffer
	(set opt.cursorline true) ;; highlight current line
	(set opt.expandtab false) ;; tabs instead of spaces
	(set opt.tabstop 2) ;; number of spaces per tab
	(set opt.fillchars {:foldopen ""
											:foldclose ""
											:fold " "
											:foldsep " "
											:diff "╱"
											:eob " "})
	(set opt.foldlevel 99)
	(set opt.grepformat "%f:%l:%c:%m")
	(set opt.grepprg "rg --vimgrep")
	(set opt.jumpoptions "view")
	(set opt.laststatus 3) ;; global statusline
	(set opt.linebreak true) ;; wrap lines at convenient points
	(set opt.list true) ;; show some invisible chars (tabs...)
	(set opt.mouse "a") ;; enable mouse mode
	(set opt.number true) ;; show line numbers
	(set opt.pumblend 10);; popup blend
	(set opt.pumheight 10) ;; maximum number of entries in a popup
	(set opt.sessionoptions ["buffers" "curdir" "tabpages" "winsize" "help" "globals" "skiprtp" "folds"])
	(set opt.shiftround true) ;; round indent
	(set opt.shiftwidth 2) ;; size of an indent
	(set opt.showmode false) ;; don't show mode, we use statusline
	(set opt.sidescrolloff 8) ;; number of columns to scroll horizontally
	(set opt.smartindent true) ;; insert indents automatically
	(set opt.spelllang ["en"]) ;; spellcheckin
	(set opt.splitbelow true) ;; open new windows below current
	(set opt.splitkeep "screen") ;; keep current window when splitting
	(set opt.splitright true) ;; open new windows right of current
	(set opt.undofile true)
	(set opt.undolevels 10000)
	(set opt.updatetime 200)
	(set opt.virtualedit "block") ;; allow cursor to move where there is no text in visual block mode
	(set opt.wildmode "longest:full,full") ;; cli completion mode
	(set opt.winminwidth 5) ;; minimum active window width
	(set opt.wrap false) ;; disable line wrap by default

	(opt.spelloptions:append "noplainbuffer")
	(opt.shortmess:append {:W true :I true :c true :C true})

	;; globals
	(set g.netrw_banner 0) ;; some basic netrw settings if others fail
	(set g.netrw_browse_split 4)
	(set g.netrw_liststyle 3)
	(set g.netrw_winsize -28)
	(set g.root_spec ["lsp" ".git" "lua" "cwd"]) ;; root dir detection
	(set g.lazygit_config true)
	(set g.autoformat true)
	(set g.deprecation_warnings false) ;; don't hide deprecation warnings
	(set g.bigfile_size (* 1024 1024 1.5)) ;; 'bigfile' for use with snacks to allow faster loading of large files. 1.5mb
	(set g.trouble_lualine true) ;; show current document symbols from Trouble in Lualine
	(set g.markdown_recommended_style 0) ;; fix markdown indentation settings


	(if (= (vfn.has "nvim-0.10") 1)
			(do
				(set opt.smoothscroll true)
				(set opt.foldmethod "expr")
				(set opt.foldtext ""))
			(do
				(set opt.foldmethod "indent")
				nil))

)
