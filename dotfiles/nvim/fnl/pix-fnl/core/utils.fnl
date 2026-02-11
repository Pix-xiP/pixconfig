(local utils {})

(fn utils.->str [x]
	(tostring x))

(fn utils.colorscheme [name]
	"set a colorscheme using vim.cmd.colorscheme"
	(let [name (utils.->str name)]
		(vim.cmd.colorscheme name)))

utils
