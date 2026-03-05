(local utils {})

(fn utils.->str [x]
	(tostring x))

(fn utils.colorscheme [name]
	"set a colorscheme using vim.cmd.colorscheme"
	(let [name (utils.->str name)]
		(vim.cmd.colorscheme name)))

;; TODO: Actually write log method probably to file
(fn utils.log [...]
	 (each [i (ipairs [...])]
		 (print (select i ...))))

;; return out all our utils
utils
