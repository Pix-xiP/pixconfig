(local utils {})

(fn utils.->str [x]
	(tostring x))

(fn utils.colorscheme [name]
	"set a colorscheme using vim.cmd.colorscheme"
	(let [name (utils.->str name)]
		(vim.cmd.colorscheme name)))

(fn utils.root_pattern [...]
	"return a root_dir function for lsp configs using vim.fs.root markers"
	(let [markers (if (and (= 1 (length [...]))
												 (= "table" (type (select 1 ...))))
									(select 1 ...)
									[...])]
		(fn [startpath]
			(or (vim.fs.root startpath markers)
					(vim.fs.dirname startpath)))))

;; TODO: Actually write log method probably to file
(fn utils.log [...]
	 (each [i (ipairs [...])]
		 (print (select i ...))))

;; return out all our utils
utils
